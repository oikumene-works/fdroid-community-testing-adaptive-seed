# Bounded functional test — Battleship 1.0.11

Completed on 2026-09-22 with partial feature coverage and verified cleanup.
This is independent community evidence, not an F-Droid decision or a general
security, privacy, accessibility or usability assessment. Codex executed all
input through the seed's targeted ADB procedure and inspected transient UI trees
and screenshots. No operator interaction or human usability test was recorded;
possible passive observation is not evidence of either. No publication is approved.

## Candidate and authority

- App: `com.cocode.battleship`, version `1.0.11` / `1000011`.
- MR: <https://gitlab.com/fdroid/fdroiddata/-/merge_requests/49547>.
- MR head: `f2577e78cab813fde78b11d16b7c7b05dd88ea69`.
- Pipeline `2867295579`; build job `16624306623`.
- Upstream `v1.0.11`, source `35189f727db1cc80bdc55e9996bdcaa443914571`.
- APK SHA-256: `27c558552dc9cbd00fbb34c619aab72dbc21bd870d68a48f4cc4bc9f7b32a0d9`.
- Signer SHA-256: `6120b56d569c8ccb013f5fa08dd08790194ba2c390fa97e12e0eb36ef1599e21`.
- Static decisions remain TEST_SAFETY_STATUS=PASS,
  CLAIM_REVIEW_STATUS=FINDINGS_RECORDED, APK_QUALIFICATION_STATUS=PASS.
  Their unchanged digests and complete pins remain in case.env.
- Starting clean local HEAD and read-only origin main both matched
  `bec8dfbe9cff45dad7464cb539ebfba79bcac5ae`. Activation/authority were committed
  locally as `206e03cd99f6899fb489e287be7583f86dd668ce` before executable work.

The operator explicitly authorized this case from local prerequisite discovery
through activation, exact APK download/inspection, disposable Android preparation,
synthetic testing and verified cleanup to a clean local commit. The initial
live recheck, download helper's recheck and emulator-start recheck passed.
MR description, release body and latest note body also matched their recorded
hashes. No pinned input was changed to make an execution gate pass.

## Environment and binary checks

Linux reference environment; project-local disposable Pixel 7 AVD using installed
AOSP Android 14/API34 `default;x86_64` image revision 2, with no Play Store or
Google account. Visible initial launch, KVM, wiped data, snapshots disabled,
isolated ADB server and exact serial/AVD/API/qemu validation through stock helpers.
No physical device, personal profile or shared emulator was used.

Android fingerprint:
`Android/sdk_phone64_x86_64/emu64x:14/UE1A.230829.036.A1/11228894:userdebug/test-keys`.
Locale en-US; timezone Europe/Helsinki. Build-tools 36.0.0. The existing SDK
sufficed; no SDK package, license acceptance or portable seed change was needed.
AVD creation warned about SDK XML version/location compatibility but completed;
actual emulator boot, target validation, install and cleanup subsequently passed.

The exact recorded APK was downloaded once for this slice and re-inspected in
the stock Bubblewrap parser boundary. Digest, signer, package/version, SDK bounds,
ZIP alignment and all pinned built surfaces passed. Final installed identity
remained 1.0.11/1000011, minimum SDK 24 and target SDK 36. Requested/install-granted
permissions were VIBRATE and the app-scoped signature receiver permission;
runtime permission section was empty. No permission grant was sent by the test.

## Checklist and observations

