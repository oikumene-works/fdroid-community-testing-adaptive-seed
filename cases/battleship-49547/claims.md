# Battleship public claim review

Status: `CLARIFICATION_REQUIRED`. Evidence class: exact-source review only.

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

## Claim-to-source findings

All paths below refer to the exact source commit above. Statements about source
behavior are static findings, not observations of a running app.

| Public claim | Exact evidence | Assessment |
| --- | --- | --- |
| Fastlane short/full descriptions and README advertise two-player pass-and-play. | `MenuScreen.kt` has one start callback. `BattleshipNavHost.kt` routes that callback directly to placement. `GameUiState.kt` models playerBoard and aiBoard. `GameViewModel.confirmPlacement()` always generates an AI board; `playerAttack()` schedules `aiAttack()`, which always calls `BattleshipAI.chooseAttack()`. `strings.xml` explicitly labels the mode single player against AI. No second-human mode, selector, placement, handoff, or turn path was found across main source. The privacy policy also calls it single-player. | Material contradiction. Clarify/remove the advertised mode or provide the corresponding implementation at a newly pinned version. This finding alone closes the claim gate. |
| Fastlane and README promise manual drag-and-drop placement. | `PlacementScreen.kt` wires cell clicks to `placeShip`, with separate rotation and auto-place buttons; `BattleGrid.kt` passes onCellClick; `GridCell.kt:133` uses Modifier.clickable. No drag or pointer-gesture placement path was found. | Clarification required: the inspected path is tap placement, not a drag-and-drop path. Runtime gestures were not tested. |
| Privacy text says game data is only on the device, never sent to any third party, and removed upon app deletion/data clearing. | Manifest sets allowBackup=true and references backup_rules.xml and data_extraction_rules.xml. Both contain no operative exclusion of shared preferences. Career data and medal counts use private SharedPreferences named career_stats. The policy itself later permits Android/Google backup. | Clarification required: distinguish app-controlled transmission and local deletion from OS-managed backup/restore. This does not establish that any backup actually occurred. |
| No internet, account, ads, tracking, or sensitive permissions; VIBRATE is the only declared permission. | Main source manifest declares only android.permission.VIBRATE, exports only launcher MainActivity, and defines no service/receiver/provider. Declared production dependencies are AndroidX/Compose/navigation/lifecycle and Kotlin coroutines. No app network/account/billing/analytics client was found. | Consistent at source level. Merged dependencies, certificate, binary identity and all built surfaces remain unqualified. Read the third-party-SDK wording narrowly as tracking SDKs; standard third-party libraries clearly exist. |
| Footer links open externally. | MenuFooter.kt delegates only the fixed developer URL and GitHub latest-release page to LocalUriHandler.openUri. No embedded browser, downloader, document/share input, or app link was found. | Consistent statically. No link was opened in an Android app. Source web-font URLs belong to website HTML, not the app network surface. |
| 10x10 board, five ships, five unlockable weapons, eight ranks, generated audio, and career persistence. | Board/GameConfig/ShipType, SuperWeapon, Rank, SoundManager, GameViewModel, SessionStats and SharedPreferences storage provide those paths. | Source support, no functional result. Boundary weapon patterns are clipped by resolveWeaponCells; a five-cell sweep does not cover a whole ten-cell row. English/Persian website wording describing a whole row is overbroad. |
| Listing/README/English and Persian website count 15 medals. | Badge.kt defines 33 entries; MedalsViewModel and BadgesViewModel both map all Badge.entries. | Stale numeric claim. Correct alongside the functional listing; this is not evidence of missing medals in a built app. |
| llms.txt says there is no persistence. | SharedPreferencesSessionStatsStorage and SharedPreferencesMedalsStorage persist career data. | Stale auxiliary documentation. It is untrusted claim material, not an instruction for this review. |
| MR says the build is reproducible and offline. | Exact-head pipeline and build succeeded; trace reports verification and emits the Code Quality APK URL. GitHub reports an uploaded asset digest; fdroiddata pins the signer. | Provider evidence only. No independent rebuild or binary inspection was performed. |

## Scope and decision

Reject this exact candidate from later gates as `CLARIFICATION_REQUIRED`.
The missing advertised two-human path is independent of the backup-wording
finding observed in the earlier Chess Puzzles case. No runtime failure, security
vulnerability, or F-Droid acceptance/rejection decision is claimed.

The live custom website and canonical hosted privacy page could not be read
through the web reader; this review binds the website files at the exact source,
not an assertion that the currently deployed site has identical bytes. A future
passing preflight must also establish the then-current effective live claims.

Do not clear the status locally to bypass these conflicts. A materially changed
MR/source/listing requires a new exact review and digest. This review authorizes
no APK download, qualification, activation, Android action, upstream contact,
issue/comment, push, upload, or publication.

Android backup interpretation follows the official documentation:
<https://developer.android.com/identity/data/autobackup>. Shared preferences are
included by default; actual backup also depends on device/user/transport state.
