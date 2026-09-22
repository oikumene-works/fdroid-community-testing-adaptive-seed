# Seed Publication Evolution Log

This is the publication-era continuation of the
[main seed evolution log](seed-evolution.md). It keeps publication mistakes,
corrections, and authority boundaries public without exceeding that log's
documentation budget.

## Local sibling creation retrospective

The approved local project was created without a remote. Three findings were
retained:

| Evidence | Impact | Smallest response | Disposition |
| --- | --- | --- | --- |
| The seed can retain the starter kit's exact Git ancestry instead of beginning with a history-free copy | Reviewers can inspect both the common base and the seed-specific change | Make the published starter-kit commit the parent of the first seed commit | Adopted now; Codex-owned |
| The design worktree contained a valid ignored machine profile | Copying it would falsely make one machine's adaptation part of the new project | Exclude `.local` completely; let the independent seed begin with discovery | Adopted now; invariant/local boundary preserved |
| The first local commit attempt inherited an email containing a private machine hostname | Publishing that metadata later would leak machine-specific identity | Replace it before any remote with the established public no-reply bot identity and require metadata review before publication | Adopted now; Codex-owned, no external mutation |

## Publication preparation retrospective

The bounded audit retained three findings:

| Evidence | Impact | Smallest response | Disposition |
| --- | --- | --- | --- |
| The seed README named the original but did not link its public source or exact derivation commit | A reviewer had to trust local prose to find the comparison base | Add public links to the original repository and immutable commit | Adopted now; Codex-owned |
| The proposed GitHub URL returned 404 anonymously | The name appeared available, but treating absence as a reservation could create a race or wrong-target publication | Recheck immediately before an approved create action and stop on any change | Adopted as a publication gate |
| Public repository metadata had not been decided | Creating first and improvising description or topics would make the external mutation under-specified | Record the proposed owner, name, visibility, description, topics, and bounded initial surface | Adopted before publication; operator approval remained required |

## Public name refinement

The operator selected `fdroid-community-testing-adaptive-seed`; `adaptive`
exposes the different premise without implying replacement. `Independent
alternative` replaced `companion` because the seed does not depend on the
original kit.

When Android Studio later created ignored `.idea` state containing a workstation
path, the publication gate caught it before commit.

## Self-referential publication loop

The initial source publication stopped at approved commit `e371eb9`. A separate
commit, `89b11aa`, then recorded the publication outcome. Its current-state
handoff also said that this record remained local until a separate push
approval. After that exact approval and push, the sentence became false because
performing the action it described invalidated its own state.

Codex responded by creating another status commit and asking for another push.
The operator recognized that this could become a self-feeding chain of status
commits and stopped it before the next push. The loop was a process-design
error, not a Git or GitHub failure.

| Evidence | Impact | Correction | Durable rule |
| --- | --- | --- | --- |
| A tracked handoff encoded its own pending push as current project state | The approved push immediately made the handoff stale and created pressure for another commit and approval | Commit `e1e18fe` replaced the pending statement with stable completed facts and a general boundary for later mutations | A tracked handoff must not describe its own pending push as current project state |
| Codex treated each newly stale status sentence as requiring another immediate public update | Documentation maintenance began to drive the workflow instead of reporting it | The operator declined the next push; no automatic follow-up publication occurred | A documentation correction never supplies its own publication authority or urgency |
| The stable replacement states completed facts without predicting whether its containing commit will be pushed | Its truth no longer changes merely because a later approved push occurs | Keep future authorization state outside self-referential tracked wording; record effects after they are complete | Stop after one stable local correction and wait for a separately chosen publication decision |

The correction prevents the mechanism that fed the loop: the handoff now says
what has completed and that any later mutation needs exact approval. It does not
claim that its own commit is waiting to be pushed. No new commit should be
created merely because this log or that stable handoff is later published.

## Battleship closeout audit — 2026-09-22

Codex conducted a bounded self-audit of report preparation, publication,
developer feedback, follow-up posting and cross-project closeout. The operator
requested this durable summary, clarified finding 1, and authorized a small
administrative simplification if justified. This is not an independent audit,
a new Android test, or enrollment in the private collaboration experiment.

