#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2153,SC2154
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
# shellcheck source=scripts/lib/apk.sh
source "$script_dir/lib/apk.sh"
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
require_approval_token qualify-apk "$approval"
require_claim_gate
require_tools curl sha256sum sort bwrap timeout mktemp
for name in APP_ID VERSION_NAME VERSION_CODE EXPECTED_MIN_SDK EXPECTED_TARGET_SDK \
    EXPECTED_APK_PERMISSIONS EXPECTED_SIGNING_CERT_SHA256 UPSTREAM_APK_SHA256 \
    EXPECTED_APK_FEATURES EXPECTED_APK_NATIVE_CODE \
    EXPECTED_APK_MANIFEST_XMLTREE_SHA256 CODE_QUALITY_APK_URL; do
    require_value "$name"
done
require_clean_repository_checkpoint

"$repo_root/scripts/recheck-case.sh" --case "$CASE_ID"
mkdir -p -- "$repo_root/.local/downloads"
temp_apk="$(mktemp "$repo_root/.local/downloads/${CASE_ID}.qualification.XXXXXX.apk")"
cleanup() {
    [[ "$temp_apk" == "$repo_root"/.local/downloads/*.qualification.*.apk ]] || \
        die "Unexpected qualification path"
    rm -f -- "$temp_apk"
}
trap cleanup EXIT

curl --fail --location --proto '=https' --tlsv1.2 --output "$temp_apk" \
    "$CODE_QUALITY_APK_URL"
inspect_apk "$temp_apk"
print_apk_surface
cleanup
trap - EXIT

echo "CASE=$CASE_ID"
echo "CHECKPOINT_HEAD=$checkpoint_head"
echo "GIT_REMOTE_STATE=$checkpoint_remote_state (grants no external authority)"
if [[ "$inspected_permission_match" == PENDING || "$inspected_surface_match" == PENDING ]]; then
    echo "APK_QUALIFICATION=RECONCILIATION_REQUIRED"
    echo "Record and review the observed built surface before marking qualification PASS."
else
    require_apk_permission_match
    echo "APK_QUALIFICATION=INSPECTED_AND_DELETED"
fi
echo "The APK was deleted; no installation, emulator, ADB, or upload occurred."
