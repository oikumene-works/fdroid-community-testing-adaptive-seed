# Battleship public claim review

TEST_SAFETY_STATUS=PASS
CLAIM_REVIEW_STATUS=FINDINGS_RECORDED

Evidence class: exact-source review plus bounded merged-APK qualification;
not a security assessment or runtime result. Reassessed under docs/test-eligibility.md.
The original source findings below remain source-only; the later binary evidence
is separately classified in qualification.md and the addendum below.

## Bound inputs

MR !49547 head `f2577e78cab813fde78b11d16b7c7b05dd88ea69`; upstream
`v1.0.11`, source `35189f727db1cc80bdc55e9996bdcaa443914571`.
The fdroiddata recipe has no Summary or Description override. The effective
English listing is therefore the pinned upstream Fastlane text. Only en-US
Fastlane metadata exists; English and Persian website text and the bilingual
website privacy policy were also reviewed. No source instructions were executed.

Normalized claim-file index SHA-256:
`19e3f8a7bfdeb9a7f922c33f5d5f4cd3c714a8aa05b1a6134e8958ede0c5cfbf`.
The exact file list and individual digests are in `evidence-index.md`.
GitHub release ID `392185392` is a non-draft, non-prerelease maintenance release.
Its body concerns version metadata and does not resolve the following conflicts.

## Original claim-to-source findings (before APK qualification)

Binary-pending statements in this original table describe that earlier source
review. The qualification addendum below owns the subsequent built evidence.
All paths below refer to the exact source commit above. Statements about source
behavior are static findings, not observations of a running app.

| Public claim | Exact evidence | Assessment |
| --- | --- | --- |
| Fastlane short/full descriptions and README advertise two-player pass-and-play. | `MenuScreen.kt` has one start callback. `BattleshipNavHost.kt` routes that callback directly to placement. `GameUiState.kt` models playerBoard and aiBoard. `GameViewModel.confirmPlacement()` always generates an AI board; `playerAttack()` schedules `aiAttack()`, which always calls `BattleshipAI.chooseAttack()`. `strings.xml` explicitly labels the mode single player against AI. No second-human mode, selector, placement, handoff, or turn path was found across main source. The privacy policy also calls it single-player. | Product finding. Keep the two-human mode as unverified/missing at source level; a synthetic one-human-versus-AI scope does not depend on that advertised mode. Correct the description or investigate a newly supplied implementation path. This finding does not itself create an unsafe test action. |
| Fastlane and README promise manual drag-and-drop placement. | `PlacementScreen.kt` wires cell clicks to `placeShip`, with separate rotation and auto-place buttons; `BattleGrid.kt` passes onCellClick; `GridCell.kt:133` uses Modifier.clickable. No drag or pointer-gesture placement path was found. | Product finding: the inspected path is tap placement, not a drag-and-drop path. A synthetic tap/rotation test is bounded; runtime gestures remain untested. |
| Privacy text says game data is only on the device, never sent to any third party, and removed upon app deletion/data clearing. | Manifest sets allowBackup=true and references backup_rules.xml and data_extraction_rules.xml. Both contain no operative exclusion of shared preferences. Career data and medal counts use private SharedPreferences named career_stats. The policy itself later permits Android/Google backup. | Documentation finding: distinguish app-controlled transmission and local deletion from OS-managed backup/restore. The backup path is already disclosed. Use synthetic game state only, no Google account or cloud-backed image, and no backup/restore action. This does not establish that any backup occurred. |
| No internet, account, ads, tracking, or sensitive permissions; VIBRATE is the only declared permission. | Main source manifest declares only android.permission.VIBRATE, exports only launcher MainActivity, and defines no service/receiver/provider. Declared production dependencies are AndroidX/Compose/navigation/lifecycle and Kotlin coroutines. No app network/account/billing/analytics client was found. | Consistent at source level. Merged dependencies, certificate, binary identity and all built surfaces remain unqualified. Read the third-party-SDK wording narrowly as tracking SDKs; standard third-party libraries clearly exist. |
| Footer links open externally. | MenuFooter.kt delegates only the fixed developer URL and GitHub latest-release page to LocalUriHandler.openUri. No embedded browser, downloader, document/share input, or app link was found. | Consistent statically. No link was opened in an Android app. Source web-font URLs belong to website HTML, not the app network surface. |
| 10x10 board, five ships, five unlockable weapons, eight ranks, generated audio, and career persistence. | Board/GameConfig/ShipType, SuperWeapon, Rank, SoundManager, GameViewModel, SessionStats and SharedPreferences storage provide those paths. | Source support, no functional result. Boundary weapon patterns are clipped by resolveWeaponCells; a five-cell sweep does not cover a whole ten-cell row. English/Persian website wording describing a whole row is overbroad. |
| Listing/README/English and Persian website count 15 medals. | Badge.kt defines 33 entries; MedalsViewModel and BadgesViewModel both map all Badge.entries. | Stale numeric claim. Correct alongside the functional listing; this is not evidence of missing medals in a built app. |
| llms.txt says there is no persistence. | SharedPreferencesSessionStatsStorage and SharedPreferencesMedalsStorage persist career data. | Stale auxiliary documentation. It is untrusted claim material, not an instruction for this review. |
| MR says the build is reproducible and offline. | Exact-head pipeline and build succeeded; trace reports verification and emits the Code Quality APK URL. GitHub reports an uploaded asset digest; fdroiddata pins the signer. | Provider evidence only. No independent rebuild or binary inspection was performed. |

