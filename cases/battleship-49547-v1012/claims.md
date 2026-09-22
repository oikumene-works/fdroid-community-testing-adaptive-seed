# Battleship 1.0.12 source and public-claim review

TEST_SAFETY_STATUS=PASS
CLAIM_REVIEW_STATUS=FINDINGS_RECORDED

Codex performed this independent exact-source delta review on 2026-09-22.
This is not runtime evidence, human testing or an F-Droid acceptance decision.
Pins and complete review-surface digests are in case.env and evidence-index.md.
All paths below refer to source d1cdd2e3afe02865a901a51d3e05daedbc4b24ed.
The recipe has no Summary/Description override; the pinned Fastlane listing
remains relevant to the MR. Live deployed website byte identity is not asserted.

## Delta and previous evidence

The provider comparison from v1.0.11 lists 11 changed files (evidence-index.md).
No app/src file, dependency-version catalog or release-signing workflow changed.
The earlier reviewed main manifest still declares VIBRATE only; SDK bounds are
24/36. Fixed external footer URLs, SharedPreferences persistence and enabled
OS backup remain the previously reviewed source paths. No source tree code,
build or script was executed. The fresh stock surface scan matches the earlier
normalized digest. Absence of scan matches is not a security proof.

Besides descriptions, domain links and version identifiers, app/build.gradle.kts
now preserves debug symbols in packaged native libraries (keepDebugSymbols).
Thus this is not literally a documentation-only binary change. No independent
rebuild or inspection of individual native library behavior is claimed. All
built surfaces must be freshly qualified rather than inherited from 1.0.11.

## Correction audit

| Topic | Exact pinned evidence and classification |
| --- | --- |
| Two-human mode | README removed the claim, but full_description.txt:1 and short_description.txt:1 still advertise pass-and-play. New changelog 1000012.txt:1 says there is no such mode. The unchanged source still generates an AI board and schedules AI turns. Material listing contradiction; retain as product finding, no two-human runtime pass. |
| Placement | README:19 and full_description.txt:3 replace drag-and-drop with tap placement but say a further tap rotates. PlacementScreen.kt:109 calls toggleOrientation from a separate button; GameViewModel.kt:36-48 cell placement does not rotate and advances to the next ship. Ambiguous replacement wording: specify the rotation button. Sample its actual UI behavior in the runtime check. |
| Medals | README, full description and English website now say 33. Persian website/fa/index.html still says 15 (Persian digits) at lines 7,42,280,510,571; its English featureList was changed to 33. Source Badge entries and unchanged resources support 33; Persian correction incomplete. This is a bounded text review, not full Persian localization testing. |
| Persistence | llms.txt:16 now describes app-private career/medal persistence, consistent with unchanged source. Runtime persistence of this new APK is pending. |
| Sonar | English website/index.html:215 now says five centered cells clipped at the edge. Persian website/fa/index.html:226 retains the whole-row wording. Source weapon logic is unchanged. No new weapon runtime result. |
| Backup | website/privacy.html:84 now explicitly notes the possible surviving Android backup copy. Its Persian paragraph at lines 132-134 and privacy.md:15-18 retain the unqualified local/deletion wording; both separately disclose backup later. Partial clarification, not evidence of transmission or a backup test. |
| Repeated hit counting | GameViewModel/GameWeaponLogic/GameTrackers unchanged. Developer confirmed the earlier interpretation in note 3882043297; no new counter experiment or intended unique-cell metric is established. |
| CI/reproducibility | Exact-head pipeline/build green; trace reports successful supplied-reference comparison. This is provider evidence, not our independent rebuild. |

## Safe authorized scope

The user requested the proposed bounded adaptive verification of this exact
new version, including prerequisite checks, APK qualification and re-download,
disposable AOSP API34 x86_64 setup, synthetic UI test and verified cleanup.
Qualification remains its own download-inspect-delete checkpoint before runtime.
The authorization does not include external publication, repository push or
changes to the app. The local records and necessary clean checkpoints are in scope.

Test launch, cell placement and rotation-button behavior, auto-deployment and
AI turns. Inspect career/registries before and after cold force-stop/relaunch.
If meaningful nonzero career persistence requires completion, play at most one
synthetic game to obtain it; do not replace this with injected app data or claim
that an unchanged empty screen proves stored progress. Stop the gameplay portion
at 15 minutes and record persistence inconclusive if no suitable result exists.
Inspect final package and session crash/ANR buffers. No full weapon/medal matrix.

Use only the case-local wiped AOSP AVD, targeted isolated ADB and existing stock
guards. No account, Play/Google image, external-link activation, backup/restore,
physical/shared device, personal data, permission grants or profiling broadcasts.
The remaining safe description errors do not broaden effects or count as passes.
Stop on changed identity/pins, target ambiguity, unexpected network/sensitive
permissions or data route, account/payment prompt, unexplained write, repeated
crash/ANR or cleanup failure. Reconcile merged components before execution.

The old raw evidence was deleted and cannot be reviewed again. The previous
sanitized report is historical context, not proof about this new APK. No workflow
superiority or fair process comparison is claimed for this informed rerun.

## Fresh qualification reconciliation

The new APK was inspected and deleted; qualification.md records identity,
signer, two non-dangerous requested permissions, AndroidX provider/guarded
receiver and four native ABIs. No new network/sensitive route was found in this
bounded manifest inspection. Safety PASS and claims FINDINGS_RECORDED remain
applicable to the same authorized scope. This does not resolve listing errors
or turn any game feature into a runtime pass.
