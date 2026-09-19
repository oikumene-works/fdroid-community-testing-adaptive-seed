#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2154

# shellcheck source=lib/android.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/lib/android.sh"
cd -- "$repo_root"

approval=""
cleanup_wipe=false
case_args=()
while (($#)); do
    case "$1" in
        --approval) approval="${2:-}"; shift 2 ;;
        --cleanup-wipe) cleanup_wipe=true; shift ;;
        --case) case_args+=("$1" "${2:-}"); shift 2 ;;
        *) die "Unknown argument: $1" ;;
    esac
done
resolve_case "${case_args[@]}"
load_case
require_real_case
require_tools emulator adb ss setsid rg
load_android_config
prepare_android_directories

if $cleanup_wipe; then
    require_approval_token cleanup "$approval"
else
    require_approval_token start-emulator "$approval"
    require_claim_gate
    require_qualification_gate
    require_clean_repository_checkpoint
    "$repo_root/scripts/recheck-case.sh" --case "$CASE_ID"
fi

emulator -list-avds | rg -Fxq "$AVD_NAME" || die "Project-local AVD does not exist"
adb_emulator_port=$((EMULATOR_PORT + 1))
for port in "$EMULATOR_PORT" "$adb_emulator_port"; do
    if ss -ltn | awk '{print $4}' | rg -q ":${port}$"; then
        die "Configured emulator port is already in use: $port"
    fi
done

emulator_args=(
    -avd "$AVD_NAME" -port "$EMULATOR_PORT" -wipe-data
    -no-snapshot -no-snapshot-save -no-boot-anim
)
if $cleanup_wipe; then
    emulator_args+=(-no-window -gpu swiftshader_indirect)
fi

log_path="$repo_root/.local/runtime/${CASE_ID}-emulator.log"
pid_path="$repo_root/.local/runtime/${CASE_ID}-emulator.pid"
nohup setsid emulator "${emulator_args[@]}" </dev/null >"$log_path" 2>&1 &
emulator_pid=$!
printf '%s\n' "$emulator_pid" > "$pid_path"
complete=false
cleanup_failed_start() {
    if ! $complete && kill -0 "$emulator_pid" 2>/dev/null; then
        kill "$emulator_pid" 2>/dev/null || true
    fi
}
trap cleanup_failed_start EXIT

booted=false
for _ in $(seq 1 120); do
    if ! kill -0 "$emulator_pid" 2>/dev/null; then
        tail -80 "$log_path" >&2 || true
        die "Emulator exited before boot"
    fi
    state="$(adb_isolated -s "$expected_serial" get-state 2>/dev/null || true)"
    boot="$(adb_isolated -s "$expected_serial" shell getprop sys.boot_completed \
        2>/dev/null | tr -d '\r' || true)"
    if [[ "$state" == "device" && "$boot" == "1" ]]; then
        booted=true
        break
    fi
    sleep 2
done
$booted || die "Timed out waiting for exact emulator"
verify_exact_emulator
complete=true
trap - EXIT

echo "EMULATOR_VERIFICATION=PASS"
echo "CASE=$CASE_ID"
if ! $cleanup_wipe; then
    # Assigned by require_clean_repository_checkpoint.
    # shellcheck disable=SC2154
    echo "CHECKPOINT_HEAD=$checkpoint_head"
    # Assigned by require_clean_repository_checkpoint.
    # shellcheck disable=SC2154
    echo "GIT_REMOTE_STATE=$checkpoint_remote_state (grants no external authority)"
fi
echo "SERIAL=$expected_serial"
echo "AVD=$AVD_NAME"
echo "ANDROID_API=$EXPECTED_ANDROID_API"
echo "ADB_SERVER_PORT=$ADB_SERVER_PORT"
