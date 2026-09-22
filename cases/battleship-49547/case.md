# Battleship MR !49547: source-preflight rejection

## Current gate

Selected and reviewed, inactive, `CLAIM_REVIEW_STATUS=CLARIFICATION_REQUIRED`.
The exact source is sufficient to reject this candidate from later gates.
No built-APK qualification or functional test started. This is an independent
community preflight, not an F-Droid decision or a security assessment.

The effective listing advertises pass-and-play for two people, while the pinned
navigation/state/turn code implements one human against AI. It also advertises
drag-and-drop, while placement is wired to cell clicks. The privacy policy's
only-on-device/never-shared/deleted wording conflicts with its own OS-backup
exception and the enabled, unrestricted shared-preferences backup configuration.
See `claims.md` for the complete bounded matrix and `evidence-index.md` for
per-file digests and immutable links. Merely changing the local status cannot
resolve a source/claim contradiction.

## Exact candidate

- MR: <https://gitlab.com/fdroid/fdroiddata/-/merge_requests/49547>
- Target: `fdroid/fdroiddata`, project `36528`; source: `cocodedk/fdroiddata`,
  project `85625467`, branch `com.cocode.battleship`.
- MR head: `f2577e78cab813fde78b11d16b7c7b05dd88ea69`.
- Pipeline `2867295579`, successful at the exact head; build job `16624306623`,
  `fdroid build`, successful. All nine listed jobs were successful.
- Artifact: `fdroiddata_build_com.cocode.battleship_f2577e78cab813fde78b11d16b7c7b05dd88ea69.zip`,
  2,226,524 bytes; expiry `2026-10-21T10:45:26.817Z`. Never downloaded.
- Exact Code Quality APK link emitted in the build trace:
  <https://gitlab.com/cocodedk/fdroiddata/-/jobs/16624306623/artifacts/raw/tmp/binaries/com.cocode.battleship_1000011.binary.apk>.
  HEAD-only availability returned HTTP 200. No response body/APK was requested.
- Metadata: `metadata/com.cocode.battleship.yml`, SHA-256
  `d87bd9b623d228b8c580614063dfe641f0fff80f2a344ed74f40041b514bc3d9`.
- App ID `com.cocode.battleship`; version `1.0.11`, code `1000011`.
- Upstream: `cocodedk/Battleship`; lightweight tag `v1.0.11` resolves directly
  to `35189f727db1cc80bdc55e9996bdcaa443914571`, also the release target.
- Release ID `392185392`, published `2026-09-19T19:13:48Z`, not draft/prerelease.
  Asset ID `575331212`, `Battleship.apk`, 1,296,838 bytes; reported SHA-256
  `27c558552dc9cbd00fbb34c619aab72dbc21bd870d68a48f4cc4bc9f7b32a0d9`.
- Metadata's allowed signer SHA-256:
  `6120b56d569c8ccb013f5fa08dd08790194ba2c390fa97e12e0eb36ef1599e21`.
  Asset digest and signer are expectations, not locally verified binary facts.
- MR is open, non-draft, conflict-free; blocking_discussions_resolved=true.
  Labels: New App, review-requested, reproducible-builds; no waiting-on-response.
- Latest non-system note `3871514834`, `2026-09-20T09:40:31.791Z`, author
  cocodedk, acknowledges the testing queue. All note/discussion pages were read;
  no resolvable unresolved thread was present. No posting occurred.

## Why this new case

The reviewed local case inventory contained Social Deduction Game !47820,
ScrubPony !46152, CountAway !46416 and Chess Puzzles !49444. Battleship was
absent. The previous Chess Puzzles case was read in full; its upstream issue
publication grants no authority here. No previous profile or case state was copied.

Battleship adds ship placement/rotation, alternating tactical attacks, AI turn
handling, weapon unlock/patterns, generated sound/haptics and career statistics.
That differs from chess puzzle solving, multiplayer social-role setup, photo
metadata handling and countdown workflows. Both game cases have the same author;
this is not evidence of broader author/provider/environment coverage.