### Verified outcome and limits

Read-only verification matched both published GitLab bodies and author Jyriwee
to their canonical files: original report 3881992480 and follow-up 3882155370.
The published seed HEAD matched dfd1818191b850664d95bbb4e1ac4e63b0065f8b and
the worktree was clean. The case remained inactive with only its two ignored
configuration files. Exact receipts and the failed-attempt history belong to
[the case publication record](../cases/battleship-49547/public-comment-record.md).

The developer's source review corroborates the findings, but does not verify
a new binary or establish F-Droid acceptance. Deleted raw Android evidence
cannot be re-audited. The process comparison exposed an eligibility-policy
difference; it did not demonstrate adaptive superiority.

The preceding cross-project closeout checked local Git state and tooling, not
every application's functionality or security. Four stale Visual Routines
sandbox ADB processes were stopped after identity checks; shared Studio tooling
and retained evidence were preserved. Existing AndBible, TA612C and Melkonen
changes were preserved. Visual Routines' cleanup record remains local because
its private origin returned 404 with the current account; that is not proof
of repository deletion. Its own handoff owns this unresolved access check.

### Three findings

1. **An unverified premise shaped the retrospective explanation.** The operator
   clarified that his strongly held mistaken impression of complete omission
   led Codex to accept the premise. The earliest retained MR draft at
   57853f91676ffdcc253bd13505e568ccf34597ab already named Codex as the test
   executor in its opening paragraph. Commit 5fd936f made execution, source
   review, analysis, writing and the human role more explicit. The clarification
   describes the interaction; it does not establish the model's hidden causal
   reasoning or prove what every unsaved draft contained. Codex should have
   checked the history before elaborating a plausible explanation. Owner:
   shared premise correction; Codex owns evidence checking. Disposition:
   corrected in the audit; use history before retrospective causal claims.
2. **Failure diagnostics were lost.** The first follow-up POST returned failure,
   but its diagnostic response was discarded. Its cause remains unknown;
   uncertainty and additional operator checking followed. Stopping before an
   automatic retry preserved safety. The later explicitly authorized attempt
   retained bounded failure information if needed and succeeded with independent
   readback. Owner: Codex. Disposition: retain sanitized status/diagnostics at
   the time of future consequential writes; the case record already captures
   this lesson. No new posting framework is authorized by this audit.
3. **Closeout was fragmented.** Small record updates triggered multiple check,
   commit and push cycles; broad grouped document reads also produced truncated
   output. This is observed overhead, not a measured efficiency comparison.
   Owner: Codex. Disposition: adopt the bounded consolidation rule below;
   prefer targeted reads while retaining mandatory startup evidence. Do not
   weaken publication verification to save administrative work.

### Adopted administrative change

The operator's permission for a useful simplification is implemented in
[Consolidated closeout](session-continuity.md#consolidated-closeout), with a
short repository-instruction pointer and the same general working agreement
in the operator's local instructions. Related records within one authorized
scope are prepared together, checked as a final set and normally committed
together. Unchanged-tree checks can be reused; required clean pre-action
checkpoints, live preflight, readback and ambiguous-result stops remain.

The old sentence expiring approval merely on a session change also conflicted
with the operator's standing agreement. It now preserves approval for unchanged
targets, text and effects while requiring fresh state and scope checks. It does
not authorize a different candidate, changed text or new effects.

The existing anti-recursion rule still governs publication receipts: record
actual effects, retain stable facts and avoid another push request solely to
publish a receipt. No automatic publisher, test-skipping mode or cache was added.
Invariant safety/authority rules remain portable; environment discovery and
local profiles are unchanged. Future capabilities still need an observed need.

Validation for this slice is the existing offline suite after the combined
documentation edits, plus a consistency review of these examples: a local
documentation batch needs one final check/commit; a public posting still needs
its clean pre-action checkpoint and post-action receipt; an ambiguous write
still stops before retry. This validates instruction consistency, not measured
time savings or general agent compliance. Stop after the checked local record;
no publication, runtime test or research experiment is part of this slice.
