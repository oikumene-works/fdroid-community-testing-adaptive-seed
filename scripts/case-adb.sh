#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2154

# shellcheck source=lib/android.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/lib/android.sh"
cd -- "$repo_root"

approval=""
case_args=()
adb_args=()
while (($#)); do
    case "$1" in
        --approval) approval="${2:-}"; shift 2 ;;
        --case) case_args+=("$1" "${2:-}"); shift 2 ;;
        --) shift; adb_args=("$@"); break ;;
        *) die "Expected --case, --approval, or -- before ADB arguments" ;;
    esac
done
resolve_case "${case_args[@]}"
load_case
require_real_case
require_tools adb
load_android_config
require_approval_token execute "$approval"
require_claim_gate
require_qualification_gate
((${#adb_args[@]} > 0)) || die "No ADB command supplied"

verify_exact_emulator
exec adb -P "$ADB_SERVER_PORT" -s "$expected_serial" "${adb_args[@]}"
