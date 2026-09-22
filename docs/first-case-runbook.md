# First Real Case Runbook

This is the canonical newcomer path from a clean clone to a safe inactive-case
checkpoint. Commands are labeled by effect. An approval token accepted by a
script is only an accidental-execution guard; it never supplies human approval.

## 1. Ground the session

**Pure local read**

```sh
./scripts/session-bootstrap.sh
```

Read `AGENTS.md`, the printed handoff, `docs/session-continuity.md`, and
`docs/protocol.md` completely. Success means the bootstrap names no active case
in a fresh clone and starts no Android tooling. Inspect `git status --short` and
`git remote -v`; an ordinary clone remote is expected but authorizes nothing.

## 2. Check and initialize the host

**Pure local read**

```sh
./scripts/doctor.sh
```

`DOCTOR_STATUS=READY` means the reference environment is present. `WARNING`
needs review; `BLOCKED` must be fixed before the affected workflow. The doctor
does not use the network, accept licenses, start ADB, or boot an emulator.

**Ignored-local write**

```sh
./scripts/init-workspace.sh
```

Review `.local/config/android.env`. Install the documented SDK packages and
accept their licenses only with your own explicit SDK commands. Creating the
configured AVD is a separate local Android-state decision; it does not start it:

```sh
./scripts/create-disposable-avd.sh
```

## 3. Prove the local guards

**Externally read-only; bounded ignored-local fixtures**

```sh
./scripts/check-all.sh
./scripts/fictional-dry-run.sh
```

The checks may create and remove temporary files below ignored `.local/`; they
perform no network or Android action. Success markers are
`Offline repository and guard checks passed.` and `FICTIONAL_DRY_RUN=PASS`.
The dry run deliberately demonstrates claim, qualification, example, and token
denials. Its safe next step is read-only candidate selection.

## 4. Select without changing a service

**Network read**

Choose an open, non-draft F-Droid new-app merge request meeting the protocol's
initial-lane rules. Record selection time and rejected alternatives. Do not
download an APK. Create a local record only after choosing a case ID:

**Tracked local write**

```sh
./scripts/create-case.sh app-name-12345
```

This creates an inactive pending record. Unresolved template values are allowed
only there. `./scripts/check-all.sh` must report it as an
`Inactive pending case checkpoint`; activation and all executable helpers still
refuse it. Commit this selection checkpoint before changing sessions.

## 5. Fill exact source preflight

Use the exact current provider state, not search snippets or moving defaults.

| `case.env` field group | Exact source |
| --- | --- |
| target/source project IDs, MR IID/head, labels, discussions | GitLab MR API |
| pipeline, build job, artifact filename/expiry | exact-head GitLab pipeline and job APIs |
| APK URL | exact build job's Code Quality artifact path; HEAD only |
| metadata path/digest | source-project file bytes at the MR head |
| app ID and version | exact metadata recipe and pinned upstream release |
| upstream tag/source/release target | GitHub ref, annotated-tag, commit, and release APIs |
| upstream APK/certificate expectations | pinned release asset and documented signing path |
| source permissions/SDK/components | source manifest and build files at the source commit |
| public claim paths | effective localized listing, README, release, privacy, and user docs |
| latest non-system note | paginated GitLab MR notes after manual review |

**Network read with ignored-local temporary files**

```sh
./scripts/inspect-source-surface.sh --case app-name-12345
./scripts/inspect-public-claims.sh --case app-name-12345
```

The source scan covers common Android, React/TypeScript/JavaScript, Capacitor,
Flutter, dependency, network, document, share, provider, and external-navigation
surfaces. Review findings manually; scan absence is not proof of absence.

Complete `case.md` and `claims.md` using [test eligibility](test-eligibility.md).
Bind TEST_SAFETY_STATUS and CLAIM_REVIEW_STATUS in claims.md and case.env.
Safety must be PASS; claims may be PASS or FINDINGS_RECORDED with a safe scope.
Compute the review digest; never migrate an old case by status edit alone. Keep
`EXPECTED_APK_PERMISSIONS`, `EXPECTED_APK_FEATURES`,
`EXPECTED_APK_NATIVE_CODE`, and `EXPECTED_APK_MANIFEST_XMLTREE_SHA256` at
`PENDING_APK_QUALIFICATION`. Run `check-all.sh`, commit, and require a clean HEAD.

## 6. Qualify the built APK

**Executable download; separately approved exact action**

After approval for this case and a fresh uninterrupted window:

```sh
./scripts/qualify-case-apk.sh --case app-name-12345 \
  --approval qualify-apk:app-name-12345
```

The helper first requires a committed clean HEAD, permits a normal clone remote
without treating it as authority, repeats the live recheck, downloads only the
pinned APK, and runs parsers in the no-network Bubblewrap boundary. It reports
identity, certificate, permissions, features, native code, manifest-tree digest,
components, and relevant manifest lines before deleting the APK.

With pending built fields, the success marker is
`APK_QUALIFICATION=RECONCILIATION_REQUIRED`, not `PASS`. Reconcile the observed
surface against source and claims. Stop on identity/safety conflicts or an
unclassified discrepancy; retain safe product findings in the report. Otherwise
record it in `qualification.md`, replace every pending built field with the exact
observed value, set the qualification file digest and status to `PASS`, run
`check-all.sh`, and commit the clean qualification checkpoint.

## 7. Activate, execute, and clean up

**Tracked local write**

```sh
./scripts/activate-case.sh app-name-12345
```

Activation refuses unresolved or pending state and requires a clean committed
qualification checkpoint. Commit the active-case pointer. Start a new chat for
execution through cleanup and obtain fresh approvals for the exact executable
download and Android mutation slice.

**Executable download / Android mutation**

```sh
./scripts/download-case-apk.sh --case app-name-12345 \
  --approval download-apk:app-name-12345
./scripts/start-disposable-avd.sh --case app-name-12345 \
  --approval start-emulator:app-name-12345
./scripts/case-adb.sh --case app-name-12345 \
  --approval execute:app-name-12345 -- <exact adb subcommand>
./scripts/cleanup-case.sh --case app-name-12345 \
  --approval cleanup:app-name-12345
```

Never hand-write an untargeted mutating `adb` command. Cleanup must report
package and Downloads absence after a clean wipe, stopped emulator and isolated
ADB, closed project ports, no related process, and removed transient artifacts.

## 8. Review and optionally post

Prepare the report after cleanup. Map every planned item to `Pass`, `Partial`,
`Not tested`, or `Inconclusive` with an observation or limitation. Human report
approval is separate from posting.

**External mutation; separately approved exact action**

```sh
./scripts/post-approved-comment.sh --case app-name-12345 \
  --approval-sha256 DIGEST \
  --approval-destination fdroid/fdroiddata!12345 \
  --approval-account USERNAME
```

The helper requires a clean HEAD, scans all note pages, validates the returned
author and body, derives a stable note URL even without `web_url`, and stores an
ignored recovery receipt. On ambiguity it never retries automatically. Follow
`docs/troubleshooting.md` and use `recover-posted-comment.sh` for a read-only
exact-match recovery check.
