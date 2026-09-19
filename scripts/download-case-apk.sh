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
require_approval_token download-apk "$approval"
require_claim_gate
require_qualification_gate
require_tools curl sha256sum sort bwrap timeout mktemp
for name in APP_ID VERSION_NAME VERSION_CODE EXPECTED_MIN_SDK EXPECTED_TARGET_SDK \
    EXPECTED_APK_PERMISSIONS EXPECTED_SIGNING_CERT_SHA256 UPSTREAM_APK_SHA256 \
    EXPECTED_APK_FEATURES EXPECTED_APK_NATIVE_CODE \
    EXPECTED_APK_MANIFEST_XMLTREE_SHA256 CODE_QUALITY_APK_URL; do
    require_value "$name"
done
[[ "$EXPECTED_APK_PERMISSIONS" != "PENDING_APK_QUALIFICATION" ]] || \
    die "APK permission set is still pending qualification"
for pending_name in EXPECTED_APK_FEATURES EXPECTED_APK_NATIVE_CODE \
    EXPECTED_APK_MANIFEST_XMLTREE_SHA256; do
    [[ "${!pending_name}" != "PENDING_APK_QUALIFICATION" ]] || \
        die "APK built surface is still pending qualification: $pending_name"
done
require_clean_repository_checkpoint

"$repo_root/scripts/recheck-case.sh" --case "$CASE_ID"
mkdir -p -- "$repo_root/.local/downloads"
apk_path="$repo_root/.local/downloads/${CASE_ID}-${APP_ID}-${VERSION_CODE}.apk"
[[ ! -e "$apk_path" ]] || die "Refusing to overwrite existing APK"
partial="$(mktemp "$repo_root/.local/downloads/${CASE_ID}.execution.XXXXXX.apk.partial")"
trap 'rm -f -- "$partial"' EXIT
curl --fail --location --proto '=https' --tlsv1.2 --output "$partial" \
    "$CODE_QUALITY_APK_URL"
inspect_apk "$partial"
print_apk_surface
require_apk_permission_match
mv -- "$partial" "$apk_path"
trap - EXIT

echo "APK_EXECUTION_DOWNLOAD=PASS"
echo "CASE=$CASE_ID"
echo "CHECKPOINT_HEAD=$checkpoint_head"
echo "GIT_REMOTE_STATE=$checkpoint_remote_state (grants no external authority)"
echo "APK_PATH=$apk_path"
echo "No installation was performed."
