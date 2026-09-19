#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2154

# shellcheck source=lib/common.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
cd -- "$repo_root"

resolve_case "$@"
load_case
require_real_case
require_tools glab gh jq curl base64 sha256sum xmllint sort sed date
for name in GITLAB_TARGET_PROJECT_ID GITLAB_SOURCE_PROJECT_ID MR_IID \
    EXPECTED_MR_SHA EXPECTED_PIPELINE_ID EXPECTED_BUILD_JOB_ID \
    EXPECTED_BUILD_JOB_NAME EXPECTED_ARTIFACT_FILENAME EXPECTED_REQUIRED_LABELS \
    EXPECTED_FORBIDDEN_LABELS EXPECTED_LATEST_NON_SYSTEM_NOTE_ID METADATA_PATH \
    EXPECTED_METADATA_SHA256 APP_ID VERSION_NAME VERSION_CODE UPSTREAM_REPOSITORY \
    UPSTREAM_PROVIDER UPSTREAM_TAG UPSTREAM_SOURCE_COMMIT EXPECTED_RELEASE_TARGET \
    SOURCE_MANIFEST_PATH EXPECTED_SOURCE_PERMISSIONS UPSTREAM_APK_NAME \
    UPSTREAM_APK_SHA256 CODE_QUALITY_APK_URL PUBLIC_CLAIM_PATHS \
    EXPECTED_PUBLIC_CLAIMS_SHA256 CLAIM_REVIEW_FILE EXPECTED_CLAIM_REVIEW_SHA256 \
    CLAIM_REVIEW_STATUS; do
    require_value "$name"
done
[[ "$UPSTREAM_PROVIDER" == "github" ]] || die "Unsupported upstream provider"
[[ "$UPSTREAM_REPOSITORY" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]] || \
    die "Invalid upstream repository"

mr_json="$(glab api "projects/${GITLAB_TARGET_PROJECT_ID}/merge_requests/${MR_IID}")"
jq -e --arg sha "$EXPECTED_MR_SHA" --argjson pipeline "$EXPECTED_PIPELINE_ID" '
    .state == "opened" and .draft == false and .sha == $sha and
    .has_conflicts == false and .blocking_discussions_resolved == true and
    .head_pipeline.id == $pipeline and .head_pipeline.sha == $sha and
    .head_pipeline.status == "success"
' >/dev/null <<<"$mr_json" || die "MR state no longer matches preflight"

while IFS= read -r label; do
    jq -e --arg label "$label" '.labels | index($label) != null' >/dev/null \
        <<<"$mr_json" || die "Required label is missing: $label"
done < <(csv_lines "$EXPECTED_REQUIRED_LABELS")
while IFS= read -r label; do
    jq -e --arg label "$label" '.labels | index($label) == null' >/dev/null \
        <<<"$mr_json" || die "Forbidden label is present: $label"
done < <(csv_lines "$EXPECTED_FORBIDDEN_LABELS")

job_json="$(glab api "projects/${GITLAB_SOURCE_PROJECT_ID}/jobs/${EXPECTED_BUILD_JOB_ID}")"
jq -e --arg sha "$EXPECTED_MR_SHA" --arg name "$EXPECTED_BUILD_JOB_NAME" \
    --arg filename "$EXPECTED_ARTIFACT_FILENAME" \
    --argjson pipeline "$EXPECTED_PIPELINE_ID" \
    --argjson job "$EXPECTED_BUILD_JOB_ID" '
    .id == $job and .name == $name and .pipeline.id == $pipeline and
    .commit.id == $sha and .status == "success" and
    .artifacts_file.filename == $filename
' >/dev/null <<<"$job_json" || die "Build job no longer matches preflight"

artifact_expiry="$(jq -r '.artifacts_expire_at // empty' <<<"$job_json")"
if [[ -n "$artifact_expiry" ]]; then
    (( $(date --date="$artifact_expiry" +%s) > $(date +%s) )) || \
        die "Build artifact expired at $artifact_expiry"
fi
http_code="$(curl --silent --show-error --location --head --output /dev/null \
    --write-out '%{http_code}' "$CODE_QUALITY_APK_URL")"
[[ "$http_code" == "200" ]] || die "APK availability check returned HTTP $http_code"

encoded_metadata="$(jq -rn --arg value "$METADATA_PATH" '$value | @uri')"
metadata_sha256="$(glab api \
    "projects/${GITLAB_SOURCE_PROJECT_ID}/repository/files/${encoded_metadata}/raw?ref=${EXPECTED_MR_SHA}" \
    | sha256sum | cut -d' ' -f1)"
[[ "$metadata_sha256" == "$EXPECTED_METADATA_SHA256" ]] || \
    die "Metadata digest changed: $metadata_sha256"

