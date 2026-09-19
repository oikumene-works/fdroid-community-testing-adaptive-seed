#!/usr/bin/env bash
set -euo pipefail
# shellcheck source-path=SCRIPTDIR

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
test_root="$(mktemp -d)"
trap 'rm -rf -- "$test_root"' EXIT
fixture="$test_root/repo"
fake_bin="$test_root/bin"
mock_state="$test_root/state"
passed=0

expect_fail() {
    if "$@" >/dev/null 2>&1; then
        echo "Expected failure: $*" >&2
        exit 1
    fi
    passed=$((passed + 1))
}

mkdir -p "$fixture/scripts/lib" "$fixture/cases/test-case" "$fake_bin" "$mock_state"
cp "$repo_root/scripts/lib/common.sh" "$fixture/scripts/lib/common.sh"
cp "$repo_root/scripts/post-approved-comment.sh" "$fixture/scripts/post-approved-comment.sh"
cp "$repo_root/scripts/recover-posted-comment.sh" "$fixture/scripts/recover-posted-comment.sh"
chmod +x "$fixture/scripts/"*.sh
printf '%s\n' 'Approved test comment.' >"$fixture/cases/test-case/public-comment.md"
comment_sha256="$(sha256sum "$fixture/cases/test-case/public-comment.md" | cut -d' ' -f1)"
cat >"$fixture/cases/test-case/case.env" <<EOF
CASE_ID=test-case
EXAMPLE_ONLY=false
GITLAB_TARGET_PROJECT_ID=36528
GITLAB_TARGET_PROJECT_PATH=fdroid/fdroiddata
MR_IID=47820
PUBLIC_COMMENT_FILE=public-comment.md
EXPECTED_PUBLIC_COMMENT_SHA256=$comment_sha256
EXPECTED_POSTING_USERNAME=audit-tester
POSTED_NOTE_ID=
EOF
printf '%s\n' test-case >"$fixture/cases/active-case"
cat >"$fixture/scripts/recheck-case.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
echo READ_ONLY_RECHECK=PASS
EOF
chmod +x "$fixture/scripts/recheck-case.sh"
printf '%s\n' '.local/' >"$fixture/.gitignore"

cat >"$fake_bin/glab" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
[[ "${1:-}" == api ]] || exit 2
shift
endpoint=""
method=GET
body=""
while (($#)); do
    case "$1" in
        --method) method="$2"; shift 2 ;;
        --raw-field) body="${2#body=}"; shift 2 ;;
        --output) shift 2 ;;
        --paginate) shift ;;
        *) [[ -z "$endpoint" ]] || exit 4; endpoint="$1"; shift ;;
    esac
done
if [[ "$endpoint" == user ]]; then
    printf '%s\n' '{"username":"audit-tester"}'
    exit 0
fi
if [[ "$endpoint" == *'/notes?per_page=100' ]]; then
    [[ ! -f "$MOCK_STATE_DIR/note.json" ]] || cat "$MOCK_STATE_DIR/note.json"
    exit 0
fi
if [[ "$endpoint" == *'/notes' && "$method" == POST ]]; then
    note="$(jq -n --arg body "$body" '{
        id: 123, created_at: "2026-09-20T08:00:00Z",
        author: {username: "audit-tester"}, body: $body, system: false
    }')"
    case "${MOCK_MODE:-normal}" in
        normal) printf '%s\n' "$note" ;;
        ambiguous-success) printf '%s\n' "$note" >"$MOCK_STATE_DIR/note.json"; exit 1 ;;
        fail) exit 1 ;;
        *) exit 5 ;;
    esac
    exit 0
fi
exit 3
EOF
chmod +x "$fake_bin/glab"

git -C "$fixture" init -q
git -C "$fixture" -c user.name=Test -c user.email=test.invalid add .
git -C "$fixture" -c user.name=Test -c user.email=test.invalid commit -qm fixture
git -C "$fixture" remote add origin https://example.invalid/test.git

bash -c '
    set -euo pipefail
    cd "$1"
    source scripts/lib/common.sh
    require_clean_repository_checkpoint
    [[ "$checkpoint_head" == "$(git rev-parse HEAD)" ]]
    [[ "$checkpoint_remotes" == *origin* ]]
' _ "$fixture"
passed=$((passed + 1))

