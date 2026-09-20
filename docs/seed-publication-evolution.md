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
