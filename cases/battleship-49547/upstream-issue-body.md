Hi, and thanks for making Battleship available as open source.

During an independent source-only review of v1.0.11 (`35189f727db1cc80bdc55e9996bdcaa443914571`), I noticed a few places where the descriptions may be ahead of, or behind, the implementation. This review was prepared with Codex under human direction. We did not download an APK, install the app, or test runtime behavior, and we are not speaking for F-Droid.

### Game mode and placement

The [English listing](https://github.com/cocodedk/Battleship/blob/35189f727db1cc80bdc55e9996bdcaa443914571/fastlane/metadata/android/en-US/full_description.txt) and README advertise two-player pass-and-play and drag-and-drop ship placement.

The source path I could trace goes from the menu to one player's placement and then an AI opponent: [GameViewModel](https://github.com/cocodedk/Battleship/blob/35189f727db1cc80bdc55e9996bdcaa443914571/app/src/main/java/com/cocode/battleship/presentation/game/GameViewModel.kt) generates the opponent board in `confirmPlacement()` and schedules `aiAttack()` after the player's move. The menu's mode label also says single player against AI.

For placement, [PlacementScreen](https://github.com/cocodedk/Battleship/blob/35189f727db1cc80bdc55e9996bdcaa443914571/app/src/main/java/com/cocode/battleship/presentation/placement/PlacementScreen.kt) and [GridCell](https://github.com/cocodedk/Battleship/blob/35189f727db1cc80bdc55e9996bdcaa443914571/app/src/main/java/com/cocode/battleship/presentation/components/GridCell.kt) appear to use cell taps, a rotation button and automatic placement.

Have I missed an entry point for two human players or a drag gesture? If those are planned features, a small description update to say single-player versus AI and tap-to-place would help users know what this release offers. These listing and implementation files were unchanged when checked against main at `45fe6631ad8376540c41b6505336085cb6c72c85`.

### Backup wording

The [privacy policy](https://github.com/cocodedk/Battleship/blob/35189f727db1cc80bdc55e9996bdcaa443914571/privacy.md) already explains that Android/Google backup may include game data. Its earlier paragraph nevertheless describes the data as staying only on the device, never being sent to a third party, and disappearing on uninstall or data clearing.

Could that paragraph distinguish app-controlled transmission and deletion of the on-device copy from OS-managed backup and restore? This is a wording clarification, not an allegation of hidden transmission: the backup exception is already disclosed, and we did not observe or test any backup.

Two smaller documentation details surfaced in the same review: the listing says 15 medals, while `Badge.entries` contains 33 entries and the medal screen maps them all; `llms.txt` says there is no persistence, although career statistics use SharedPreferences. These may simply be older descriptions.

A documentation-only correction would be useful if it reflects the intended current behavior. Please let us know if any of this interpretation is mistaken.