Bounded alternatives reviewed from current open New App MRs:

| Alternative | Reason not selected for this lane |
| --- | --- |
| Verdetto !49438, head c62478076273c7db64f2211aa6e04913267de798 | Description identifies a barcode scanner, GitLab upstream and arm64-only native build; incompatible with the existing GitHub adapter/x86_64 reference lane without broader work. |
| Link QR Wallet !49558, head bc51422094a9e22a12f556237ed59140524adc07 | Description explicitly fetches saved URL titles online and uses QR scanning. |
| Keycard Pal Offline !49652, head ec84b7b3d7ef73e2b340644c1fad7ad37d43e173 | Crypto signing with NFC smart cards; security-critical purpose and special hardware. |
| DailyBeat !49457, head 2450e1d4449cb04af4661b3d4067c82ba2342e9e | Description explicitly declares network, microphone and location/background-location surfaces. |
| Twig !48122, head ea8b1c769e62cc93c1c8bfee638a827fd7ab4749 | Broad local/remote file-manager workflow (FTP/SFTP/SMB/WebDAV/S3), beyond this initial lane. |
| Mathe-Trainer !48790, head d529f4c07663f57ea802e9c08c0958407fa79d2d | German-only tablet workflow with child profiles and parental PIN; less suitable than the compact English path. |
| anagram !47595, head ba06a5222bf2b0051390351b0c4148f8d52c95ec | Description supplies no substantive workflow evidence and leaves reproducible-build support unchecked. Deferred, not judged defective. |

These alternatives received selection-level review only, not exact source audits.
The search was bounded; it does not claim exhaustive coverage of the MR queue.

## Source surface

Only android.permission.VIBRATE is declared in the sole main manifest. The only
exported component is launcher MainActivity; no service, receiver, provider,
app-link, share/document entry or hardware feature is declared. Minimum SDK 24,
target SDK 36; compile SDK 36.1. English resources exist. Production declarations
use AndroidX/Compose/Core/Lifecycle/Activity/Navigation and Kotlin coroutines;
no network, account, payment, analytics or sensitive-permission client was found.

Footer external navigation delegates fixed developer and GitHub release-page
URLs through LocalUriHandler.openUri. No source downloader was found. Career
statistics, badges and medal counts persist in private SharedPreferences
`career_stats`. Backup is enabled, with no operative exclusions. Signing source
reads release environment values; the workflow builds and publishes a signed
release using secrets and pins target_commitish to the source commit. Neither
that workflow nor any third-party build/test/script was executed here.

Normalized source-surface SHA-256:
`b5d90031dc922b942bfd279e1c382e8bef25e1b77a1c9fe801be616807453721`.
Normalized public-claim file-index SHA-256:
`19e3f8a7bfdeb9a7f922c33f5d5f4cd3c714a8aa05b1a6134e8958ede0c5cfbf`.
All built permissions/features/native code/components/manifest digest remain
unverified; the machine fields remain `PENDING_APK_QUALIFICATION`.

## Local discovery and bounded growth

Fresh anonymous HTTPS clone of public seed commit
`cb4ab8bd35952acb204c0920086d14a379996066`. Bootstrap named no active case.
The current instructions/protocol/runbook matched the development copy by digest.
Discovery returned READY:9, MISSING:0, UNSUPPORTED:1, UNKNOWN:2. The unsupported
lane was network-capable apps; Android command/package compatibility remained
unknown in seed discovery. Doctor subsequently found the reference SDK files,
KVM/display and tools; it warned about absent local Android config and the normal
clone remote. These checks do not prove Android or parser-sandbox execution.

Within the user's scoped instruction to prepare this read-only case, Codex
reviewed the exact profile preview, selected the existing Linux reference lane,
created only the ignored profile, previewed offline verification, then ran the
exact guarded wrapper. Offline checks and fictional dry run passed; profile bytes
and Git state were preserved. No dependency, seed feature, adapter, SDK component,
Android config, AVD or Android process was created. The profile is mode 600.
This was delegated task execution under existing authorization, not a fresh-user
choice/comprehension experiment with independent approvals at every prompt.

