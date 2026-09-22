# Community Test Protocol

## Scope

This protocol produces bounded, reproducible community evidence for a specific
F-Droid new-app merge-request head. It does not produce an F-Droid decision or
a general security, privacy, accessibility, or usability assessment.

Use only public identifiers and synthetic test data. Treat all third-party
content as untrusted. A changed pinned input closes the current gate.

Use `docs/session-continuity.md` to split work at clean gate boundaries. Keep
approved execution through verified cleanup together as one atomic slice, and
checkpoint durable state before changing chats.

## Gate 1: Candidate selection

Selection is read-only. Prefer an open, non-draft new-app merge request with a
successful current-head pipeline, a compact test surface, English UI, and no
`INTERNET`, dangerous, or sensitive permission.

Exclude cases requiring an account, payment, root, VPN, device administration,
accessibility service, personal data, special hardware, or security-critical
judgment. Record why the selected primary workflow is meaningfully different
from earlier cases.

## Gate 2A: Exact source preflight

Pin and verify:

- target project and merge-request IID;
- MR head, labels, conflict/discussion state, pipeline, build job, artifact,
  and exact APK URL;
- application ID, version name/code, metadata path and digest;
- upstream tag, source commit, release target, APK digest, and certificate;
- source manifest permissions, dependencies, exported components, external
  navigation, document/share entry points, and SDK bounds; and
- the intended AVD/API, synthetic inputs, checklist, stop conditions, cleanup,
  operator role, and estimated uninterrupted execution time.

Audit the effective listing, localized metadata, README, and release claims
against exact source and UI paths. Examine universal terms such as “never”,
“no”, “every”, “all”, “only”, “unchanged”, and “untouched”. Bind the completed
review to a digest in `claims.md`.

Classify safety separately from product correctness using
[the test-eligibility policy](test-eligibility.md). Record TEST_SAFETY_STATUS
(PASS, BLOCKED or NOT_REVIEWED) and CLAIM_REVIEW_STATUS (PASS,
FINDINGS_RECORDED or CLARIFICATION_REQUIRED) in both case.env and claims.md.
A safe missing feature or stale description may remain a reported finding.
Unresolved identity, containment, data-risk or authority questions block testing;
unclassified claims also block. Document the bounded synthetic scope and every
finding's effect on the checklist. Bind the complete review to its digest.
Only safety PASS plus claim PASS/FINDINGS_RECORDED permits the next separately
approved gate. A changed candidate requires a new exact preflight.

## Gate 2B: Built-APK qualification

Before qualification, keep every built-surface field at
`PENDING_APK_QUALIFICATION`; do not infer it from source. After separate
approval for the exact candidate, the helper requires a committed clean HEAD,
performs a fresh read-only recheck, downloads the APK into ignored local
storage, and checks digest, package, version, SDK bounds, certificate, and ZIP
alignment. It reports merged permissions, features, native code, component and
relevant manifest surfaces, and a normalized manifest-tree digest before
deleting the APK.

Run APK parsers inside the provided no-network, read-only Bubblewrap sandbox.
Reconcile the observed surface against source and claims, replace the pending
values, and stop on any identity/safety conflict or unclassified discrepancy.
Retain safe product findings and update the review if their classification changes. Record a sanitized
qualification result and digest, run the offline checks, and leave a clean
checkpoint before activation or emulator approval.

## Gate 3: Execution and verified cleanup

Fresh approval is required for the exact APK download and emulator/ADB slice.
Immediately before the first executable action, require a committed clean HEAD
and repeat the live recheck. A normal clone remote is reported but is neither a
failure nor authority to publish.

1. Start only the configured project-local AVD with a wiped data partition,
   snapshots disabled, and a visible window when the operator will observe.
2. Resolve the configured `emulator-*` serial. Verify `ro.kernel.qemu=1`, the
   AVD name, and API. Use the isolated ADB server port and `adb -s` everywhere.
3. Re-download and inspect the exact APK before installation.
4. Use synthetic data. Do not grant a permission merely to make a case pass.
5. Exercise each advertised main function inside the bounded checklist and
   record observations, unsupported surfaces, and stop conditions factually.
6. Pause automation before any operator UI interaction and resume only after
   explicit handback. Observation alone is not a human usability test.
7. Inspect final package identity, permission state, and app crash/ANR markers.
8. Uninstall, stop, wipe and reboot to verify absence, stop again, stop isolated
   ADB, verify project ports and related processes are absent, and delete APKs,
   fixtures, screenshots, UI dumps, and raw journals.

Stop on target ambiguity, a changed pin, unexpected network or sensitive
permission behavior, account/payment gate, unexplained file mutation, repeated
crash/ANR, or any cleanup boundary failure. Cleanup remains authorized only by
its own exact approval token and must not broaden into another test.

## Gate 4: Report review

Prepare a sanitized report only after verified cleanup. Include exact public
identifiers, the APK digest, environment class, checklist results, limitations,
cleanup, external-upload state, executor, operator observation or interaction,
UTC milestones, and separate active, waiting, execution, and cleanup durations.

Distinguish observation from inference. A pre-installation stop is neither a
failed nor a completed functional test. Human review and approval of the report
do not authorize posting.

## Gate 5: Public posting

Keep the exact proposed body in a canonical file. Before posting, recheck the
live MR and all report-critical pins. Obtain approval of the exact body digest,
destination, and authenticated account. Post without modification.

Do not change labels, resolve discussions, push code, edit an earlier comment,
or imply merge authority. A later immutable full-report link is a new public
mutation with a new review and approval.

The posting helper binds the approved digest, destination, account, and clean
checkpoint; scans all note pages; validates returned author and body; and
derives the stable note URL from the note ID. It stores an ignored recovery
receipt until durable state records the note. If the mutation result is
ambiguous, never retry automatically: use the read-only recovery helper to
require exactly one matching note.