| Planned path | Result | Actual evidence and limits |
| --- | --- | --- |
| Install and English launch | Pass | Streamed installation succeeded; explicit launcher start returned success and the English menu. No account/payment/runtime-permission gate appeared in exercised paths. |
| Placement, rotation and invalid positions | Pass, sampled | Horizontal carrier at A10 was rejected; A1 placed A1–A5 and advanced to Battleship. Repeating A1 did not add an overlapping ship. Rotation changed to vertical; Battleship at G10 occupied G10–J10 and advanced to Cruiser. No exhaustive boundary matrix. |
| Automatic placement | Pass | Auto Deploy replaced the partial arrangement with a complete visible fleet; combat became available and started. The random layout was not externally seeded. |
| Single-player AI game | Pass | One complete synthetic game reached victory. Player/AI misses and hits, opponent ship sinking, AI sinking player ships, turn transitions and all five enemy ships sunk were observed. No second complete game or defeat path. |
| Input during AI turn | Partial | A1 followed immediately by A2 produced only the A1 miss and one AI response; a later A2 tap was accepted. Immediate post-shot screenshots also showed ENEMY CALCULATING. Timing was not calibrated and races were not exhaustively tested. |
| Reachable weapons | Partial, 4 of 5 used | Torpedo Spread, Sonar Sweep, Barrage and Carpet Bomb were earned by normal play, selected, fired and consumed. Details below. The remaining Depth Charge was not fired; the Destroyer was the final ship sunk and the game ended. |
| Result, score and rank | Partial | Victory screen showed ADMIRAL, score 2713, 59 shots, 18 hits, 41 misses, 30% accuracy, five ships sunk. Display and propagation were observed; score/rank formulas were not independently validated. |
| Career persistence | Pass, sampled | Initially no missions. After victory: games 1, victories 1, win rate 100%, current/longest streak 1, highest rank ADMIRAL, best score 2713, total shots 59, accuracy 30%. These values matched after explicit force-stop and cold relaunch. No reboot/reinstall/backup persistence test. |
| Medals and badges | Partial | Both registries opened after relaunch and displayed 7/33 earned. Visible earned-count markers appeared; all 33 items and individual award conditions were not audited. |
| Restart | Partial | Returning to the main menu and starting a new mission restored an empty placement board, Carrier selected, horizontal orientation and disabled combat. The second mission was not played; the result screen's Deploy Again button and mid-battle restart were not exercised. |
| Footer and advertised mode | Partial | Menu explicitly displayed SINGLE PLAYER · vs AI · 10×10 GRID; developer/Get APK labels were inspected without activation. No separate two-human mode or drag gesture test was performed. |
| Audio and haptics | Not tested | No listening, acoustic measurement or real hardware haptic assessment. Animation screenshots are not audio/haptic evidence. |
| Package/crash/ANR inspection | Pass, bounded | Final package matched. Crash buffer and filtered am_crash/am_anr event output were empty. Exit history contained the expected user-requested force-stop only. This is limited to the observed session and retained buffers. |
| Device/artifact cleanup | Pass | Stock uninstall/wipe/reboot/absence/stop verification passed; case-created AVD and transient material were also deleted, as detailed below. |

### Weapon observations

- Sinking the Submarine at B3–D3 unlocked Torpedo Spread. Targeting J10 marked
  H10, I10 and J10 as misses, with no out-of-board or wrapped marks observed.
- Sinking the Cruiser at B5–D5 unlocked Sonar Sweep. Targeting C10 marked
  C8, C9 and C10 as hits. This observed edge use did not sweep the whole row.
- Sinking the Battleship at C7–C10 unlocked Barrage. Targeting F5 produced
  the cross D5–H5 and F3–F7: eight new marked cells plus already-hit D5.
  F3/F4/F5 were new hits; the other newly marked cells were misses.
- Sinking the Carrier at F1–F5 unlocked Carpet Bomb. Targeting H8 marked
  the nine-cell G7–I9 square as misses. The final Destroyer hits were E9/F9.
- Each tested weapon disappeared from the available selector after use and
  play returned to the normal AI/player sequence. Weapon combinations,
  cancellation, every edge and every already-attacked target were not covered.

### Counting observation: repeated area-weapon cells

The result screen's 59 shots and 18 hits exceed the reconstructed 58 distinct
attacked cells and 17 distinct hit cells by one. The last pre-victory UI tree
contained 57 attacked cells/16 hits; the final new F9 hit completed the fleet.
Barrage included the previously hit D5, consistent with one repeated hit-cell
attempt being counted. This is a reconstruction from the recorded UI observations;
the deleted UI trees and screenshots cannot now be independently recounted.
It is not a proven violation of a documented unique-cell metric or a
comprehensive score defect.

