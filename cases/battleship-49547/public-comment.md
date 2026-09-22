## Bounded functional test: Battleship 1.0.11

Following the request for testing, here is a partial functional result from
2026-09-22. OpenAI Codex executed the synthetic inputs through targeted ADB and
inspected UI trees/screenshots under operator direction. This was not a human
usability test. The exercised single-player AI path worked through one complete
game; advertised-feature discrepancies remain below. This is independent
community evidence, not an F-Droid approval or a comprehensive policy/security
assessment.

### Exact build and environment

- MR head: `f2577e78cab813fde78b11d16b7c7b05dd88ea69`; pipeline `2867295579`,
  [build job 16624306623](https://gitlab.com/cocodedk/fdroiddata/-/jobs/16624306623).
- Package `com.cocode.battleship`, version `1.0.11` / `1000011`; upstream
  `v1.0.11`, source `35189f727db1cc80bdc55e9996bdcaa443914571`.
- Tested APK: the exact Code Quality-linked binary; SHA-256
  `27c558552dc9cbd00fbb34c619aab72dbc21bd870d68a48f4cc4bc9f7b32a0d9`.
  Local APK checks matched package/version, signer and pinned manifest surface;
  signature verification and ZIP alignment passed. No independent rebuild.
- Disposable Pixel 7 AVD, AOSP Android 14/API 34, x86_64, en-US; Linux host.
  Wiped initial data, no snapshots, Play Store or Google account. No physical
  device was tested.

### Tester-review checklist

| Item | Result and scope |
| --- | --- |
| Start and basic operation | Passed in the sampled path: English launch, manual tap placement, rotation, invalid edge/overlap rejection and automatic placement; one complete AI game reached victory. |
| Functions in the description | Partial. Four of five weapons were unlocked, selected, fired and consumed: Torpedo Spread, Sonar Sweep, Barrage and Carpet Bomb. Depth Charge was not fired because the game ended when its unlocking ship was sunk. Two-human/drag claims remain unresolved. |
| Results and persistence | Victory displayed ADMIRAL, score 2713, 59 shots, 18 hits, 41 misses, 30% accuracy and five ships sunk. Career totals matched after force-stop and cold relaunch; both medal/badge registries displayed 7/33 earned. A new mission restored the empty placement screen. Score/rank formulas and individual award conditions were not independently validated. |
| English support | Observed in exercised menus and gameplay. |
| Permissions | Qualified APK requested VIBRATE and its app-scoped signature permission `com.cocode.battleship.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION`. No INTERNET, MANAGE_EXTERNAL_STORAGE or dangerous requested permission was found. No runtime permission prompt appeared and no grant was sent. Optional-permission denial was therefore not exercised. |
| Network checks | No INTERNET permission in the qualified APK; no traffic capture performed. Footer external links were inspected as labels but not opened. This is not proof of every privacy claim. |
| Categories | The pinned recipe lists Board Game and Strategy Game, consistent with the exercised naval board-game path. |
| Additional terms | Not separately audited. No account or payment gate appeared in the exercised path; this is not a complete terms-of-use assessment. |
| Unique launcher icon | Not separately checked; no pass claimed. |
| Inclusion Policy / external security scan | No comprehensive policy audit or VirusTotal/equivalent scan performed; no APK uploaded to a scanner. |
| Crash/ANR inspection | No app crash/ANR marker in the inspected session buffers; exit history showed the intentional force-stop. This does not establish long-term stability. |

### Description/source findings remain open

The earlier source-only findings are in
[upstream issue #55](https://github.com/cocodedk/Battleship/issues/55). The runtime
results above are additional evidence; they do not resolve those findings:

- The [pinned English listing](https://github.com/cocodedk/Battleship/blob/35189f727db1cc80bdc55e9996bdcaa443914571/fastlane/metadata/android/en-US/full_description.txt)
  and README advertise two-player pass-and-play and drag-and-drop placement.
  The inspected source routes the start action through one placement screen to
  an AI opponent and uses cell taps, rotation and automatic placement. Runtime
  showed the single-player/AI label and tap-based path; no two-human mode or drag
  gesture was tested. Please clarify any missed entry point, or update the
  descriptions to match this release.
- The descriptions say 15 medals; the observed registries showed 33 total
  entries. `llms.txt` says there is no persistence, while career values survived
  the sampled cold relaunch. These appear to be stale descriptions.
- The privacy policy already discloses possible Android/Google backup. Its
  broader local-only/deletion wording should distinguish app-controlled
  transmission and deletion of the local copy from OS-managed backup/restore.
  No backup or hidden transmission was observed or tested.
- Website source describes Sonar as covering a whole row. In the sampled edge
  use, targeting C10 affected C8–C10; the source review describes a clipped
  five-cell sweep. The whole-row wording is broader than that evidence.

### Area-weapon counting observation

The result's 59 shots/18 hits exceeded the reconstructed 58 distinct attacked
cells/17 distinct hit cells by one. Barrage at F5 included already-hit D5
alongside eight new cells. This is consistent with counting that repeated
hit-cell attempt. A separate inspection of the pinned
[weapon logic](https://github.com/cocodedk/Battleship/blob/35189f727db1cc80bdc55e9996bdcaa443914571/app/src/main/java/com/cocode/battleship/presentation/game/GameWeaponLogic.kt)
and [trackers](https://github.com/cocodedk/Battleship/blob/35189f727db1cc80bdc55e9996bdcaa443914571/app/src/main/java/com/cocode/battleship/presentation/game/GameTrackers.kt)
supports this interpretation: resolved weapon cells are passed to tracker
updates, which count cells already in HIT/SUNK state. It does not establish a score defect:
counting attempts may be intended, and a unique-cell metric was not established.
The deleted UI artifacts cannot now be independently recounted.

### Limits, timing and cleanup

Coverage was one game on one emulator/API/locale. Defeat, the fifth weapon,
audio/haptics, full edge/weapon/medal matrices, Deploy Again, mid-battle restart,
backup/restore and alternate devices were not tested. AI-turn input blocking
was sampled only; timing was not calibrated.

Installation began at 03:18:59 UTC; final package/crash inspection ended at
03:30:02 (11 min 03 s wall time). Combat-to-victory captures spanned 7 min
13.158 s. Cleanup ran from 03:30:14 through final AVD/file verification at
03:31:09 (55 s). These include tool waiting and review, not application
performance measurements; active versus waiting time was not separately measured.

Recorded cleanup verified uninstall, wiped reboot and package/Downloads absence,
emulator/isolated-ADB stop and closed case ports. The case AVD, APK and raw
logs/screenshots/UI dumps were deleted. Only sanitized observations were kept,
so the original runtime observations and historical tool responses cannot now
be independently re-audited from raw artifacts.

Please treat this as a bounded successful AI-game test with unresolved listing
findings and explicit coverage gaps, not an all-functions pass. Corrections to
the descriptions, or clarification of the missing paths, would help complete
the review. Please point out any mistaken interpretation.