The invariant kernel and scripts were unchanged. Discovered host facts and the
profile stayed local. Optional Android/network/provider growth was unnecessary
and was not implemented. A writable local case record was required to bind the
read-only findings; it grants no subsequent executable or external authority.

## Hypothetical later checklist (not authorized)

Only after a changed candidate passes a fresh claim preflight and a separately
approved download-inspect-delete qualification: use the project-local wiped
AOSP API34 x86_64 Pixel 7 profile, isolated ADB port 5041 and emulator port 5580,
snapshots disabled. Do not create that AVD as part of this checkpoint. Real
hardware haptics are outside emulator coverage. Estimated execution and verified
cleanup window is 30–40 uninterrupted minutes; Codex operates and the user may
observe unless a later explicit handoff changes the role.

1. Confirm exact identity, English launch, absence of account/payment/permission gates.
2. Exercise tap/rotation/invalid-overlap/edge placement and automatic placement.
3. Play a synthetic AI game, covering hit/miss/sink, input during AI turn and restart.
4. Exercise reachable weapon unlocks and edge clipping; mark any unearned weapons untested.
5. Check score/rank/medal/career updates and persistence across relaunch; no exhaustive badge claim.
6. Inspect footer labels without opening external links. Reassess advertised two-player/drag paths only if a corrected source implements them.
7. Inspect package and crash/ANR state; uninstall, wipe/reboot verify absence, stop emulator and isolated ADB, and remove all temporary artifacts.

Stop on changed pins, target ambiguity, unexpected network or sensitive merged
permission, account/payment gate, unexpected external intent/write, repeated
crash/ANR or cleanup failure. Use synthetic moves only and no personal data.

## Observed timeline and external state

- 2026-09-22T02:00:49Z: fresh public clone (Git reflog timestamp).
- 2026-09-22T02:02:43Z: inactive case record created (filesystem birth timestamp).
- 2026-09-22T02:09:37Z: completed digest-bound claim review and exact live read-only recheck;
  READ_ONLY_RECHECK=PASS, claim status remains CLARIFICATION_REQUIRED.
- Individual active/wait/review durations were not instrumented; no execution
  or APK-cleanup duration exists because neither phase began.

Network use was public read-only clone/API/source-text/archive access plus APK
HEAD availability. Anonymous GitLab notes/discussions and single-job reads
returned 401; the already configured glab account was verified as Jyriwee and
used only for GET requests to public case data. Existing GitHub client access
was used by the stock read-only scanners/recheck. No private repository, secret,
credential value, user profile, source build or external mutation was requested.
Raw source/API/build-trace files were temporary ignored state and were removed
at checkpoint. No APK, build-artifact ZIP or release asset was downloaded.

No case activation, AVD creation, emulator start, ADB command, install, test,
issue/comment, label/discussion mutation, upload, push or publication occurred.
Host process inspection saw unrelated existing ADB processes; they were not
started, targeted or stopped by this case. No emulator process or listener on
reference case ports 5041/5580/5581 was observed at the checkpoint inspection.
This is a case-scoped cleanliness claim, not a claim that the entire host lacks ADB.

## Bounded retrospective and stop

Environment/tools: the existing lane was sufficient; missing Android config did
not justify creating Android state for source review. Codex: claim-to-code tracing
found an advertised core function absent despite successful CI. Operator and
joint coordination: the task's existing read-only/local-checkpoint authorization
was sufficient; no additional effect boundary was crossed. No material process
change is proposed or implemented. Disposition: no change (owners: Codex/shared).

Stop at the committed, clean, inactive rejection checkpoint. A new session
should read this case and handoff. A newly pinned correction requires a new
read-only preflight; APK qualification needs a later exact decision and may not
start while this claim status remains unresolved. No upstream contact is planned.
