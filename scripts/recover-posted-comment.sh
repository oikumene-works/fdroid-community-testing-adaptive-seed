#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2154

# shellcheck source=lib/common.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
cd -- "$repo_root"

case_args=()
while (($#)); do
    case "$1" in
        --case) case_args+=("$1" "${2:-}"); shift 2 ;;
        *) die "Unknown argument: $1" ;;
    esac
done
resolve_case "${case_args[@]}"
load_case
require_real_case
require_tools glab jq sha256sum git
for name in GITLAB_TARGET_PROJECT_ID GITLAB_TARGET_PROJECT_PATH MR_IID \
    PUBLIC_COMMENT_FILE EXPECTED_PUBLIC_COMMENT_SHA256 EXPECTED_POSTING_USERNAME; do
    require_value "$name"
done
require_clean_repository_checkpoint

comment="$case_dir/$PUBLIC_COMMENT_FILE"
actual="$(sha256sum "$comment" | cut -d' ' -f1)"
[[ "$actual" == "$EXPECTED_PUBLIC_COMMENT_SHA256" ]] || die "Comment digest changed"
normalized="$(printf '%s\n' "$(<"$comment")" | sha256sum | cut -d' ' -f1)"
[[ "$normalized" == "$actual" ]] || die "Canonical comment newline shape changed"
destination="${GITLAB_TARGET_PROJECT_PATH}!${MR_IID}"
ambiguity="$repo_root/.local/runtime/${CASE_ID}-posting-ambiguity.json"
[[ -f "$ambiguity" ]] || die "No posting ambiguity receipt exists"
jq -e --arg digest "$actual" --arg destination "$destination" \
    --arg account "$EXPECTED_POSTING_USERNAME" --arg checkpoint "$checkpoint_head" '
    .status == "AMBIGUOUS_DO_NOT_RETRY" and .body_sha256 == $digest and
    .destination == $destination and .account == $account and
    .checkpoint_head == $checkpoint
' "$ambiguity" >/dev/null || die "Ambiguity receipt no longer matches the exact case"

username="$(glab api user | jq -r '.username')"
[[ "$username" == "$EXPECTED_POSTING_USERNAME" ]] || \
    die "Authenticated @$username, expected @$EXPECTED_POSTING_USERNAME"
notes="$(glab api \
    "projects/${GITLAB_TARGET_PROJECT_ID}/merge_requests/${MR_IID}/notes?per_page=100" \
    --paginate --output ndjson | jq -sc --rawfile body "$comment" --arg username "$username" '
        [.[] | select(.system == false and .author.username == $username and
            .body == ($body | rtrimstr("\n")))]')"
count="$(jq 'length' <<<"$notes")"
[[ "$count" == "1" ]] || die "Recovery found $count matching notes; do not post or retry"
note="$(jq -c '.[0]' <<<"$notes")"
remote_sha256="$(jq -r '.body' <<<"$note" | sha256sum | cut -d' ' -f1)"
[[ "$remote_sha256" == "$actual" ]] || die "Recovered note digest differs"
note_id="$(jq -r '.id' <<<"$note")"
url="https://gitlab.com/${GITLAB_TARGET_PROJECT_PATH}/-/merge_requests/${MR_IID}#note_${note_id}"
receipt="$repo_root/.local/runtime/${CASE_ID}-posted-note.json"
jq --arg body_sha256 "$remote_sha256" --arg destination "$destination" \
    --arg checkpoint_head "$checkpoint_head" --arg web_url "$url" '{
        note_id: .id,
        created_at,
        web_url: $web_url,
        author: .author.username,
        body_sha256: $body_sha256,
        destination: $destination,
        checkpoint_head: $checkpoint_head,
        recovered_without_retry: true
    }' <<<"$note" >"$receipt"
rm -f -- "$ambiguity"
jq . "$receipt"
echo "Recovered exactly one note without retrying the mutation."
