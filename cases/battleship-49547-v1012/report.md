# Codex-executed bounded functional re-verification — Battleship 1.0.12

Completed 2026-09-22. The sampled placement/AI path and nonzero career persistence
worked; several description corrections remain incomplete. Codex performed source
inspection, Android inputs, evidence analysis, writing and cleanup under the
human operator's direction and authorization. No human-operated gameplay or
independent human reproduction is recorded. This is independent community
evidence, not a human usability test or F-Droid acceptance decision.

## Exact candidate and environment

- MR: https://gitlab.com/fdroid/fdroiddata/-/merge_requests/49547
- MR head dc779e4e3ddacfaa69edeadecd5e744f81b6e883; pipeline 2870057107;
  build job 16644446213, all rechecked before executable actions.
- Package com.cocode.battleship, version 1.0.12 / 1000012.
- Upstream v1.0.12, source d1cdd2e3afe02865a901a51d3e05daedbc4b24ed.
- Exact Code Quality-linked APK SHA-256:
  8109f17500a1d8ab69fb717355b10b69ced22920c92e5114d4fbdd86a5ecc6ba.
- Verified signer SHA-256:
  6120b56d569c8ccb013f5fa08dd08790194ba2c390fa97e12e0eb36ef1599e21.
- Disposable Pixel7 AVD, AOSP Android14/API34 x86_64, en-US,
  Europe/Helsinki; wiped data, no snapshots, Google account or Play Store.
- Android fingerprint:
  Android/sdk_phone64_x86_64/emu64x:14/UE1A.230829.036.A1/11228894:userdebug/test-keys.
- Existing Linux SDK and build tools 36.0.0; isolated, exactly targeted ADB.
  No SDK installation/license change or physical/shared-device testing.
- Qualification ran at a48e9f7938d2243e47fb8f2fe85fef179776e4ca;
  qualified checkpoint 51215e8baa806c939e2c755239483133e2bc1bc6;
  execution checkpoint ac41e3e8b348d4eed6db596eeec321351e9eb04a.

Qualification and execution re-download independently matched the new APK digest,
package/version/SDK, signer and pinned merged manifest surface. Signature and ZIP
alignment checks passed in the provided no-network parser sandbox. Requested
permissions were VIBRATE and the app-scoped signature-protected dynamic-receiver
permission. No INTERNET or dangerous requested permission was found. AndroidX
provider/guarded receiver controls were reconciled in qualification.md. This is
neither an independent rebuild nor an audit of all executable/native behavior.

## Runtime observations

| Planned item | Result | Bounded observation |
| --- | --- | --- |
| Install and English launch | Pass | Streamed installation succeeded and explicit launcher start returned COLD/status ok. The English menu appeared; no account/payment/runtime-permission prompt in exercised paths. |
| Tap placement | Pass, sampled | A1 placed the horizontal carrier across A1-A5 and advanced the selection to Battleship. A second A1 tap left that state and horizontal orientation unchanged. |
| Rotation control | Pass, sampled | Tapping the separate HORIZONTAL button changed the pending orientation label to VERTICAL. The already placed carrier remained horizontal. Placement of the next vertical ship and a full boundary matrix were not tested. |
| Auto-deployment and combat entry | Pass | Auto Deploy replaced the partial arrangement, displayed FLEET DEPLOYED, and enabled combat. Initiate Combat opened the target/own grids and player-turn indicator. Random fleet layout was not externally seeded. |
| Single-player AI path | Pass, one game | A fixed checkerboard sweep of ordinary shots reached FLEET DESTROYED / DEFEAT after 51 accepted shot inputs. Player hits/misses, AI responses and AI sinking the player's fleet were observed. Only visible UI state was read; no hidden board or app-private data was inspected or edited. |
| Result display | Partial | ENSIGN, score 358, shots 51, hits 8, misses 43, accuracy 15%, enemy ships sunk 0; summary games 1, wins 0, streak 0, best 358. These are displayed results, not independent validation of ranking/scoring formulas. |
| Career persistence | Pass, sampled | Initial career screen said no completed missions. After defeat it displayed games 1, victories 0, win rate 0%, current/longest streak 0, highest rank ENSIGN, best 358, total shots 51, accuracy 15%. All visible career text matched after explicit force-stop and cold launcher restart. No reboot/update/reinstall/backup persistence claim. |
| Medal/badge registries | Partial | After cold restart, both opened and displayed 2/33 earned; result screen had displayed two earned badge/medal icons. Individual awards, all 33 items and every storage field were not audited. |
| Final identity/crash inspection | Pass, bounded | Installed version remained 1.0.12/1000012 with min/target SDK 24/36. Inspected crash and filtered am_crash/am_anr event buffers were empty. Exit history contained the intentional user-requested force-stop. No long-term stability claim. |
| Cleanup | Pass | Uninstall, wiped reboot, package/Downloads absence, process/port stop and artifact/AVD deletion verified below. |

One complete game was needed to populate meaningful career data for the approved
persistence check. Gameplay ended within the 15-minute limit. No second game,
weapon activation, all-feature matrix or attempt to reproduce the old area-hit
count was added. This run's defeat complements the historical 1.0.11 victory;
it does not make the versions interchangeable or establish all outcomes correct.

## Source correction review, separate from runtime

