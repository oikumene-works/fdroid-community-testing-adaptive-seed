# Adaptive Seed Process Audit

Date: 2026-09-20

## Scope and evidence

This audit reviews the path from the adaptive-seed idea through the first public
repository and publication-loop correction. It uses the repository history,
design and evolution records, clean-agent evaluation, publication record, and
operator decisions retained in the project context.

This is a project self-audit, not an independent assessment. Raw model traces
were intentionally not retained, no non-technical human has tested the complete
acquisition path, and all implementation evidence is recent.

## Overall finding

The process produced a credible first agent-mediated adaptive seed while
preserving the guarded starter kit and its authority boundaries. It did not yet
prove the full user goal: an unfamiliar non-technical person downloads the seed,
says `Grow this seed`, and continues without setup knowledge.

The strongest result is a small decision surface backed by conservative tests.
The main weakness is that implementation and documentation complexity remained
large and briefly began driving the publication process itself.

## Evolution of the idea

1. The starter kit solved a complete workflow for one known Linux reference
   environment.
2. The seed changed the opening question to local discovery followed by one
   smallest useful growth proposal.
3. Responsibilities were separated into invariant kernel, discovery, ignored
   local profile, and optional growth.
4. The interaction contract became one request, one proposal, one choice, one
   completion report, with a new decision at each later effect boundary.
5. The original kit remained usable and undeprecated; the seed became a separate
   public alternative with exact ancestry.
6. Publication exposed a self-referential handoff failure, which the operator
   stopped and the project recorded publicly.

## Assessment by dimension

| Dimension | Finding | Evidence and limit |
| --- | --- | --- |
| Safety and authority | Strong | Discovery, local writes, executable work, Android actions, and external mutations retain separate boundaries. |
| Scope control | Strong in features, mixed in process | Speculative platforms and providers were parked, but documentation and approval bookkeeping expanded. |
| Adaptive design | Strong first path | The four layers and truthful states are explicit; only one Linux reference lane is verified. |
| Testing | Strong refusal coverage | Growth tests cover missing tools, unsupported hosts, conflicts, no-op reuse, failure stops, and wrong guards. |
| Newcomer evidence | Partial | A fresh Codex session succeeded; no non-technical human, ZIP acquisition, Git-less continuation, or other agent was tested. |
| Minimality | Partial | The first interaction is small, but the repository has 78 tracked files and about 5,800 text lines; `seed` itself has 459 lines. |
| Public transparency | Strong | Errors, corrections, evidence limits, and the publication loop are retained rather than hidden. |
| Documentation consistency | Weakening | Repeated current-state claims drifted, and phrase-based checks did not detect semantic contradictions. |
| Long-term evidence | Unknown | The skill and public seed were created, evaluated, and published within one recent evidence window. |

## Operator assessment

The operator supplied the decisive strategic corrections:

- defined the unfamiliar-user `Grow this seed` goal;
- required the reasoning, mistakes, and learning to become public;
- challenged possible scope drift;
- rejected replacement or deprecation of the original starter kit;
- replaced the dependency-implying word `companion` with `independent
  alternative`; and
- recognized and stopped the self-feeding commit-and-approval loop.

Short approvals accelerated implementation but delegated much of the technical
shape and publication bookkeeping to Codex. The operator has not yet performed,
or arranged, a real target-user acquisition test. That is the largest remaining
gap in operator-side validation.

## Codex assessment

Codex translated the idea into a layered contract, preserved safety invariants,
implemented denial and boundary tests, evaluated a clean agent path, and kept
external mutations behind exact approvals.

Codex also made material process mistakes:

- the first seed commit combined about 1,600 added lines and several documented
  slices, weakening commit-level review of the evolution;
- implementation minimality was confused with a small first interaction;
- changing current state was duplicated across too many documents;
- a tracked handoff described its own pending push, making the approved push
  invalidate the handoff and inviting another status commit; and
- successful static checks were treated as stronger evidence than they were,
  even though semantic document contradictions remained.

## Known consistency findings

This audit intentionally does not fix the findings below:

- `docs/starter-kit-seed-comparison.md` contains both a historical statement
  that the sibling is local and unpublished and a current statement that it is
  public, without clearly marking the first as historical.
- `docs/seed-migration.md` still names review of a local post-publication record
  commit as the next decision although that record was published.
- `docs/publication-plan.md` labels the live repository URL as proposed.
- The skill source repository, `agent-skills-lab`, has no remote and currently
  contains uncommitted ASD-07 evaluation and handoff changes plus local IDE
  state. Those files were observed read-only and remain outside this project.

## Recommended next bounded decisions

Do not add another feature first. On a deliberate resume, choose one:

1. run one documentation-consistency slice that assigns changing current state
   to one owner and corrects the known contradictions; or
2. run one real newcomer acquisition test with only the public location and the
   instruction `Grow this seed`, without pre-teaching the workflow.

Do not combine these by default. The human evaluation provides more product
evidence; the consistency slice provides a cleaner test artifact.

## Pause and account-transition checkpoint

The operator requested a pause after this audit and expects a later session to
use a different ChatGPT account. Repository state, not the previous chat, is the
handoff. No identity, credential, external authority, or approval transfers from
the previous account or conversation.

On resume, run the repository bootstrap, read `AGENTS.md`,
`docs/next-session.md`, and this audit, inspect Git and remotes, and reverify the
active external account before proposing any external action. The pause itself
authorizes no audit correction, feature work, push, tag, release, announcement,
or change to the original starter kit.
