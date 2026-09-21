#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd -- "$repo_root"

mkdir -p -- .local/runtime
test_root="$(mktemp -d "$repo_root/.local/runtime/seed-grow-test.XXXXXX")"
gitless_root=""
cleanup() {
    [[ "$test_root" == "$repo_root"/.local/runtime/seed-grow-test.* ]] || {
        echo "Unexpected seed-grow test path" >&2
        exit 1
    }
    rm -rf -- "$test_root"
    if [[ -n "$gitless_root" ]]; then
        [[ "$gitless_root" == /tmp/seed-grow-gitless.* ]] || {
            echo "Unexpected Git-less test path" >&2
            exit 1
        }
        rm -rf -- "$gitless_root"
    fi
}
trap cleanup EXIT

require_output() {
    local output="$1"
    local expected="$2"
    [[ "$output" == *"$expected"* ]] || {
        printf 'Seed output did not contain: %s\n' "$expected" >&2
        exit 1
    }
}

reject_output() {
    local output="$1"
    local unexpected="$2"
    [[ "$output" != *"$unexpected"* ]] || {
        printf 'Seed output unexpectedly contained: %s\n' "$unexpected" >&2
        exit 1
    }
}

snapshot_local_state() {
    if [[ ! -d .local ]]; then
        echo "LOCAL_STATE=ABSENT"
        return
    fi
    find .local -mindepth 1 -printf '%P\t%y\t%s\n' | sort
    find .local -type f -exec sha256sum {} + | sort
}

before_status="$(git status --short)"
before_local="$(snapshot_local_state)"
normal_output="$(./seed grow)"
after_status="$(git status --short)"
after_local="$(snapshot_local_state)"
[[ "$before_status" == "$after_status" ]] || {
    echo "Read-only grow changed tracked or untracked workspace state" >&2
    exit 1
}
[[ "$before_local" == "$after_local" ]] || {
    echo "Read-only grow changed ignored local state" >&2
    exit 1
}
require_output "$normal_output" "ADAPTIVE SEED DISCOVERY"
require_output "$normal_output" "SEED_STATUS=GROWTH_PROPOSAL"
# The development worktree may legitimately have absent, exact, or conflicting
# ignored-local profile state. Exact state-specific proposals are exercised in
# controlled repositories below; this live-root check owns state preservation.
require_output "$normal_output" "PROPOSED_STEP="
require_output "$normal_output" "DONE_WHEN="
reject_output "$normal_output" "PROPOSED_SLICE="
reject_output "$normal_output" "STOP="
require_output "$normal_output" "READY       seed-capability:github-adapter"
require_output "$normal_output" "client and network readiness are untested"
require_output "$normal_output" "CHOICE="
require_output "$normal_output" "No files were changed. No network or Android action was performed."

nested_copy="$test_root/nested-copy"
mkdir -p -- "$nested_copy"
cp -- seed "$nested_copy/seed"
chmod +x "$nested_copy/seed"
nested_output="$("$nested_copy/seed" grow)"
require_output "$nested_output" \
    "UNKNOWN     workspace:git                  seed directory is not a Git worktree root"
require_output "$nested_output" \
    "PROPOSED_STEP=Open a cloned copy of this seed before creating a local profile."
require_output "$nested_output" "CHOICE=Request cloning instructions or stop."
[[ ! -e "$nested_copy/.local" ]] || {
    echo "Nested-copy discovery unexpectedly created local state" >&2
    exit 1
}

gitless_root="$(mktemp -d /tmp/seed-grow-gitless.XXXXXX)"
cp -- seed "$gitless_root/seed"
chmod +x "$gitless_root/seed"
gitless_before="$(find "$gitless_root" -mindepth 1 -printf '%P\t%y\t%m\t%s\n' | sort;
    find "$gitless_root" -type f -exec sha256sum {} + | sort)"
gitless_output="$("$gitless_root/seed" grow)"
require_output "$gitless_output" \
    "UNKNOWN     workspace:git                  seed directory is not a Git worktree root"
require_output "$gitless_output" \
    "PROPOSED_STEP=Open a cloned copy of this seed before creating a local profile."
require_output "$gitless_output" \
    "EFFECTS=No changes; this seed will not initialize Git, clone files, or replace this copy."
require_output "$gitless_output" \
    "DONE_WHEN=Safe cloning options have been explained without changing this copy."
require_output "$gitless_output" "CHOICE=Request cloning instructions or stop."
if "$gitless_root/seed" grow --apply-profile \
    --approval create-profile:linux-reference \
    >"$test_root/gitless-apply.out" 2>"$test_root/gitless-apply.err"; then
    echo "Git-less copy unexpectedly accepted the profile guard" >&2
    exit 1