A separate read-only inspection of the exact source supports that interpretation:
GameViewModel passes every resolved weapon cell to updateTrackersForFire;
GameWeaponLogic counts each supplied cell, including its current HIT/SUNK state;
GameTrackers increments hits for HIT or SUNK. The source interpretation is not
itself runtime evidence. Additional source digests are in evidence-index.md.
No third-party build, test or script was executed. If unique damage is intended,
that expectation needs clarification before proposing a correction.

## Existing findings and exclusions

The original source-only two-human/drag findings remain open; normal tap/AI
success does not validate those advertised features. The listing/README claim
15 medals, while both observed registries displayed 33 total entries. llms.txt
says there is no persistence, while the sampled career values survived force-stop
and relaunch. Those runtime observations corroborate the earlier source findings
without validating every award or persistence condition.

The privacy policy already discloses possible OS-managed backup, but its broader
local-only/deletion wording needs to distinguish that backup from app-controlled
transmission and deletion of the local copy. No backup or hidden transmission
was observed or tested. The website source's whole-row Sonar wording is broader
than the sampled three-cell edge use. These are specific product/documentation
findings, not a general rejection of the app. Original claim-review bytes remain
historical and unchanged; exact claim/source pointers remain in claims.md.

No external link, account, real data, backup/restore, profiling/benchmark broadcast,
permission grant, APK rebuild, network-traffic audit, physical device, alternate
API/locale/orientation, long-term stability, loss path or full medal/weapon matrix
was tested. Only UI-visible state drove synthetic moves; hidden opponent state,
application data editing and debug cheats were not used.

## Timeline and duration limits (UTC)

| Milestone | Time / measured interval |
| --- | --- |
| Local preparation phase marker | 03:17:49; initial reading/discovery before it was not timed separately |
| Exact download/recheck/parser helper | 03:17:50.559–03:18:02.817; 12.258 s from transient journal timestamps |
| Start helper including live recheck/boot | 03:18:14.363–03:18:48.115; 33.752 s |
| Installation start | 03:18:59 |
| First menu captured | 03:19:02.308 |
| Combat start captured | 03:20:33.799 |
| Victory captured | 03:27:46.957 |
| Persisted career verified after cold relaunch | 03:28:41.887 |
| New mission's empty placement verified | 03:29:44.214 |
| Final package/crash inspection completed | 03:30:02 |
| Stock cleanup | 03:30:14–03:30:38; 24 s at second resolution |
| AVD deletion and final local file inventory verified | 03:31:09 |

Install-to-final-inspection wall time was 11 min 03 s; combat-to-result captures
span 7 min 13.158 s. Cleanup through final AVD/file verification spans 55 s.
These include automation/tool waiting and observation/review; Codex active time
versus waiting time was not separately instrumented. No operator-input or approval
wait was requested, and no operator active-testing duration exists. These are
workflow intervals, not application performance benchmarks.

## Verified cleanup and external state

The stock cleanup helper validated the exact emulator, uninstalled the app,
stopped it, booted the AVD with wiped data, verified no candidate package and
empty Downloads, stopped the emulator again and stopped the isolated ADB server.
It returned CLEANUP_VERIFICATION=PASS. Case ports 5041/5580/5581 were unbound;
no project emulator process remained. The same pre-existing unrelated host ADB
processes remained and were not targeted.

APK, screenshots, UI dumps, local automation helpers, downloaded source snippets,
raw package/crash journals and case runtime files were deleted. After the stock
cleanup, the case-created AVD was explicitly deleted and its now-empty Android
state directories removed. Recursive local-file inventory showed only the
mode-600 seed profile and completed mode-600 Android configuration. No device
state, APK, source snippet, raw evidence or emulator/isolated-ADB session remains.
Deletion followed the evidence policy. Only sanitized observations survive, so
the original UI readings, counter reconstruction and historical tool responses
cannot be independently re-audited from raw artifacts. Later local absence checks
corroborate current cleanup state, not the historical uninstall/wipe sequence.

There was no push, issue/comment mutation, upload, release or other publication
in this slice. Network access was read-only candidate verification, exact APK
retrieval and pinned source interpretation. Historical issue #55 and the earlier
static-result repository publication remain as recorded in case.md. This report
is local, sanitized and not approved for public posting.
