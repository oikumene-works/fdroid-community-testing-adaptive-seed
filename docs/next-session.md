# Next Session

## Objective and current gate

Battleship !49547 reached a clean inactive APK-qualification checkpoint on
2026-09-22. The user authorized the exact download-inspect-delete after a fresh
recheck, and explicitly excluded Android start, installation and publication during
qualification. The operator subsequently authorized repository publication;
the sanitized results were published and verified on the same date.
Qualification is complete: APK_QUALIFICATION_STATUS=PASS after manual
reconciliation. TEST_SAFETY_STATUS=PASS and CLAIM_REVIEW_STATUS=FINDINGS_RECORDED
remain bound to the updated claims.md digest. This is static qualification,
not a functional test or a general security verdict. cases/active-case is absent.

## Exact candidate and completed work

- Seed acquired at cb4ab8bd35952acb204c0920086d14a379996066.
- Local test-eligibility separation was incorporated at 29be040; original
  source rejection at 641156a remains historical evidence under the former policy.
- App: Battleship 1.0.11 (1000011), com.cocode.battleship, fdroiddata !49547.
- MR head f2577e78cab813fde78b11d16b7c7b05dd88ea69; pipeline 2867295579;
  build job 16624306623. Fresh stock live rechecks passed before download.
- Upstream v1.0.11/source 35189f727db1cc80bdc55e9996bdcaa443914571.
- Downloaded APK digest 27c558552dc9cbd00fbb34c619aab72dbc21bd870d68a48f4cc4bc9f7b32a0d9.
- Binary package/version, minimum SDK 24, target SDK 36, pinned signing
  certificate and ZIP alignment passed. All built-surface fields are now pinned.
- Built requests: VIBRATE plus app-scoped signature receiver permission;
  no INTERNET or dangerous requested permission observed.
- Non-exported AndroidX startup provider and DUMP-guarded profile receiver were
  reconciled; native ABIs include x86_64. See qualification.md for exact facts,
  official interpretation sources and limits. No independent rebuild/native audit.
- Two-player/drag, backup wording and stale-description findings remain open
  source-only findings. Every runtime checklist item remains Not tested.

## External and local state

No external mutation occurred during qualification. The later authorized
repository publication reached results commit
`ba990f713d57d01049d1deb2d9239040b4f699e2`; see docs/publication-plan.md for
verification and the mapping from original local to public commit identifiers.
The separate historical source-only issue remains:
<https://github.com/cocodedk/Battleship/issues/55>, account oikumene-admin.
Its canonical text and receipt remain in the case. No F-Droid comment, APK/raw
evidence upload, release or additional issue action occurred. No authority for
further publication follows from this completed repository update.

The APK and raw case journal were deleted. No case source/API/build trace,
fixture, AVD, emulator or isolated ADB session is retained. Existing unrelated
host ADB processes were not targeted; reference case ports were unbound.
The ignored seed profile remains mode 600. Minimal local growth added only
.local/config/android.env (mode 600), selecting ANDROID_BUILD_TOOLS_VERSION=36.0.0.
It intentionally lacks runtime/AVD settings and must not be treated as execution
readiness. No tool, SDK package, provider adapter or portable code was added.

Actual aapt, apksigner and zipalign calls succeeded inside the stock Bubblewrap
boundary. This is real parser-operation evidence, not an adversarial sandbox audit.
Offline regressions and fictional dry run passed; those prove local guards with
mocks, not Android behavior. The bounded retrospective found no material process
change to implement.

## Resume and stop

Stop here. Recommend a new session if the operator later chooses functional
execution through verified cleanup. That needs a separately scoped decision;
neither qualification nor results publication grants activation, Android or
further publication authority.

Resume with ./scripts/session-bootstrap.sh, then AGENTS.md, this handoff,
docs/session-continuity.md, docs/protocol.md, docs/first-case-runbook.md,
docs/test-eligibility.md and the complete cases/battleship-49547 records.
Recheck Git/local state and live candidate pins; infer no identity, credential
access, authority or approval from earlier sessions or configured clients.
Discover and prepare only the local Android prerequisites actually needed by the approved next slice.
Preserve synthetic inputs, no account/cloud image, no external links, no backup/
restore and no profile/benchmark broadcast actions. Keep source-only product
findings separate from later runtime evidence.