fi
rg -Fq "PROFILE_STATUS=UNAVAILABLE" "$test_root/gitless-apply.out" || {
    echo "Git-less profile refusal did not report its status" >&2
    exit 1
}
rg -Fq "requires this seed directory to be a Git worktree root" \
    "$test_root/gitless-apply.err" || {
    echo "Git-less profile refusal did not name the prerequisite" >&2
    exit 1
}
gitless_after="$(find "$gitless_root" -mindepth 1 -printf '%P\t%y\t%m\t%s\n' | sort;
    find "$gitless_root" -type f -exec sha256sum {} + | sort)"
[[ "$gitless_before" == "$gitless_after" && ! -e "$gitless_root/.git" &&
   ! -e "$gitless_root/.local" ]] || {
    echo "Git-less growth changed the extracted copy" >&2
    exit 1
}

git_missing_path="$test_root/git-missing-path"
mkdir -p -- "$git_missing_path"
printf '%s\n' '#!/bin/sh' 'printf "Linux\\n"' > "$git_missing_path/uname"
printf '%s\n' '#!/bin/sh' 'exit 0' > "$git_missing_path/bash"
chmod +x "$git_missing_path/uname" "$git_missing_path/bash"
git_missing_output="$(PATH="$git_missing_path" /usr/bin/bash ./seed grow)"
require_output "$git_missing_output" "MISSING     command:git"
require_output "$git_missing_output" \
    "PROPOSED_STEP=Open a cloned copy of this seed before creating a local profile."

empty_path="$test_root/empty-path"
mkdir -p -- "$empty_path"
missing_output="$(PATH="$empty_path" /usr/bin/bash ./seed grow)"
require_output "$missing_output" "UNKNOWN     host:operating-system"
require_output "$missing_output" "MISSING     command:git"
require_output "$missing_output" "MISSING     command:bwrap"
require_output "$missing_output" "Review the unsupported or missing host foundation"

darwin_path="$test_root/darwin-path"
mkdir -p -- "$darwin_path"
printf '%s\n' '#!/bin/sh' 'printf "Darwin\\n"' > "$darwin_path/uname"
chmod +x "$darwin_path/uname"
darwin_output="$(PATH="$darwin_path" /usr/bin/bash ./seed grow)"
require_output "$darwin_output" "UNSUPPORTED host:operating-system"
require_output "$darwin_output" "Darwin has no reviewed execution lane"
require_output "$darwin_output" "UNSUPPORTED host:kvm-access"

if ./seed grow --apply >"$test_root/apply.out" 2>"$test_root/apply.err"; then
    echo "Grow unexpectedly accepted the broad --apply option" >&2
    exit 1
fi
rg -Fq "exact preview and its named apply boundary" "$test_root/apply.err" || {
    echo "Grow did not explain the rejected broad apply override" >&2
    exit 1
}

if ./seed unknown >"$test_root/unknown.out" 2>"$test_root/unknown.err"; then
    echo "Unknown seed command unexpectedly succeeded" >&2
    exit 1
fi
rg -Fq "Unknown seed command" "$test_root/unknown.err" || {
    echo "Unknown seed command did not report the invocation error" >&2
    exit 1
}

profile_repo="$test_root/profile-repo"
profile_sdk="$profile_repo/android-sdk"
mkdir -p -- "$profile_repo/scripts" "$profile_sdk"
cp -- seed "$profile_repo/seed"
chmod +x "$profile_repo/seed"
for adapter in inspect-source-surface.sh inspect-public-claims.sh recheck-case.sh; do
    printf '%s\n' '#!/bin/sh' 'exit 0' > "$profile_repo/scripts/$adapter"
    chmod +x "$profile_repo/scripts/$adapter"
done
printf '%s\n' \
    '#!/usr/bin/env bash' \
    'set -euo pipefail' \
    'mkdir -p -- .local/runtime' \
    ': > .local/runtime/mock-check-all' \
    'rm -f -- .local/runtime/mock-check-all' \
    'echo "MOCK_CHECK_ALL=PASS"' \
    > "$profile_repo/scripts/check-all.sh"
printf '%s\n' \
    '#!/usr/bin/env bash' \
    'set -euo pipefail' \
    'mkdir -p -- .local/runtime' \
    ': > .local/runtime/mock-fictional-dry-run' \
    'rm -f -- .local/runtime/mock-fictional-dry-run' \
    'echo "MOCK_FICTIONAL_DRY_RUN=PASS"' \
    > "$profile_repo/scripts/fictional-dry-run.sh"
chmod +x "$profile_repo/scripts/check-all.sh" \
    "$profile_repo/scripts/fictional-dry-run.sh"
git -C "$profile_repo" init -q

initial_profile_output="$(ANDROID_SDK_ROOT="$profile_sdk" \
    "$profile_repo/seed" grow)"
