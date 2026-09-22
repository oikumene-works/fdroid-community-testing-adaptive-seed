# Session Continuity and Work Slicing

## Purpose

The repository is the durable source of workflow state. A conversation is a
replaceable work session and must not be the only place where a gate decision,
approval boundary, exact identifier, cleanup fact, or pending action exists.

This procedure may be adapted, but adaptations must not weaken exact-state
pinning, approval boundaries, device targeting, evidence hygiene, or cleanup.

## Gate-aligned slices

Prefer independently resumable slices:

1. candidate selection and suitability research;
2. exact source and public-claim preflight;
3. separately approved APK qualification and deletion;
4. approved execution through verified cleanup;
5. report preparation and human review;
6. separately approved public posting; and
7. any later repository publication or report-link note.

Do not infer approval for a different candidate or additional effects from an
earlier slice. An explicit approval remains valid for its unchanged targets,
text and effects; a new session alone does not expire it. Recheck actual state
and its recorded scope before proceeding. Keep APK qualification as a
download-inspect-delete slice and functional execution through verified cleanup
as one atomic slice whenever possible.

Before an executable action, confirm that enough uninterrupted operator time
and context remain to finish the authorized slice and cleanup. Otherwise stop
before downloading the candidate or starting Android tooling.

## Session transition decision

After every completed slice, explicitly recommend one transition:

- continue in the current chat when the next slice is short and context is
  clearly sufficient;
- compact the current chat when the same phase benefits from recent detail; or
- start a new chat from the repository checkpoint.

Default to a new chat before execution through cleanup, public posting, work
expected to exceed 30 minutes, or whenever remaining context is uncertain. If
recommending a new chat, finish the checkpoint before requesting approval for
the next slice.

## Bounded post-slice retrospective

After verified cleanup or another safe completed-slice checkpoint, spend no
more than 10 minutes reviewing the process. Never interrupt execution or
cleanup to conduct the review. Cover these four surfaces without assigning
personal blame:

- the test environment and tools;
- Codex's execution, reasoning, and communication;
- the operator experience, including approval and handoff ergonomics; and
- joint coordination between Codex and the operator.

Retain at most three actionable findings. For each, record the evidence,
impact, smallest useful improvement, owner (`Codex`, `operator`, or `shared`),
any approval or maintenance boundary, and one disposition: adopt now, timebox,
park, or no change. `No actionable change` is a valid result.

The retrospective grants analysis and proposal authority only. It does not
broaden an earlier approval. Any material process or tooling change needs its
own bounded scope, tests, operator decision, and safe stop condition.

## Checkpoint contract

At a planned session boundary:

- update only the active case records and handoff files whose owned truth
  changed;
- distinguish completed, approved, pending, blocked, and not-started work;
- record the current gate and the next action that still needs approval;
- record whether an APK, emulator, isolated ADB server, or transient evidence
  exists without retaining a temporary device serial;
- record every external mutation, or state that none occurred;
- update `docs/next-session.md` so a fresh session can resume without chat
  history;
- run `./scripts/check-all.sh` before committing durable facts; and
- leave a clean worktree whenever the slice is complete.

An inactive case with unresolved template fields is a valid selection or
source-preflight checkpoint when `check-all.sh` labels it pending. It must not
be named by `cases/active-case`. Qualification, execution download, emulator
start, and posting require a committed clean HEAD; a configured clone remote is
reported but grants no external authority.

Do not update durable files merely to log a routine read-only check when no
owned truth changed. Never commit an APK, raw log, screenshot, UI dump, packet
capture, credential, signed transient URL, workstation path, or temporary
device identifier.

## Consolidated closeout

Within one authorized scope, prepare related evidence, receipt and handoff
updates together, then run the required checks on the final change set and
prefer one coherent commit. Do not create a separate commit and full check
cycle for each paragraph or file. Preserve clean committed checkpoints required
before qualification, execution or posting; do not batch across an unresolved
safety, approval or recovery boundary.

A passing check applies to the unchanged tree and relevant environment it
examined. Commit creation or pushing that exact tree alone does not invalidate
it. Changed files, failed checks or changed inputs require the applicable
checks again. This rule does not replace live preflight or external readback.

Record an external effect only after it is verified. If the resulting receipt
needs a later commit, keep that completed-effect record stable. Publish it
within existing authority when that includes the receipt, or retain it for the
next selected publication. Do not request or initiate an extra push solely
because the receipt exists, and do not recursively record receipt-only pushes.
No new automation or verification cache is required.

## Next-session handoff

`docs/next-session.md` is the current repository handoff. Keep it concise and
self-contained. It should identify:

- the current objective and active case, if any;
- exact pinned state needed to understand the current gate;
- completed work and cleanup state;
- pending approvals and prohibited next actions;
- local executable or Android state that may still exist;
- external mutations already made; and
- the single safest next slice.

This handoff owns changing project-wide current state and the current gate.
Dated audits, plans, comparisons, and evolution records own their historical
facts and must label superseded state as historical instead of duplicating a
second current handoff. Active case records continue to own case-specific
pins, approvals, evidence, and cleanup state.

The bootstrap prints this handoff, but printing is not a substitute for reading
the complete active case configuration, case narrative, claim review,
qualification, report, and protocol.

## Documentation size budgets

Keep frequently loaded guidance within these physical line limits:

- `AGENTS.md`: 80 lines;
- `README.md`: 120 lines;
- `docs/next-session.md`: 160 lines;
- every other Markdown file directly or indirectly under `docs/`: 220 lines;
  and
- each Markdown file under `templates/`: 140 lines.

`scripts/check-all.sh` enforces the limits. If a document approaches its budget,
deduplicate it or split stable details into a clearly linked document. Never
meet a limit by removing a safety boundary, approval state, exact identifier,
cleanup fact, or material result. Case evidence and completed reports have no
hard line cap because precise disclosure takes priority.

## Interrupted work

After an unexpected interruption, do not assume local or external state. Run
the bootstrap, read the handoff and complete active case, inspect local state
without mutation, and re-establish the exact emulator target before authorized
recovery or cleanup. Do not resume functional testing solely because an earlier
session had approval.
