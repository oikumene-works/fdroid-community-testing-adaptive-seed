#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2154

# shellcheck source=lib/common.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
cd -- "$repo_root"

case_id_arg="${1:-}"
[[ "$case_id_arg" =~ ^[a-z0-9][a-z0-9-]*$ ]] || die "Usage: $0 CASE_ID"
resolve_case --case "$case_id_arg"
load_case
require_real_case
template_marker="CHANGE""ME"
if rg -n -F "$template_marker" "$case_dir"; then
    die "Refusing to activate a case with unresolved template values"
fi
require_claim_gate
require_qualification_gate
[[ "$EXPECTED_APK_PERMISSIONS" != "PENDING_APK_QUALIFICATION" ]] || \
    die "Built APK permissions have not been reconciled"
for pending_name in EXPECTED_APK_FEATURES EXPECTED_APK_NATIVE_CODE \
    EXPECTED_APK_MANIFEST_XMLTREE_SHA256; do
    [[ "${!pending_name}" != "PENDING_APK_QUALIFICATION" ]] || \
        die "Built APK surface has not been reconciled: $pending_name"
done
require_clean_repository_checkpoint

printf '%s\n' "$CASE_ID" > cases/active-case
echo "Active case: $CASE_ID"
echo "Source checkpoint: $checkpoint_head"
echo "Git remote state: $checkpoint_remote_state (grants no external authority)"