require_output "$initial_profile_output" \
    "PROPOSED_STEP=Preview an ignored local profile for the existing Linux reference lane."
require_output "$initial_profile_output" \
    "DONE_WHEN=The exact profile has been shown without writing it."
require_output "$initial_profile_output" \
    "CHOICE=Preview this profile, request details, or stop."

preview_output="$(ANDROID_SDK_ROOT="$profile_sdk" \
    "$profile_repo/seed" grow --preview-profile)"
require_output "$preview_output" "PROFILE_TARGET=.local/seed/profile.env"
require_output "$preview_output" "PROFILE_ACTION=CREATE"
require_output "$preview_output" "PROFILE_STATUS=PREVIEW_ONLY"
require_output "$preview_output" "SEED_SELECTED_LANE=linux-reference"
[[ ! -e "$profile_repo/.local/seed/profile.env" ]] || {
    echo "Profile preview unexpectedly wrote a file" >&2
    exit 1
}

if ANDROID_SDK_ROOT="$profile_sdk" "$profile_repo/seed" grow \
    --apply-profile --approval wrong-token \
    >"$test_root/profile-refused.out" 2>"$test_root/profile-refused.err"; then
    echo "Profile apply unexpectedly accepted the wrong technical guard" >&2
    exit 1
fi
rg -Fq -- "--approval create-profile:linux-reference" \
    "$test_root/profile-refused.err" || {
    echo "Profile refusal did not name the exact technical guard" >&2
    exit 1
}
[[ ! -e "$profile_repo/.local/seed/profile.env" ]] || {
    echo "Refused profile apply unexpectedly wrote a file" >&2
    exit 1
}

created_output="$(ANDROID_SDK_ROOT="$profile_sdk" \
    "$profile_repo/seed" grow --apply-profile \
    --approval create-profile:linux-reference)"
profile_path="$profile_repo/.local/seed/profile.env"
require_output "$created_output" "PROFILE_STATUS=CREATED"
require_output "$created_output" "TECHNICAL_GUARD=accepted"
[[ -f "$profile_path" ]] || {
    echo "Approved profile apply did not create the exact target" >&2
    exit 1
}
[[ "$(stat -c '%a' "$profile_path")" == 600 ]] || {
    echo "Created profile does not have mode 600" >&2
    exit 1
}
expected_profile="$test_root/expected-profile.env"
printf '%s\n' \
    '# Adaptive seed local profile v1' \
    '# This file records local choices, not authority for a later action.' \
    'SEED_PROFILE_VERSION=1' \
    'SEED_SELECTED_LANE=linux-reference' \
    'SEED_ANDROID_SDK_ROOT_SOURCE=ANDROID_SDK_ROOT' \
    "SEED_ANDROID_SDK_ROOT=$profile_sdk" \
    'SEED_REFERENCE_ANDROID_CONFIG=config/android.env.example' \
    > "$expected_profile"
diff -u "$expected_profile" "$profile_path"

before_digest="$(sha256sum "$profile_path" | cut -d' ' -f1)"
unchanged_output="$(ANDROID_SDK_ROOT="$profile_sdk" \
    "$profile_repo/seed" grow --apply-profile \
    --approval create-profile:linux-reference)"
after_digest="$(sha256sum "$profile_path" | cut -d' ' -f1)"
require_output "$unchanged_output" "PROFILE_ACTION=UNCHANGED"
require_output "$unchanged_output" "PROFILE_STATUS=UNCHANGED"
[[ "$before_digest" == "$after_digest" ]] || {
    echo "Unchanged profile apply altered the file" >&2
    exit 1
}
adapted_output="$(ANDROID_SDK_ROOT="$profile_sdk" "$profile_repo/seed" grow)"
require_output "$adapted_output" \
    "PROPOSED_STEP=Preview the selected profile's offline verification plan."
require_output "$adapted_output" \
    "DONE_WHEN=The two planned commands and their exclusions have been shown without running them."
require_output "$adapted_output" \
    "CHOICE=Preview offline verification, request details, or stop."

offline_preview="$(ANDROID_SDK_ROOT="$profile_sdk" \
    "$profile_repo/seed" grow --preview-offline)"
require_output "$offline_preview" \
    "OFFLINE_COMMAND_1=./scripts/check-all.sh"
require_output "$offline_preview" \
    "OFFLINE_COMMAND_2=./scripts/fictional-dry-run.sh"
require_output "$offline_preview" "OFFLINE_VERIFY_STATUS=PREVIEW_ONLY"
[[ "$offline_preview" != *"MOCK_CHECK_ALL=PASS"* &&
   "$offline_preview" != *"MOCK_FICTIONAL_DRY_RUN=PASS"* ]] || {
    echo "Offline preview unexpectedly ran a planned command" >&2
    exit 1
}