touch "$fixture/uncommitted"
# Positional arguments are intentionally expanded by the nested shell.
# shellcheck disable=SC2016
expect_fail bash -c '
    cd "$1"
    source scripts/lib/common.sh
    require_clean_repository_checkpoint
' _ "$fixture"
rm "$fixture/uncommitted"

unborn="$test_root/unborn"
git -C "$test_root" init -q unborn
# Positional arguments are intentionally expanded by the nested shell.
# shellcheck disable=SC2016
expect_fail bash -c '
    source "$1"
    repo_root="$2"
    cd "$repo_root"
    require_clean_repository_checkpoint
' _ "$fixture/scripts/lib/common.sh" "$unborn"

post_args=(
    --case test-case
    --approval-sha256 "$comment_sha256"
    --approval-destination fdroid/fdroiddata!47820
    --approval-account audit-tester
)
PATH="$fake_bin:$PATH" MOCK_STATE_DIR="$mock_state" \
    "$fixture/scripts/post-approved-comment.sh" "${post_args[@]}" >/dev/null
jq -e '.note_id == 123 and
    .web_url == "https://gitlab.com/fdroid/fdroiddata/-/merge_requests/47820#note_123"' \
    "$fixture/.local/runtime/test-case-posted-note.json" >/dev/null
passed=$((passed + 1))
rm -f "$fixture/.local/runtime/test-case-posted-note.json"

expect_fail env PATH="$fake_bin:$PATH" MOCK_STATE_DIR="$mock_state" \
    "$fixture/scripts/post-approved-comment.sh" \
    --case test-case --approval-sha256 "$comment_sha256" \
    --approval-destination fdroid/fdroiddata!99999 --approval-account audit-tester

PATH="$fake_bin:$PATH" MOCK_STATE_DIR="$mock_state" MOCK_MODE=ambiguous-success \
    "$fixture/scripts/post-approved-comment.sh" "${post_args[@]}" >/dev/null
jq -e '.note_id == 123' "$fixture/.local/runtime/test-case-posted-note.json" >/dev/null
passed=$((passed + 1))
rm -f "$fixture/.local/runtime/test-case-posted-note.json" "$mock_state/note.json"

expect_fail env PATH="$fake_bin:$PATH" MOCK_STATE_DIR="$mock_state" MOCK_MODE=fail \
    "$fixture/scripts/post-approved-comment.sh" "${post_args[@]}"
jq -e '.status == "AMBIGUOUS_DO_NOT_RETRY"' \
    "$fixture/.local/runtime/test-case-posting-ambiguity.json" >/dev/null
jq -n --arg body 'Approved test comment.' '{
    id: 124, created_at: "2026-09-20T08:01:00Z",
    author: {username: "audit-tester"}, body: $body, system: false
}' >"$mock_state/note.json"
PATH="$fake_bin:$PATH" MOCK_STATE_DIR="$mock_state" \
    "$fixture/scripts/recover-posted-comment.sh" --case test-case >/dev/null
jq -e '.note_id == 124 and .recovered_without_retry == true' \
    "$fixture/.local/runtime/test-case-posted-note.json" >/dev/null
passed=$((passed + 1))

for action_script in qualify-case-apk.sh download-case-apk.sh \
    start-disposable-avd.sh post-approved-comment.sh; do
    rg -Fq require_clean_repository_checkpoint "$repo_root/scripts/$action_script"
    passed=$((passed + 1))
done

bash -c '
    set -euo pipefail
    source "$1/scripts/lib/android.sh"
    expected_serial=emulator-5580
    AVD_NAME=FdroidCommunity_Disposable_API34
    EXPECTED_ANDROID_API=34
    adb_isolated() {
        case "$*" in
            devices) printf "List of devices attached\nemulator-5580\tdevice\n" ;;
            "-s emulator-5580 shell getprop ro.kernel.qemu") printf "1\n" ;;
            "-s emulator-5580 emu avd name")
                printf "FdroidCommunity_Disposable_API34\n"
                for _ in $(seq 1 20000); do printf "OK\n"; done
                ;;
            "-s emulator-5580 shell getprop ro.build.version.sdk") printf "34\n" ;;
            *) return 2 ;;
        esac
    }
    verify_exact_emulator
' _ "$repo_root"
passed=$((passed + 1))

echo "Workflow, checkpoint, posting-recovery, and console tests passed: $passed"
