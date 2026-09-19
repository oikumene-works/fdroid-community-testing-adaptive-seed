#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2154

# shellcheck source=lib/android.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/lib/android.sh"
cd -- "$repo_root"

approval=""
case_args=()
while (($#)); do
    case "$1" in
        --approval) approval="${2:-}"; shift 2 ;;
        --case) case_args+=("$1" "${2:-}"); shift 2 ;;
        *) die "Unknown argument: $1" ;;
    esac
done
resolve_case "${case_args[@]}"
load_case
require_real_case
require_approval_token cleanup "$approval"
require_tools adb emulator ss pgrep
for name in APP_ID VERSION_CODE; do require_value "$name"; done
load_android_config
prepare_android_directories
pid_path="$repo_root/.local/runtime/${CASE_ID}-emulator.pid"
emulator_pid=""
if [[ -f "$pid_path" ]]; then
    IFS= read -r emulator_pid < "$pid_path"
    [[ "$emulator_pid" =~ ^[0-9]+$ ]] || die "Invalid recorded emulator PID"
fi

wait_for_stop() {
    local stopped=false
    for _ in $(seq 1 30); do
        if ! adb_isolated devices | awk -v serial="$expected_serial" \
            '$1 == serial {found=1} END {exit found ? 0 : 1}'; then
            stopped=true
            break
        fi
        sleep 1
    done
    $stopped || die "Exact emulator did not stop"
}

wait_for_pid_stop() {
    local pid="$1"
    [[ -n "$pid" ]] || return 0
    for _ in $(seq 1 30); do
        kill -0 "$pid" 2>/dev/null || return 0
        sleep 1
    done
    die "Recorded emulator process remains: $pid"
}

verify_exact_emulator
installed="$(adb_isolated -s "$expected_serial" shell pm path "$APP_ID" \
    2>/dev/null | tr -d '\r' || true)"
[[ -z "$installed" ]] || adb_isolated -s "$expected_serial" uninstall "$APP_ID" >/dev/null
adb_isolated -s "$expected_serial" emu kill >/dev/null || true
wait_for_stop

wait_for_pid_stop "$emulator_pid"

"$repo_root/scripts/start-disposable-avd.sh" --case "$CASE_ID" \
    --approval "cleanup:${CASE_ID}" --cleanup-wipe
IFS= read -r cleanup_pid < "$pid_path"
[[ "$cleanup_pid" =~ ^[0-9]+$ ]] || die "Invalid cleanup-wipe emulator PID"
verify_exact_emulator
installed="$(adb_isolated -s "$expected_serial" shell pm path "$APP_ID" \
    2>/dev/null | tr -d '\r' || true)"
[[ -z "$installed" ]] || die "Candidate remains after AVD wipe"
downloads="$(adb_isolated -s "$expected_serial" shell \
    'find /sdcard/Download -mindepth 1 -maxdepth 1 -print 2>/dev/null' | tr -d '\r')"
[[ -z "$downloads" ]] || die "Emulated Downloads is not empty after wipe"
adb_isolated -s "$expected_serial" emu kill >/dev/null || true
wait_for_stop
wait_for_pid_stop "$cleanup_pid"

apk_path="$repo_root/.local/downloads/${CASE_ID}-${APP_ID}-${VERSION_CODE}.apk"
rm -f -- "$apk_path" "$repo_root/.local/runtime/${CASE_ID}-emulator.log" \
    "$repo_root/.local/runtime/${CASE_ID}-emulator.pid"
evidence="$repo_root/.local/evidence/$CASE_ID"
if [[ -d "$evidence" ]]; then
    [[ "$evidence" == "$repo_root/.local/evidence/$CASE_ID" ]] || \
        die "Unexpected evidence path"
    rm -rf -- "$evidence"
fi
case_transient="$repo_root/.local/cases/$CASE_ID"
if [[ -d "$case_transient" ]]; then
    [[ "$case_transient" == "$repo_root/.local/cases/$CASE_ID" ]] || \
        die "Unexpected transient case path"
    rm -rf -- "$case_transient"
fi
adb_isolated kill-server >/dev/null 2>&1 || true

ports_closed=false
for _ in $(seq 1 10); do
    listening="$(ss -ltn | awk '{print $4}' \
        | rg ":(${EMULATOR_PORT}|$((EMULATOR_PORT + 1))|${ADB_SERVER_PORT})$" || true)"
    if [[ -z "$listening" ]]; then
        ports_closed=true
        break
    fi
    sleep 1
done
$ports_closed || die "A project emulator or isolated-ADB port remains open"
related="$(pgrep -af 'emulator|qemu-system' || true)"
if rg -Fq -- "-avd $AVD_NAME" <<<"$related" || \
    rg -Fq -- "@$AVD_NAME" <<<"$related" || \
    rg -Fq -- "$ANDROID_AVD_HOME" <<<"$related"; then
    die "A project AVD process remains after cleanup"
fi
[[ ! -e "$apk_path" && ! -e "$evidence" && ! -e "$case_transient" && \
    ! -e "$repo_root/.local/runtime/${CASE_ID}-emulator.log" && \
    ! -e "$pid_path" ]] || die "Transient case artifacts remain after cleanup"

echo "CLEANUP_VERIFICATION=PASS"
echo "The package and Downloads were empty after a clean wipe."
echo "The emulator, isolated ADB server, project ports, processes, and transient files are absent."
