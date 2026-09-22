# Test Eligibility and Product Findings

A test candidate need not be defect-free. It must be identifiable and safe to
inspect or test within the declared lane, synthetic inputs, effect boundaries
and cleanup plan. Product defects are useful test results, not automatic reasons
to prohibit collecting more evidence.

## Two decisions in one digest-bound review

Keep both decisions in case.env and as exactly one unindented line each in
claims.md. The file digest binds the decisions, findings and bounded test scope.
An env-only status change, missing decision, duplicate marker or stale digest
must fail. Technical guards never grant operator approval.

| Field | Value | Meaning |
| --- | --- | --- |
| TEST_SAFETY_STATUS | NOT_REVIEWED | Default, missing assessment; no executable action. |
| TEST_SAFETY_STATUS | BLOCKED | A safety, identity, authority or containment concern is unresolved. |
| TEST_SAFETY_STATUS | PASS | The written scope is eligible for the next separately approved gate. This is not a general security or runtime safety guarantee. |
| CLAIM_REVIEW_STATUS | CLARIFICATION_REQUIRED | Findings have not been classified sufficiently to decide safe scope. No executable action. |
| CLAIM_REVIEW_STATUS | PASS | Reviewed claims have no identified material discrepancy within the stated evidence limits. |
| CLAIM_REVIEW_STATUS | FINDINGS_RECORDED | Product/documentation discrepancies remain, with evidence, impact, limits and a safe test scope recorded. This does not declare the claims true. |

Only TEST_SAFETY_STATUS=PASS together with PASS or FINDINGS_RECORDED for the
claim review can reach qualification. Activation/execution still require exact
binary qualification, a clean committed checkpoint and the existing separate
operator decisions. Every executable entry point uses the same review gate.

## Classify by consequence

- Stop for uncertain APK/source identity, changed pins, unexpected executable
  provenance, unsupported network/sensitive permissions, private-data exposure,
  destructive or unexplained writes, insufficient isolation/cleanup, or missing
  authority. If a claim discrepancy could conceal such behavior and the evidence
  cannot resolve it, safety remains BLOCKED or NOT_REVIEWED.
- A missing game mode, broken safe UI path, stale count or inaccurate gesture
  description may be a product finding. Record how it affects the checklist;
  do not silently omit the advertised function or turn absence into a pass.
- Privacy wording is assessed by the actual data path and proposed environment.
  An explicitly disclosed OS backup exception may need clearer wording without
  forbidding a synthetic offline test. Unexplained transmission, sensitive data
  or an unknown backup/account route still blocks the affected scope.
- When classification is uncertain, stop for evidence. Do not solve uncertainty
  by labeling it documentation, by dropping a finding, or by broadening the lane.

The review must state synthetic inputs, included/excluded actions, safe handling
of every finding, stop conditions and what remains unknown until qualification
or runtime. For example, a source-only missing-feature finding remains a
source-only finding; runtime is Not tested until actually exercised.

## Qualification and reporting

Built identity, signer, permissions, components, native code and manifest
surfaces remain unknown before qualification. A source safety PASS permits
only the separately approved download-inspect-delete step, not installation.
Reconcile new APK evidence before qualification PASS; revisit the safety/claim
review and both digests if evidence changes the scope or classification.
A known product finding cannot excuse an unexpected permission or identity.

Reports must retain the source-only findings and distinguish them from runtime
observations. Report partial coverage and excluded actions. A passing test of
one function never resolves a different missing function or an inaccurate claim.
External communication remains separately authorized, accurately scoped and
courteous; report specific evidence and possible correction, not a verdict on
an author or F-Droid acceptance.

## Existing case migration

Old cases are not grandfathered into safety PASS. A missing TEST_SAFETY_STATUS
or missing digest-bound markers fails closed, including an old claim PASS.
Inactive historical checkpoints remain readable and valid as inactive records.
Reassess their exact evidence under this policy, preserve the previous decision
as history, document the new classification/scope and refresh the review digest.
Then perform a fresh live recheck before any later action. A policy-only
reclassification may retain unchanged source pins; it must not pretend that
upstream corrected a finding or that an APK was qualified. Existing authorizations
do not expand because the policy changes.

## Origin and bounded verification

This change follows two source-preflight stops. Battleship's absent advertised
mode demonstrated that a useful product finding could prevent safe testing of
other functions. The operator explicitly authorized this separation on
2026-09-22. The invariant kernel retains identity, isolation and authority checks;
case classification is discovered evidence, environment choices stay local, and
no provider, runtime or network lane is added.

Stop condition: the shared gate, active-record validation, templates, fictional
example and real inactive-case migration agree, offline regression tests pass,
and all real APK/Android gates remain unexecuted. Regression coverage includes
safe findings reaching mocked qualification, unsafe/unknown states denied,
decision/digest tampering denied and approval/qualification guards retained.
This is local gate evidence, not proof of unfamiliar-user comprehension or
real Android behavior.
