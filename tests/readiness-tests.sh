#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd -- "$repo_root"
passed=0

require_text() {
    local path="$1"
    local text="$2"
    rg -Fq -- "$text" "$path" || {
        echo "Readiness requirement missing from $path: $text" >&2
        exit 1
    }
    passed=$((passed + 1))
}

require_text README.md 'docs/first-case-runbook.md'
for step in session-bootstrap.sh doctor.sh init-workspace.sh check-all.sh \
    fictional-dry-run.sh create-case.sh qualify-case-apk.sh activate-case.sh \
    cleanup-case.sh post-approved-comment.sh; do
    require_text docs/first-case-runbook.md "$step"
done
for field in EXPECTED_APK_PERMISSIONS EXPECTED_APK_FEATURES \
    EXPECTED_APK_NATIVE_CODE EXPECTED_APK_MANIFEST_XMLTREE_SHA256; do
    require_text templates/case.env "$field=PENDING_APK_QUALIFICATION"
done
for script in qualify-case-apk.sh download-case-apk.sh \
    start-disposable-avd.sh post-approved-comment.sh; do
    require_text "scripts/$script" require_clean_repository_checkpoint
done
require_text scripts/post-approved-comment.sh --paginate
require_text scripts/post-approved-comment.sh AMBIGUOUS_DO_NOT_RETRY
require_text scripts/recover-posted-comment.sh recovered_without_retry
require_text scripts/lib/scan-source-member.sh 'CapacitorHttp'
require_text scripts/lib/scan-source-member.sh 'FileProvider'
require_text templates/report.md 'Pass / Partial / Not tested / Inconclusive'
require_text scripts/cleanup-case.sh 'project emulator or isolated-ADB port remains open'
require_text scripts/cleanup-case.sh 'project AVD process remains after cleanup'
require_text scripts/doctor.sh 'DOCTOR_STATUS=BLOCKED'
require_text docs/troubleshooting.md recover-posted-comment.sh
require_text scripts/lib/android.sh 'complete response before selecting its first line'
require_text scripts/check-case-records.sh 'Inactive pending case checkpoint'
require_text AGENTS.md 'bounded, evidence-based process retrospective'
require_text docs/session-continuity.md 'Retain at most three actionable findings.'
require_text docs/session-continuity.md 'operator experience'
require_text docs/session-continuity.md 'No actionable change'
require_text docs/session-continuity.md 'broaden an earlier approval.'
require_text scripts/session-bootstrap.sh 'For a grow-only session'
require_text scripts/session-bootstrap.sh 'Before entering the community-testing workflow'
require_text README.md 'oikumene-works/fdroid-community-testing-starter-kit'
require_text README.md 'independent adaptive alternative'
require_text .gitignore '.idea/'
require_text docs/seed-publication-evolution.md 'A tracked handoff must not describe its own pending push as current project state'
require_text docs/next-session.md 'infer no identity'
require_text docs/process-audit-2026-09-20.md 'No identity, credential, external authority, or approval transfers'
require_text docs/publication-plan.md 'oikumene-works/fdroid-community-testing-adaptive-seed'
require_text docs/publication-plan.md 'authorizes no later push'

echo "Static publication-readiness assertions passed: $passed"
