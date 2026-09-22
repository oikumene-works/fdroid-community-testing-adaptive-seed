## Codex-executed bounded re-verification: Battleship 1.0.12

Thank you for the release update. Codex inspected the pinned corrections and
performed a fresh, limited Android check under my direction and authorization
on 2026-09-22, then analyzed the evidence and prepared this report.
This is independent community evidence, not a human usability test or an
F-Droid acceptance decision.

**Candidate:** MR head `dc779e4e3ddacfaa69edeadecd5e744f81b6e883`, pipeline
`2870057107`, [build job 16644446213](https://gitlab.com/cocodedk/fdroiddata/-/jobs/16644446213),
upstream `v1.0.12` / `d1cdd2e3afe02865a901a51d3e05daedbc4b24ed`, package
`com.cocode.battleship` / `1000012`. Exact linked APK SHA-256:
`8109f17500a1d8ab69fb717355b10b69ced22920c92e5114d4fbdd86a5ecc6ba`.
Local inspection verified the version, signature, expected signer, SDK bounds
and merged manifest surface. No INTERNET or dangerous requested permission was
found. No independent rebuild was performed; native-library packaging changed
between releases even though the app's game source did not.

**Observed on a wiped disposable AOSP Android 14/API 34 x86_64 Pixel 7 AVD,
en-US:** installation, English launch, sampled tap placement, the separate
rotation button, automatic deployment and AI turns worked. One ordinary-shot
game ended in defeat: 51 shots, 8 hits, 43 misses, 15% accuracy, score 358,
ENSIGN. It was completed to populate nonzero career data. The displayed career
values matched after force-stop and cold relaunch; both award registries then
showed 2/33 earned. Inspected session crash/ANR buffers were empty.

Some source-description corrections are still incomplete at the tagged commit:

- **Pass-and-play remains in both store descriptions:**
  [full description, line 1](https://github.com/cocodedk/Battleship/blob/d1cdd2e3afe02865a901a51d3e05daedbc4b24ed/fastlane/metadata/android/en-US/full_description.txt#L1)
  and [short description](https://github.com/cocodedk/Battleship/blob/d1cdd2e3afe02865a901a51d3e05daedbc4b24ed/fastlane/metadata/android/en-US/short_description.txt#L1).
  README and the new changelog correctly no longer present it as an available mode.
- **Placement wording could identify the rotation button.**
  [README line 19](https://github.com/cocodedk/Battleship/blob/d1cdd2e3afe02865a901a51d3e05daedbc4b24ed/README.md#L19)
  and the full description say to tap again to rotate. In the sampled UI,
  repeating the placed cell did not rotate; the separate orientation button
  changed the pending orientation.
- **Some 15-medal text remains:** the
  [English heading at line 560](https://github.com/cocodedk/Battleship/blob/d1cdd2e3afe02865a901a51d3e05daedbc4b24ed/website/index.html#L560),
  and Persian page lines 7, 42, 280, 510 and 571, including the
  [visible medal introduction](https://github.com/cocodedk/Battleship/blob/d1cdd2e3afe02865a901a51d3e05daedbc4b24ed/website/fa/index.html#L280).
- The [Persian Sonar description](https://github.com/cocodedk/Battleship/blob/d1cdd2e3afe02865a901a51d3e05daedbc4b24ed/website/fa/index.html#L226)
  still describes a whole row; its English counterpart now describes clipping.
- The English web privacy paragraph now mentions the surviving backup copy.
  The corresponding [privacy.md paragraph](https://github.com/cocodedk/Battleship/blob/d1cdd2e3afe02865a901a51d3e05daedbc4b24ed/privacy.md#L15)
  and [Persian paragraph](https://github.com/cocodedk/Battleship/blob/d1cdd2e3afe02865a901a51d3e05daedbc4b24ed/website/privacy.html#L132)
  retain the earlier broad deletion wording, although both disclose backup later.
  Aligning those copies would finish that clarification.

The auxiliary `llms.txt` persistence wording is corrected. The website findings
above concern pinned source text, not independently verified deployed pages.
They do not indicate an observed backup or hidden transmission.

**Limits and cleanup:** one game on one emulator/API/locale; no weapons, victory,
area-hit recount, exhaustive awards/placement, audio/haptics, upgrade, reboot,
backup/restore, external-link or network-traffic test. Score formulas were not
independently validated. Installation to final inspection took about 6 min 40 s;
cleanup and final AVD/file verification took 47 s. These include tool/review
waiting and are not performance measurements. Uninstall, wiped reboot and
package/Downloads absence were verified; emulator and isolated ADB stopped.
The AVD, APK and raw logs/UI captures were deleted, limiting independent audit
of these observations. No APK was uploaded to a scanner.

The sampled runtime path passed, with the listing findings above still open.
Please point out any mistaken interpretation.
