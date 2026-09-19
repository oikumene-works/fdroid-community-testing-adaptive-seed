# Social Deduction Game MR !47820 — Bounded Functional Test Report

**Independent community test report**

Evidence class: bounded functional test of the explicitly listed paths. This
is independent community evidence produced outside F-Droid; it is not an
F-Droid review, acceptance decision, security audit, usability assessment, or
endorsement.

- Executor: OpenAI Codex controlled the dedicated emulator under the operator's
  explicit authorization.
- Human involvement: the operator separately approved the executable downloads
  and both execution-through-cleanup slices, and made the visible UI available
  for optional observation; the operator performed no UI steps. This was not a
  human usability test.
- Test date: `2026-09-19`
- Exact MR head: `635a3810ad37281759bca4913af2e590f8cedbf5`
- Pipeline/build job: `2823065044` / `16326052363`
- Upstream source: `aef417cd595433f3d3acfd17c91508f1f971e66a`
- App: Social Deduction Game `0.9.0` (`versionCode` `1`)
- APK SHA-256: `c959287b3f3dc66284fbcb793fb4fcbe80c41a21bef354a1746ee7253772d345`
- Signing-certificate SHA-256:
  `b488a7fafa66962ec9ec414933e313bf447ccee3cc7114c04d6b180d1a81cd1c`
- Environment: visible, wiped `FdroidCommunity_Disposable_API34`; AOSP Android
  14/API 34 x86_64 Pixel 7 profile; build
  `Android/sdk_phone64_x86_64/emu64x:14/UE1A.230829.036.A1/11228894:userdebug/test-keys`;
  `en-US`; `Europe/Helsinki`; verified at `2026-09-19T05:28:54Z`
  (`2026-09-19T08:28:54+0300`) and again at `07:49:39Z`
  (`10:49:39+0300`).
- Result: `PASS` for the exercised paths, with two minor UI observations and
  one inconclusive prompt observation. A focused retest recorded the planned UI
  version/licenses view and verified five non-default settings after an exact
  app-process force-stop and cold relaunch. Both cleanup cycles passed.

## Timeline and Duration

- Candidate selection: `2026-09-19T04:38:56Z`–`04:49:48Z` (10m52s).
- Exact source/public-claim preflight: `04:50:01Z`–`05:00:39Z` (10m38s).
- Qualification approval wait: 15m31s; approved qualification and deletion:
  `05:16:10Z`–`05:16:33Z` (23s).
- Activation and operational execution-readiness checks completed at
  `05:20:57Z`. A later process audit found that this boundary had not been
  committed and the worktree was therefore not a recoverable clean Git
  checkpoint.
- Execution approval wait from that checkpoint: 6m27s.
- Live recheck and exact execution download began at `05:27:24Z`; requalification
  passed at `05:28:14Z`, install at `05:29:08Z`, and cold launch at `05:29:35Z`.
- Visible functional work through final inspection: `05:29:35Z`–`06:24:36Z`
  (55m01s).
- Verified cleanup completed at `06:25:40Z`; the atomic execution-through-cleanup
  slice lasted 58m16s, including about 24s for the cleanup command.
- Post-cleanup report/checkpoint preparation completed at `06:30:33Z` (4m53s).
- Initial active work through the first report checkpoint totaled 1h29m26s:
  selection, preflight, qualification, activation/handoff/hygiene, execution,
  cleanup, and report preparation.
- From candidate-search start through that hygiene-checked report checkpoint:
  1h51m37s end to end. Explicit approval waiting totaled 21m58s, and a 13-second
  transition between selection and preflight was not classified as active work
  or operator waiting.
- The operator provided a 90-minute uninterrupted availability window. No
  minimum-duration soak result is claimed; the measured execution duration is
  the 58m16s stated above.
- After the process audit, the operator provided a fresh 30-minute window and
  separately approved a focused retest. Exact recheck and requalification began
  at `07:48:38Z`; install and cold launch completed at `07:49:49Z`; focused UI
  work and final inspection completed at `07:59:52Z`; verified cleanup completed
  at `08:02:14Z`. This second execution-through-cleanup slice lasted 13m36s.

## Public Claim Review

The claim-surface scan SHA-256 is
`578d6cd77b013f9c87362defcc7fb7bf70d3b4dabbdb6104c230e2d5dd82f26d`; the
digest-bound review SHA-256 is
`5fa1fd449a437276a09e6bfce652a70e05df2b01aa294f69e5e61caf093e97c8`.
Status was `PASS`. The offline/local-data claims matched the lack of `INTERNET`,
the packaged seed and local storage paths, and disclosed user-selected
import/export/share paths. No material inconsistency stopped installation.

## Basic Function

Cold launch showed the English main menu without an account, terms, payment,
advertising, tracking, or permission gate. Codex created a synthetic rule set
with two teams, four roles, one temporary status, a night order, and an action;
edit, cancel, rename, duplicate, and delete paths were exercised.

Four-player games were created through team-count random assignment,
selected-role random assignment, and manual assignment. Seating and synthetic
player names, private full-screen role reveals, public overview, Setup/Night
1/Day 1/Night 2 transitions, ordered night list, action source/target selection,
a life-state change, and temporary-status expiry were checked. Each reveal
showed the current player identity and one role without exposing another
player's role.