tag_json="$(gh api "repos/${UPSTREAM_REPOSITORY}/git/ref/tags/${UPSTREAM_TAG}")"
tag_type="$(jq -r '.object.type' <<<"$tag_json")"
tag_sha="$(jq -r '.object.sha' <<<"$tag_json")"
if [[ "$tag_type" == "tag" ]]; then
    tag_json="$(gh api "repos/${UPSTREAM_REPOSITORY}/git/tags/${tag_sha}")"
    tag_type="$(jq -r '.object.type' <<<"$tag_json")"
    tag_sha="$(jq -r '.object.sha' <<<"$tag_json")"
fi
[[ "$tag_type" == "commit" && "$tag_sha" == "$UPSTREAM_SOURCE_COMMIT" ]] || \
    die "Upstream tag mapping changed"

release_json="$(gh api "repos/${UPSTREAM_REPOSITORY}/releases/tags/${UPSTREAM_TAG}")"
jq -e --arg target "$EXPECTED_RELEASE_TARGET" --arg name "$UPSTREAM_APK_NAME" \
    --arg digest "sha256:${UPSTREAM_APK_SHA256}" '
    .draft == false and .prerelease == false and .target_commitish == $target and
    any(.assets[]; .name == $name and .state == "uploaded" and .digest == $digest)
' >/dev/null <<<"$release_json" || die "Upstream release or APK digest changed"

encoded_manifest="$(jq -rn --arg value "$SOURCE_MANIFEST_PATH" '$value | @uri')"
manifest="$(gh api \
    "repos/${UPSTREAM_REPOSITORY}/contents/${encoded_manifest}?ref=${UPSTREAM_SOURCE_COMMIT}" \
    --jq .content | base64 --decode)"
actual_permissions="$(xmllint --xpath \
    '//*[local-name()="uses-permission" or local-name()="uses-permission-sdk-23"]/@*[local-name()="name"]' \
    - 2>/dev/null <<<"$manifest" \
    | sed -n 's/^[^=]*="\([^"]*\)"$/\1/p' | sort -u || true)"
expected_permissions="$(permission_lines "$EXPECTED_SOURCE_PERMISSIONS" | sort -u)"
[[ "$actual_permissions" == "$expected_permissions" ]] || \
    die "Exact source permission set changed"

source_surface="$("$repo_root/scripts/inspect-source-surface.sh" --case "$CASE_ID" --machine)"
source_surface_sha256="$(printf '%s\n' "$source_surface" | sha256sum | cut -d' ' -f1)"
[[ "$source_surface_sha256" == "$EXPECTED_SOURCE_SURFACE_SHA256" ]] || \
    die "Source surface changed: $source_surface_sha256"

case "$CLAIM_REVIEW_STATUS" in PASS | CLARIFICATION_REQUIRED) ;; *) die "Invalid claim status" ;; esac
verify_digest_bound_file "$CLAIM_REVIEW_FILE" "$EXPECTED_CLAIM_REVIEW_SHA256" \
    "public claim review"
public_claims="$("$repo_root/scripts/inspect-public-claims.sh" --case "$CASE_ID" --machine)"
public_claims_sha256="$(printf '%s\n' "$public_claims" | sha256sum | cut -d' ' -f1)"
[[ "$public_claims_sha256" == "$EXPECTED_PUBLIC_CLAIMS_SHA256" ]] || \
    die "Public claim surface changed: $public_claims_sha256"

notes_json="$(glab api \
    "projects/${GITLAB_TARGET_PROJECT_ID}/merge_requests/${MR_IID}/notes?per_page=100&sort=desc&order_by=created_at")"
latest_note_id="$(jq -r '[.[] | select(.system == false)] | max_by(.created_at).id' \
    <<<"$notes_json")"
[[ "$latest_note_id" == "$EXPECTED_LATEST_NON_SYSTEM_NOTE_ID" ]] || \
    die "New non-system note detected: $latest_note_id"

echo "READ_ONLY_RECHECK=PASS"
echo "CASE=$CASE_ID"
echo "MR=!$MR_IID"
echo "HEAD=$EXPECTED_MR_SHA"
echo "PIPELINE=$EXPECTED_PIPELINE_ID"
echo "BUILD_JOB=$EXPECTED_BUILD_JOB_ID"
echo "METADATA_SHA256=$metadata_sha256"
echo "SOURCE_SURFACE_SHA256=$source_surface_sha256"
echo "PUBLIC_CLAIMS_SHA256=$public_claims_sha256"
echo "CLAIM_REVIEW_STATUS=$CLAIM_REVIEW_STATUS"
echo "APK_HEAD_HTTP=$http_code"
echo "ARTIFACT_EXPIRES=${artifact_expiry:-none reported}"
echo "SOURCE=$UPSTREAM_SOURCE_COMMIT"
echo "LATEST_NON_SYSTEM_NOTE=$latest_note_id"
echo "No APK was downloaded and no emulator or ADB action occurred."