if ANDROID_SDK_ROOT="$profile_sdk" "$profile_repo/seed" grow \
    --verify-offline --approval wrong-token \
    >"$test_root/offline-refused.out" 2>"$test_root/offline-refused.err"; then
    echo "Offline verification unexpectedly accepted the wrong guard" >&2
    exit 1
fi
rg -Fq -- "--approval verify-offline:linux-reference" \
    "$test_root/offline-refused.err" || {
    echo "Offline refusal did not name the exact technical guard" >&2
    exit 1
}
rg -Fq "MOCK_CHECK_ALL=PASS" "$test_root/offline-refused.out" && {
    echo "Refused offline verification unexpectedly ran repository checks" >&2
    exit 1
}

offline_profile_before="$(sha256sum "$profile_path" | cut -d' ' -f1)"
offline_status_before="$(git -C "$profile_repo" status --short)"
offline_output="$(ANDROID_SDK_ROOT="$profile_sdk" \
    "$profile_repo/seed" grow --verify-offline \
    --approval verify-offline:linux-reference)"
offline_profile_after="$(sha256sum "$profile_path" | cut -d' ' -f1)"
offline_status_after="$(git -C "$profile_repo" status --short)"
require_output "$offline_output" "MOCK_CHECK_ALL=PASS"
require_output "$offline_output" "MOCK_FICTIONAL_DRY_RUN=PASS"
require_output "$offline_output" "PROFILE_PRESERVED=YES"
require_output "$offline_output" "GIT_WORKTREE_PRESERVED=YES"
require_output "$offline_output" "OFFLINE_VERIFY_STATUS=PASS"
check_line="$(printf '%s\n' "$offline_output" | \
    rg -n '^MOCK_CHECK_ALL=PASS$' | cut -d: -f1)"
fictional_line="$(printf '%s\n' "$offline_output" | \
    rg -n '^MOCK_FICTIONAL_DRY_RUN=PASS$' | cut -d: -f1)"
((check_line < fictional_line)) || {
    echo "Offline verification ran the fictional dry run out of order" >&2
    exit 1
}
[[ "$offline_profile_before" == "$offline_profile_after" ]] || {
    echo "Offline verification altered the local profile" >&2
    exit 1
}
[[ "$offline_status_before" == "$offline_status_after" ]] || {
    echo "Offline verification altered Git worktree state" >&2
    exit 1
}

printf '%s\n' '#!/bin/sh' 'echo "MOCK_CHECK_ALL=FAILED"' 'exit 1' \
    > "$profile_repo/scripts/check-all.sh"
chmod +x "$profile_repo/scripts/check-all.sh"
failure_status_before="$(git -C "$profile_repo" status --short)"
if ANDROID_SDK_ROOT="$profile_sdk" "$profile_repo/seed" grow \
    --verify-offline --approval verify-offline:linux-reference \
    >"$test_root/offline-failed.out" 2>"$test_root/offline-failed.err"; then
    echo "Offline verification unexpectedly passed after a failed check" >&2
    exit 1
fi
failure_status_after="$(git -C "$profile_repo" status --short)"
rg -Fq "OFFLINE_VERIFY_STATUS=CHECKS_FAILED" \
    "$test_root/offline-failed.out" || {
    echo "Failed repository checks did not report the bounded status" >&2
    exit 1
}
rg -Fq "MOCK_FICTIONAL_DRY_RUN=PASS" "$test_root/offline-failed.out" && {
    echo "Offline verification continued after repository checks failed" >&2
    exit 1
}
[[ "$failure_status_before" == "$failure_status_after" ]] || {
    echo "Failed offline verification altered Git worktree state" >&2
    exit 1
}

printf '%s\n' 'LOCAL_TEST_CONFLICT=true' >> "$profile_path"
conflict_before="$(sha256sum "$profile_path" | cut -d' ' -f1)"
if ANDROID_SDK_ROOT="$profile_sdk" "$profile_repo/seed" grow \
    --apply-profile --approval create-profile:linux-reference \
    >"$test_root/profile-conflict.out" 2>"$test_root/profile-conflict.err"; then
    echo "Profile apply unexpectedly overwrote a conflicting profile" >&2
    exit 1
fi
conflict_after="$(sha256sum "$profile_path" | cut -d' ' -f1)"
rg -Fq "PROFILE_STATUS=CONFLICT" "$test_root/profile-conflict.out" || {
    echo "Conflicting profile did not report its status" >&2
    exit 1
}
[[ "$conflict_before" == "$conflict_after" ]] || {
    echo "Conflicting profile was modified" >&2
    exit 1
}

echo "Seed growth tests passed: discovery, Git-root gating, profile adaptation, offline verification, failure stop, conflicts, and refusals."
