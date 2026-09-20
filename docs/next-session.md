# Next Session

## Goal

Maintain an independent adaptive alternative to the guarded starter kit in
bounded steps. The target newcomer experience is to obtain the repository and say `Grow this seed`,
then receive truthful local discovery and one bounded growth proposal. The seed
must preserve the published kit's safety and authority boundaries.

## Current state

- This independent local seed project preserves exact published starter-kit
  commit `5a54da63a58b22c8715778a31931394769b60d72` in its Git ancestry.
- Local branch `main` tracks the HTTPS `origin`. The initial publication and
  the separately approved publication-record push are complete.
- `docs/seed-design.md` defines the growth contract and layer boundaries.
- `docs/seed-evolution.md` records the design change, mistakes, evidence, and
  learning policy intended for eventual public review.
- `docs/process-audit-2026-09-20.md` audits the path from the seed idea through
  publication, including operator actions, Codex actions, remaining evidence
  gaps, and known documentation drift. Its three in-project consistency
  findings are now corrected; its evidence limits remain.
- This file owns changing project-wide current state and the current gate.
  Dated plans, audits, comparisons, and evolution records own historical facts.
- `docs/seed-migration.md` maps the current kit into bounded migration slices.
- The accepted communication contract is: discover facts without questioning
  the grower, present one recommended step with at most three choices, and ask
  again only at a new effect or authority boundary.
- Migration Slice 1 is complete. `./seed grow` performs read-only discovery,
  reports `READY`, `MISSING`, `UNSUPPORTED`, and `UNKNOWN`, proposes one next
  step, and stops. `--apply` is deliberately refused.
- Newcomer-facing growth output uses `PROPOSED_STEP` and declarative
  `DONE_WHEN` wording. Internal historical migration headings may still use
  `Slice`. The current `CHOICE` remains a mandatory conversation stop.
- A clean fixed-model recheck of commit `a4196bd` received only
  `Grow this seed`, described the result as a proposed step, and stopped before
  preview. It made no local change. This verifies the revised wording in one
  agent environment, not general or human comprehension.
- `tests/seed-grow-tests.sh` covers the exact Git root, a nested copy, a real
  Git-less copy, missing Git, profile-guard refusal, supported and unsupported
  hosts, profile adaptation, offline verification, failure stops, conflicts,
  and invalid commands or guards.
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
- A later public-acquisition agent proxy cloned exact public commit
  `b0beec08c32ef321b2917d4fcbcacfc4e6de363b`, ran the expected discovery, and
  then violated the first interaction stop by previewing the proposed profile
  before the user's choice. The preview was read-only, the clone stayed clean,
  and no `.local` state was created. Treat this as a partial failure, not human
  usability evidence.
- Fixed-model baselines, a live decision-record intervention, and same-session
  debriefs are recorded in `docs/seed-newcomer-evaluation.md`. They found a
  wording ambiguity but did not establish that live logging improves behavior.
  `docs/agent-evaluation-method.md` now separates direct behavior, reactive
  action ledgers, retrospective self-report, independent reruns, and human tests.
- A technical public-ZIP evaluation downloaded and validated exact public
  commit `b0beec0`, then ran bootstrap and discovery without `.git`. Acquisition
  and read-only safety passed, but the profile path requires a verified Git
  worktree and the generic host-foundation proposal gives no specific newcomer
  route to one. Codex CLI also required `--skip-git-repo-check` before the agent
  could start in the extracted directory. The agent stopped correctly but did
  not surface the Git uncertainty in its final response.
- Local `main` now treats its own Git worktree root as an invariant for profile
  growth. Git-less and nested copies receive one explicit cloned-copy proposal;
  even an exact profile guard is refused without that root. The seed never
  initializes Git, clones files, or replaces the copy automatically.
- A fresh `gpt-5.6-sol` recheck of exact commit `298c763` in a Git-less archive
  named the Git prerequisite, offered cloning instructions or stop, and stopped.
  The complete tree and file digests were unchanged; no debrief was needed.
- No unfamiliar non-technical person has run the acquisition or comprehension
  test. The ZIP result is a technical agent proxy, not human usability evidence.
- Migration Slice 5's relationship decision is complete. The published starter
  kit remains usable and undeprecated; the seed is an independent alternative
  intended as this separate project. `docs/starter-kit-seed-comparison.md` records the
  different design premises and their observed implementation effects.
- The local sibling-project checkpoint is complete when the initial seed commit
  and final clean-worktree verification pass. No `.local` state was copied.
- Publication is recorded in `docs/publication-plan.md`. The public repository
  is `oikumene-works/fdroid-community-testing-adaptive-seed`; its public `main`
  contains the reviewed publication record.
- Android Studio's `.idea` directory is ignored local state. A publication-gate
  check caught its workstation path after a project switch; it was not tracked.
- The correction changes seed discovery and proposal wording only; all
  community-testing gates and operational actions retain their behavior.
- No active candidate is selected in the distributed repository.
- No candidate APK, emulator session, isolated ADB server, or transient test
  evidence is expected to exist.
- No further push, external upload, public comment, or other service mutation
  is authorized by this handoff.
- The operator authorizes further bounded agent evaluations when they answer a
  named question and their marginal value is material. This grants no candidate
  action, credential use, publication, or other external mutation.
- The prior pause has ended. Continue to treat repository state as the handoff
  and infer no identity, authority, credential access, or approval from the
  earlier chat or account. The proxy used only its separately approved
  anonymous public read.

## Startup

1. Run `./scripts/session-bootstrap.sh`.
2. Read `AGENTS.md`, this file, and `docs/process-audit-2026-09-20.md`. For a
   grow-only session with no active case, run `./seed grow`, report its one
   proposal, and stop for a choice.
3. Inspect Git status, HEAD, remotes, and any local changes before acting. If an
   external action is later proposed, reverify and present the active external
   account; do not infer it from the previous ChatGPT account.
4. Before community-testing work, read `docs/session-continuity.md`,
   `docs/protocol.md`, and `docs/first-case-runbook.md` completely.
5. If `cases/active-case` names a case, read that case's `case.env`, `case.md`,
   `claims.md`, `qualification.md`, and `report.md` completely.

## Current gate and safest next step

Pause at the completed Git-acquisition correction, clean fixed-model recheck,
and repository evaluation-method checkpoint. No further identical agent run has
material marginal value. A real human test remains parked until a suitable
participant exists. The next separate decision is whether to review the local
commit series for publication; any push or other public mutation requires its
own exact approval and a freshly verified external identity.

No further seed feature implementation, candidate selection, executable
download, Android action, push, branch publication, tag, release, or metadata
change is authorized by this handoff. A bounded agent evaluation may use its
model provider and anonymous public repository reads only as needed for its
named question.