All references here use the pinned 1.0.12 source; the complete claim-file digest
index is evidence-index.md. The 11-file delta has no app/src changes, but
app/build.gradle.kts:90-100 changes native-library packaging to preserve debug
symbols. Therefore the release is not literally documentation-only. Provider
CI reports a successful binary comparison; no local independent rebuild occurred.

1. **Two-human mode remains advertised in both store descriptions.**
   fastlane/metadata/android/en-US/full_description.txt:1 and
   short_description.txt:1 still promise pass-and-play. README removed it and
   the new changelog explicitly says it does not exist. The unchanged source
   routes play to AI. Correct both listing strings; no two-human runtime pass.
2. **Rotation wording is ambiguous.** README.md:19 and full_description.txt:3
   say to tap again to rotate. Source has a separate orientation button; our
   sampled second cell tap did not rotate, while that button changed pending
   orientation. Describe tapping the rotation button, rather than suggesting
   that another tap on the placed ship rotates it.
3. **Medal-count corrections are incomplete.** README and the full listing now
   say 33. English website/index.html:560 still says 15 MEDALS, despite corrected
   main sections. Persian website/fa/index.html:7,42,280,510,571 still says 15
   using Persian digits; only its English featureList was updated. Runtime
   registry headers showed 33 total, without an exhaustive item audit.
4. **Sonar correction is localized only partly.** English website/index.html:215
   now describes five centered cells clipped at the edge; Persian
   website/fa/index.html:226 retains whole-row wording. This is source text
   review; no Sonar use occurred in this rerun.
5. **Backup clarification is partial.** English website/privacy.html:84 mentions
   a surviving Android backup copy. privacy.md:15-18 and the Persian paragraph
   at website/privacy.html:132-134 retain broad local/deletion language, with
   backup separately disclosed later. Align these versions. No actual backup,
   hidden transmission or privacy violation was observed or tested.
6. **Auxiliary persistence wording was corrected.** llms.txt:16 now describes
   app-private career/medal storage, consistent with the inspected source and
   our new bounded cold-restart career observation.

The additional English 15 MEDALS heading was found in the final pinned-text
cross-check. claims.md and its digest were updated to include it; candidate,
safety classification and runtime scope did not change. The old repeated-hit
interpretation remains historical source/runtime evidence from 1.0.11 plus the
developer's confirmation. It was neither re-tested nor resolved by this rerun.
These source checks do not attest the bytes currently deployed on the website.

## Exclusions and evidence limits

No weapons were unlocked/used, the player sank no enemy ship, and no victory
was reached in this run. Also untested: audio/haptics, drag gesture,
two-human mode, complete placement/edge/award matrices, calibrated AI-turn race
behavior, Deploy Again, mid-game restart, alternate API/device/locale/orientation,
long-term stability, upgrade from 1.0.11, reboot/reinstall or backup/restore.
No external footer link, account, sensitive data, permission grant, profile
receiver action, scanner upload, network capture, comprehensive policy/security
review or independent rebuild was included. No application source was changed.

Only sanitized observations survive. Both this run's raw UI/screenshot/log data
and the older test's raw evidence were deleted under the evidence policy.
Their original readings and tool responses cannot now be independently audited
from retained raw artifacts. Exact public source and binary identities remain
available for a separately authorized future reproduction. This informed rerun
is not a controlled comparison of the adaptive and traditional workflows.

## Timeline, UTC on 2026-09-22

| Milestone | Time / interval |
| --- | --- |
| Source-preflight records written | 06:15:46; reading/discovery before this was not independently timed |
| Qualification helper | Start marker 06:16:21; final journal write 06:16:34.723; about 14 s including recheck and deletion |
| Execution download/recheck/inspection | 06:18:08.860-06:18:21.785; 12.926 s, transient file timestamps |
| Emulator start/recheck/boot | 06:18:21.789-06:18:53.915; 32.126 s, transient file timestamps |
| Installation began | 06:19:08 |
| First menu / initial empty career | 06:19:11.514 / 06:19:27.264 |
| Combat screen / defeat first captured | 06:20:26.346 / 06:24:24.619 |
| Career before / after cold restart | 06:24:59.369 / 06:25:04.249 |
| Final package/crash inspection | 06:25:47.518 |
| Stock cleanup start / completion | 06:26:01 / 06:26:26; 25 s at second resolution |
| AVD deletion and final local inventory verified | 06:26:48 |

Install-to-final-inspection was about 6 min 40 s; combat-to-first-result capture
3 min 58.274 s. Cleanup through final AVD/file verification was 47 s. These
include tool waiting, review and automation overhead. Active Codex time, operator
observation time and waiting were not independently measured. No human input or
approval wait occurred during execution. These are not application performance
benchmarks or evidence of one workflow's efficiency advantage.

## Verified cleanup and publication state

Stock CLEANUP_VERIFICATION=PASS followed uninstall, emulator stop, wiped reboot,
package and Downloads absence, second emulator stop, isolated-ADB shutdown and
closed case-port/process checks. The project-local AVD was then deleted through
the SDK tool; its absence was checked. Empty case-state directories were removed.
Final recursive .local inventory contained only mode-600 seed/profile.env and
config/android.env. No APK, AVD, raw evidence, UI driver, source snippets,
case emulator or isolated-ADB session remains. The pre-existing unrelated host
ADB server was not targeted. This is a case-scoped cleanup claim.

No external mutation, push, report/comment publication, upload or release occurred
in this task. Existing public notes concern the historical case. public-comment.md
is a new local draft, not approved or sent. The case is inactive after cleanup.
