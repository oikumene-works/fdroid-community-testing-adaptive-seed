# Source-only correction check — Battleship 1.0.13

Codex performed this bounded check on 2026-09-22 under the operator's instruction
to inspect the reported corrections and assess whether another runtime test is
useful. This is not APK qualification, an Android rerun or F-Droid acceptance.
The 1.0.12 case pins, runtime report and posted comment remain historical and
unchanged; this file does not migrate that case to a new binary.

## Developer response and exact state

- Developer @cocodedk, MR note 3882563252, 2026-09-22T07:16:56.188Z:
  https://gitlab.com/fdroid/fdroiddata/-/merge_requests/49547#note_3882563252
- Response body SHA-256, UTF-8 without an added newline:
  05e2b8f3a8aa2d1568dd40b4a30054f69ea7b5e86e03cab6696dbea207bedf60.
- Latest reviewed MR head: d8997c7afe0daf2060dc0ee1f53b4f085eeb5ce1;
  pipeline 2870242783, success at that head; MR open.
- Exact MR recipe selects version 1.0.13 / 1000013 and source
  35e98a6744eb32d9934278925f374dad61abf24e.
- Lightweight tag v1.0.13 and release target both match that source;
  release ID 393515496, not draft/prerelease. Provider state checked around
  07:57 UTC; this does not attest future state or binary behavior.

The developer acknowledges all five findings, reports a wider self-audit and
asks explicitly for links to both workflows to help test other submissions.
His wider audit and native-library explanation are attributed statements;
our bounded check below does not independently validate every additional claim.
No workflow evaluation or research participation was requested or agreed.

## Five requested corrections

Paths/lines refer to source 35e98a6744eb32d9934278925f374dad61abf24e.

| Previous finding | New pinned-source observation | Result within this scope |
| --- | --- | --- |
| Pass-and-play in store texts | short_description.txt:1 now describes AI play; full_description.txt:1 removes the friend/two-player clause. | Addressed in both strings. |
| Ambiguous rotation wording | README.md:19 and full_description.txt:3 explicitly identify a separate orientation button. The full description also specifies random auto-deployment. | Addressed; consistent with unchanged code and the 1.0.12 sampled control behavior. |
| Remaining 15-medal texts | English website/index.html:554 says 33. Persian website/fa/index.html:7,42,274,504,565 says 33 at the corresponding five locations. | Reported locations addressed. |
| Persian whole-row Sonar | website/fa/index.html:226 now describes five horizontal cells centered on the target and clipped at the edge. | Reported wording addressed; no new weapon runtime result. |
| Backup-copy wording | privacy.md:18 and website/privacy.html:134 now add the possible surviving Android/Google backup copy alongside the existing disclosure. | Requested clarification present; not an assessment of actual backup behavior or every privacy statement. |

All five requested source-description corrections are present. This is a scoped
closure of those findings at this source revision, not a claim that every
statement on every surface is correct. The deployed website and social-preview
PNG were not independently inspected; no image or APK was downloaded. Historical
design documents were not treated as current product descriptions. The additional
corrections from the developer's broader audit were visible in the diff but were
not expanded into another comprehensive source-to-feature audit.

## Delta and runtime decision

The v1.0.12 to v1.0.13 comparison contains two commits and eleven changed paths:
README.md; fastlane/metadata/android/en-US/changelogs/1000013.txt;
fastlane/metadata/android/en-US/full_description.txt;
fastlane/metadata/android/en-US/short_description.txt; gradle.properties;
privacy.md; website/fa/index.html; website/index.html; website/og-source.svg;
website/og.png; website/privacy.html.

The app directory tree is identical at both revisions:
50180cc03fcc2965e688bd49e9c62645dc709e54. This includes app source, resources,
manifest and app/build.gradle.kts. Root build/settings files, dependency/Gradle
directory and .github workflow tree also have identical Git object identifiers.
gradle.properties changes only VERSION_NAME and VERSION_CODE. No third-party
code, build, test or script was executed.

Recommendation: no additional full Android game is warranted for these changes.
The known issues are description corrections and their appropriate verification
is the exact source review above. Previous binary/runtime evidence remains
specific to 1.0.12; green CI and source equality do not constitute our qualification
or execution of the new APK. Revisit runtime only for a meaningful code/build/
dependency change, a runtime regression report or an explicit new binary check.
No new APK qualification, Android action or publication is authorized by this note.

## Evidence digests

SHA-256 of exact source file bytes:

| Path | SHA-256 |
| --- | --- |
| fastlane/metadata/android/en-US/short_description.txt | 4e246e2ecc7fc43bb17394dd36d27783a915fc7dd3e5aec3a115a3b4971339c4 |
| fastlane/metadata/android/en-US/full_description.txt | 2f04d712aab22b5de3cb672bdacf6f9949fca894ab83b84d787920e31ad46e4e |
| README.md | c693166852c374c39bfbf1742831f3cf9345d629bd9630b94134a2fffadf908a |
| website/index.html | ad528b160cd966079b60019a7c67b105b600ac17d4d8fe99be182bc0f4e74561 |
| website/fa/index.html | b627c3c3ec01a4cb26258063324542480c51f96d4d8332f016403ec32d098b13 |
| privacy.md | b56d44e7ca0c61666aa93cc54324456017f0330d3941e647c6fed9d7eec6360c |
| website/privacy.html | d02ff00f74ef1c289f8a2e2adfaf2cfee655b036b1c9337a85ed2287736fd129 |

No raw source/API payload, APK, new AVD or runtime artifact was retained. The
result is based on read-only public API/source access. No external mutation.
