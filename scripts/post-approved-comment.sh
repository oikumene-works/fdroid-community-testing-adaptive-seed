#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR
# shellcheck disable=SC2154

# shellcheck source=lib/common.sh
source "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
cd -- "$repo_root"

approval_sha256=""
approval_destination=""
approval_account=""
case_args=()
while (($#)); do
    case "$1" in
        --approval-sha256) approval_sha256="${2:-}"; shift 2 ;;
        --approval-destination) approval_destination="${2:-}"; shift 2 ;;
        --approval-account) approval_account="${2:-}"; shift 2 ;;
        --case) case_args+=("$1" "${2:-}"); shift 2 ;;
        *) die "Unknown argument: $1" ;;
    esac
done
resolve_case "${case_args[@]}"
load_case
require_real_case
require_tools glab jq sha256sum git mktemp
for name in GITLAB_TARGET_PROJECT_ID GITLAB_TARGET_PROJECT_PATH MR_IID \
    PUBLIC_COMMENT_FILE EXPECTED_PUBLIC_COMMENT_SHA256 EXPECTED_POSTING_USERNAME; do
    require_value "$name"
done
[[ -z "${POSTED_NOTE_ID:-}" ]] || die "Case already records note $POSTED_NOTE_ID"
require_clean_repository_checkpoint

comment="$case_dir/$PUBLIC_COMMENT_FILE"
[[ -f "$comment" ]] || die "Missing canonical comment"
actual="$(sha256sum "$comment" | cut -d' ' -f1)"
[[ "$actual" == "$EXPECTED_PUBLIC_COMMENT_SHA256" ]] || die "Comment digest changed"
normalized="$(printf '%s\n' "$(<"$comment")" | sha256sum | cut -d' ' -f1)"
[[ "$normalized" == "$actual" ]] || \
    die "Canonical comment must end with exactly one newline"
[[ "$approval_sha256" == "$actual" ]] || \
    die "Exact-text approval required: --approval-sha256 '$actual'"
expected_destination="${GITLAB_TARGET_PROJECT_PATH}!${MR_IID}"
[[ "$approval_destination" == "$expected_destination" ]] || \
    die "Exact destination approval required: --approval-destination '$expected_destination'"
[[ "$approval_account" == "$EXPECTED_POSTING_USERNAME" ]] || \
    die "Exact account approval required: --approval-account '$EXPECTED_POSTING_USERNAME'"

username="$(glab api user | jq -r '.username')"
[[ "$username" == "$EXPECTED_POSTING_USERNAME" ]] || \
    die "Authenticated @$username, expected @$EXPECTED_POSTING_USERNAME"
notes_endpoint="projects/${GITLAB_TARGET_PROJECT_ID}/merge_requests/${MR_IID}/notes"
list_notes() {
    glab api "${notes_endpoint}?per_page=100" --paginate --output ndjson
}
matching_notes() {
    list_notes | jq -sc --rawfile body "$comment" --arg username "$username" '
        [.[] | select(.system == false and
            .author.username == $username and
            .body == ($body | rtrimstr("\n")))]'
}

all_body_duplicates="$(list_notes | jq -s --rawfile body "$comment" '
    [.[] | select(.system == false and .body == ($body | rtrimstr("\n")))] | length')"
[[ "$all_body_duplicates" == "0" ]] || die "Exact comment already exists; do not retry"
"$repo_root/scripts/recheck-case.sh" --case "$CASE_ID"

mkdir -p -- "$repo_root/.local/runtime"
response_file="$(mktemp "$repo_root/.local/runtime/${CASE_ID}.post-response.XXXXXX.json")"
trap 'rm -f -- "$response_file"' EXIT
echo "Posting approved SHA-256 $actual"
echo "Destination: ${GITLAB_TARGET_PROJECT_PATH} MR !${MR_IID}"
echo "Account: @$username"
echo "Checkpoint: $checkpoint_head"
echo "Git remote state: $checkpoint_remote_state (grants no external authority)"
if glab api --method POST "$notes_endpoint" \
    --raw-field "body=$(<"$comment")" >"$response_file"; then
    post_status=0
else
    post_status=$?
fi

note_json=""
if ((post_status == 0)) && jq -e --arg username "$username" --rawfile body "$comment" '
    (.id | type) == "number" and (.created_at | type) == "string" and
    .author.username == $username and .body == ($body | rtrimstr("\n"))
' "$response_file" >/dev/null 2>&1; then
    note_json="$(jq -c . "$response_file")"
else
    matches="$(matching_notes)"
    match_count="$(jq 'length' <<<"$matches")"
    if [[ "$match_count" == "1" ]]; then
        note_json="$(jq -c '.[0]' <<<"$matches")"
        echo "Recovered exactly one matching note after an ambiguous response; no retry occurred."
    else
        ambiguity="$repo_root/.local/runtime/${CASE_ID}-posting-ambiguity.json"
        jq -n --arg digest "$actual" --arg destination "$expected_destination" \
            --arg account "$username" --arg checkpoint "$checkpoint_head" \
            --argjson matches "$match_count" '{
                status: "AMBIGUOUS_DO_NOT_RETRY",
                body_sha256: $digest,
                destination: $destination,
                account: $account,
                checkpoint_head: $checkpoint,
                matching_notes: $matches
            }' >"$ambiguity"
        die "Post result is ambiguous ($match_count matching notes); keep $ambiguity and run recover-posted-comment.sh"
    fi
fi

remote_sha256="$(jq -r '.body' <<<"$note_json" | sha256sum | cut -d' ' -f1)"
[[ "$remote_sha256" == "$actual" ]] || die "Remote note digest differs: $remote_sha256"
note_id="$(jq -r '.id' <<<"$note_json")"
note_url="https://gitlab.com/${GITLAB_TARGET_PROJECT_PATH}/-/merge_requests/${MR_IID}#note_${note_id}"
receipt="$repo_root/.local/runtime/${CASE_ID}-posted-note.json"
jq --arg body_sha256 "$remote_sha256" --arg destination "$expected_destination" \
    --arg checkpoint_head "$checkpoint_head" --arg web_url "$note_url" '{
        note_id: .id,
        created_at,
        web_url: $web_url,
        author: .author.username,
        body_sha256: $body_sha256,
        destination: $destination,
        checkpoint_head: $checkpoint_head
    }' <<<"$note_json" >"$receipt"
rm -f -- "$repo_root/.local/runtime/${CASE_ID}-posting-ambiguity.json"
jq . "$receipt"
echo "Recovery receipt: $receipt"
echo "Record the note ID and remote digest, then remove the receipt at the clean checkpoint."
