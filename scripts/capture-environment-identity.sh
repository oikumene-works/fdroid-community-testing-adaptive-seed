#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
case_id=""
approval=""
while (($#)); do
    case "$1" in
        --case) case_id="${2:-}"; shift 2 ;;
        --approval) approval="${2:-}"; shift 2 ;;
        *) echo "Unknown argument: $1" >&2; exit 1 ;;
    esac
done
[[ -n "$case_id" && -n "$approval" ]] || {
    echo "Usage: $0 --case CASE_ID --approval execute:CASE_ID" >&2
    exit 1
}
adb_case=("$repo_root/scripts/case-adb.sh" --case "$case_id" --approval "$approval" --)

echo "DEVICE_UTC=$("${adb_case[@]}" shell date -u '+%Y-%m-%dT%H:%M:%SZ' | tr -d '\r')"
echo "DEVICE_LOCAL=$("${adb_case[@]}" shell date '+%Y-%m-%dT%H:%M:%S%z' | tr -d '\r')"
echo "DEVICE_TIMEZONE=$("${adb_case[@]}" shell getprop persist.sys.timezone | tr -d '\r')"
echo "DEVICE_LOCALE=$("${adb_case[@]}" shell getprop ro.product.locale | tr -d '\r')"
echo "ANDROID_BUILD=$("${adb_case[@]}" shell getprop ro.build.fingerprint | tr -d '\r')"
