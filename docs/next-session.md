# Next Session

## Goal

Maintain an independent adaptive alternative to the guarded starter kit in
bounded slices. The target newcomer experience is to obtain the repository and say `Grow this seed`,
then receive truthful local discovery and one bounded growth proposal. The seed
must preserve the published kit's safety and authority boundaries.

## Current state

- This independent local seed project preserves exact published starter-kit
  commit `5a54da63a58b22c8715778a31931394769b60d72` in its Git ancestry.
- Local branch `main` tracks the HTTPS `origin`. The initial publication
  approval was consumed; the post-publication record remains local until a
  separate push approval.
- `docs/seed-design.md` defines the growth contract and layer boundaries.
- `docs/seed-evolution.md` records the design change, mistakes, evidence, and
  learning policy intended for eventual public review.
- `docs/seed-migration.md` maps the current kit into bounded migration slices.
- The accepted communication contract is: discover facts without questioning
  the grower, present one recommended slice with at most three choices, and ask
  again only at a new effect or authority boundary.
- Migration Slice 1 is complete. `./seed grow` performs read-only discovery,
  reports `READY`, `MISSING`, `UNSUPPORTED`, and `UNKNOWN`, proposes one next
  slice, and stops. `--apply` is deliberately refused.
- `tests/seed-grow-tests.sh` covers the current host, missing tools, an
  unsupported host, exact profile preview and creation, a rejected broad apply,
  no-op reapply, offline preview and execution, failure stop, conflict
  preservation, and invalid commands or guards.
- Migration Slice 2 is complete. Its ignored profile behavior was verified in
  the design worktree. This independent project intentionally starts without a
  profile until one is separately previewed and approved.
- A post-write regression was corrected: an exact existing profile now advances
  `./seed grow` to the Slice 3 offline-verification proposal; absent and
  conflicting profiles retain their own safe proposals.
- Migration Slice 3 is complete. `--preview-offline` shows the two commands and
  effects; `--verify-offline` requires the exact lane guard, runs repository
  checks before the fictional dry run, and stops on the first failure.
- The development-worktree offline run passed. It preserved the profile and Git
  state and performed no network, Android, credential, or external action.
- Migration Slice 4 is complete. The clean newcomer evaluation is recorded in
  `docs/seed-newcomer-evaluation.md`; its two observed confusions were corrected.
- Migration Slice 5's relationship decision is complete. The published starter
  kit remains usable and undeprecated; the seed is an independent alternative
  intended as this separate project. `docs/starter-kit-seed-comparison.md` records the
  different design premises and their observed implementation effects.
- The local sibling-project checkpoint is complete when the initial seed commit
  and final clean-worktree verification pass. No `.local` state was copied.
- Publication is recorded in `docs/publication-plan.md`. The public repository
  is `oikumene-works/fdroid-community-testing-adaptive-seed`; `main` points to
  approved commit `e371eb9ccdf298330a9c20fb51a35b85dfc765d1`.
- Android Studio's `.idea` directory is ignored local state. A publication-gate
  check caught its workstation path after a project switch; it was not tracked.
- Only growth-session guidance in `session-bootstrap.sh` changed; all
  community-testing gates and operational actions retain their behavior.
- No active candidate is selected in the distributed repository.
- No candidate APK, emulator session, isolated ADB server, or transient test
  evidence is expected to exist.
- No further push, external upload, public comment, or other service mutation
  is authorized by this handoff.

## Startup

1. Run `./scripts/session-bootstrap.sh`.
2. Read `AGENTS.md` and this file. For a grow-only session with no active case,
   run `./seed grow`, report its one proposal, and stop for a choice.
3. Before community-testing work, read `docs/session-continuity.md`,
   `docs/protocol.md`, and `docs/first-case-runbook.md` completely.
4. If `cases/active-case` names a case, read that case's `case.env`, `case.md`,
   `claims.md`, `qualification.md`, and `report.md` completely.
5. Verify the worktree and remote state before acting.

## Current gate and safest next slice

Stop at the completed initial-publication checkpoint. Any push of the local
publication record or later public mutation requires its own exact approval.

No further script implementation, candidate selection, network use, executable
download, Android action, push, branch publication, tag, release, or metadata
change is authorized by this handoff.