Continue, save, same-name rejection, save-as, save-as-template, load, rename,
duplicate, delete, and unsaved-exit confirmation worked. A game created from a
template reset player names, life states, and phase while retaining the setup;
later saved-game changes did not alter the template.

Synthetic JSON export/import round-tripped after an existing-name conflict was
canceled. The file picker was canceled once. The system share chooser was
opened and canceled without a recipient; this minimal AOSP image reported that
no app could perform the share. Library backup preview identified storage
version 1, two valid rule sets, and zero discarded rule sets. After deleting the
test rule set, restore returned it with two teams/four roles and returned its
template. Invalid JSON was rejected inline without overwriting valid data.

Settings for language, theme, text size, reduced motion, seating, role symbols,
keep-awake, haptics, and automatic rotation responded. Portrait and landscape
rendered without an observed layout break. In the focused retest, Dark
appearance, Large text, Reduce motion enabled, Keep screen awake enabled, and
Haptic feedback disabled remained visible after normal Back navigation, an
exact-package force-stop, and a cold relaunch.

Settings/About displayed version `0.9.0`, software license `GNU AGPL v3.0
only`, copyright holder `Jens Aßmus`, and SPDX identifier `AGPL-3.0-only`.
The full GNU Affero GPL v3 dialog opened, as did the third-party notices dialog,
which listed 17 npm runtime packages and 51 Android runtime artifacts.

## Functional Coverage

| Checklist item | Result | Durable observation or limitation |
| --- | --- | --- |
| 1. Exact recheck and APK identity | Pass | Head, pipeline, job, source, digest, package, SDK, certificate, permissions, components, features, ABI, and alignment matched. |
| 2. Cold launch and basic gates | Pass | English launch and absence of account, payment, tracking, and permission gates passed; the focused retest recorded the UI version and license details and opened both license dialogs. |
| 3. Rule-set editing | Pass | Two teams, four roles, status, night order, action, edit, cancel, rename, duplicate, and delete were exercised. |
| 4. Assignment methods and template isolation | Pass | Team-count random, selected-role random, and manual assignment passed; later game edits did not mutate the template. |
| 5. Gameplay path | Pass | Seating, private reveals, public overview, phase changes, ordered night entry, source/target selection, life change, and status expiry were observed. |
| 6. Saved-game lifecycle | Pass | Continue, save, same-name rejection, save-as, template, load, rename, duplicate, delete, and unsaved-exit confirmation were exercised. |
| 7. Export, import, and share | Pass within scope | Synthetic JSON round-trip passed; picker and recipient-free share chooser were canceled without upload. |
| 8. Backup, restore, and invalid input | Pass | Preview and restore recovered the expected library; invalid JSON did not overwrite valid data. |
| 9. Settings and rotation | Pass | Controls responded and both orientations rendered; five non-default values persisted after normal navigation, exact-package force-stop, and cold relaunch. |
| 10. Final inspection and cleanup | Pass | Final package/permission and bounded crash/ANR checks passed; uninstall, wipe, artifact removal, and stop were verified. |

## Observations

1. Immediately after the first save, the Test Rule Set library card displayed
   zero teams and zero roles, while reopening it showed the stored two teams and
   four roles. The card showed the correct counts after backup restore/reload.
2. After changing language to German and back to English, Save game as template
   suggested the mixed-language default `Test Template Vorlage`.
3. During early rule-set editing, one unsaved-exit prompt appeared after a save
   success message. Later save flows did not reproduce it, so this remains
   inconclusive rather than a confirmed defect.

No repeated crash, ANR, valid-data loss, or functional blocker was observed.

## Policy-Facing Observations

The app required no account, real personal data, secret, contact, image,
payment, advertising, or tracking interaction. Only synthetic names and files
were used. No dangerous or runtime-grantable permission existed, so picker and
share-chooser cancellation were the denial cases; no unexpected permission
prompt appeared. No external recipient was selected, nothing was uploaded, and
no physical device was used. This is a bounded functional observation, not a
security audit or F-Droid acceptance decision.

## Final Package Inspection

In both execution slices, the final installed package remained
`io.github.jens_3.socialdeductiongame` 0.9.0 (1), minimum SDK 24 and target SDK
36. It requested and held only `android.permission.VIBRATE` and its own
signature-protected
`io.github.jens_3.socialdeductiongame.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION`;
the runtime-permission set was empty. The host APK digest still matched the
pinned SHA-256. Neither bounded final log search found a candidate
fatal-exception or ANR marker.

## Cleanup

`PASS` for both execution slices. Each time the candidate was uninstalled, the
dedicated AVD was clean-wiped and rebooted to verify package absence, and the
emulator and isolated ADB server were stopped. The APK, synthetic exported
documents, runtime logs, and raw case evidence were removed. Project ports
5580, 5581, and 5041 were not listening. No upload or external mutation
occurred.

## Publication Boundary

Testing and report preparation caused no external mutation. Publishing this
report does not authorize or imply a merge-request comment; any such comment is
a separate action and should link to this exact report through an immutable
permalink.