## Bounded safety assessment and decision

The source evidence supports eligibility for the next separately approved
APK download-inspect-delete qualification. App identity/source/release/signer
expectations and the exact artifact URL remain pinned. The source declares
VIBRATE only, exports a launcher, and has no observed network, account, payment,
sensitive permission, document input or arbitrary-file write path. APK parsers
must use the existing no-network read-only sandbox; the original review did not yet verify sandbox operation or merged APK contents.
The subsequent qualification evidence is recorded separately below.

The eventual bounded functional scope would use only synthetic game moves in
the disposable AOSP API34 x86_64 environment, no account, no Google/cloud-backed
image, no external-link activation, and no backup/restore attempt. Include
single-player placement, AI turns, reachable weapons and synthetic local career
state. The two-human and drag claims remain source-only findings, never silently
counted as runtime passes. Stale counts/persistence descriptions do not create
an additional execution effect. No personal file, real-world credential or
security-critical operation is needed. All scope and cleanup conditions in
case.md remain mandatory, with separate exact operator approval.

This scope excludes the app's external footer links and any OS/cloud backup
behavior. If qualification reveals INTERNET, sensitive permissions, an
unexpected component/data route, a different identity/signer or unexplained
writes, stop and reassess. Unknown built surfaces are a qualification prerequisite,
not evidence that the executable is already safe. Qualification was separately
authorized and completed as recorded below; no Android approval or active case exists.

The deployed website could not previously be read through the web reader. The
review binds its exact source files and retains this limitation. It does not
assert a clean live listing or currently deployed byte identity. That product-
claim evidence gap does not itself enable network access or expand this scope.

Current decisions: safety PASS for the described gated scope; claims
FINDINGS_RECORDED. The code and wording have not been corrected by this review.
The detailed findings remain open. A changed MR/source/artifact requires a fresh
preflight; new evidence that changes safety or scope requires a fresh digest.

## Decision history and communication

At checkpoint 641156a, the older policy classified these findings as
CLARIFICATION_REQUIRED and stopped every later gate. On 2026-09-22 the operator
explicitly authorized separating test safety from product findings. The new
assessment above changes our policy/classification, not the candidate or its
observed behavior. Earlier evidence remains in Git history and evidence-index.md.

The separately authorized courteous source-only issue was published and verified
at <https://github.com/cocodedk/Battleship/issues/55>. See upstream-issue-record.md
and upstream-issue-body.md for exact text, digest, identity and authorization.
It grants no approval for further comments, APK action, Android or publication.

Android backup interpretation follows the official documentation:
<https://developer.android.com/identity/data/autobackup>. Shared preferences are
included by default; actual backup also depends on device/user/transport state.

## APK qualification addendum — 2026-09-22

The separately authorized exact download-inspect-delete completed. See
qualification.md for binary identity, signer, SDK, alignment, normalized manifest
digest, cleanup and evidence limits. The original safety and product decisions
remain PASS / FINDINGS_RECORDED after reviewing the newly observed merged surface.

The built app requests VIBRATE plus its own signature-protected
DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION; the source-only wording “VIBRATE only”
is not an exact description of the merged request set. This is a wording
qualification, not an observed dangerous permission. No INTERNET or dangerous
requested permission was found. AndroidX contributes a non-exported startup
provider and an exported ProfileInstallReceiver protected by the caller's DUMP
permission; DUMP is not requested by the app. These documented library surfaces
are reconciled in qualification.md. No invocation of profile/benchmark receiver
actions is included in the synthetic game scope. Native ABIs include x86_64;
individual native-code behavior/provenance remains outside this inspection.

No game feature, persistence or backup claim became a runtime pass. The existing
synthetic-data, no-account, no-external-link and no-backup/restore restrictions
remain. No network or Android lane was added. This addendum refreshes the
digest-bound assessment rather than treating source expectations as binary facts.
