# Next Session

## Goal

Initialize or resume a guarded community-testing workspace without treating
environment readiness as authorization to download or execute a candidate.

## Current state

- This is the clean starter-kit handoff.
- No active candidate is selected in the distributed repository.
- No candidate APK, emulator session, isolated ADB server, or transient test
  evidence is expected to exist.
- No external upload, public comment, or other service mutation is authorized
  by this handoff.

If this file is later changed for a real case, replace these initial facts with
the exact current gate, pinned identifiers, cleanup state, external mutations,
and pending approvals. Do not append an unbounded session diary.

## Startup

1. Run `./scripts/session-bootstrap.sh`.
2. Read `AGENTS.md`, this file, `docs/session-continuity.md`, and
   `docs/protocol.md` completely. New operators should then follow
   `docs/first-case-runbook.md`.
3. If `cases/active-case` names a case, read that case's `case.env`, `case.md`,
   `claims.md`, `qualification.md`, and `report.md` completely.
4. Verify the worktree and remote state before acting.

## Safest next slice

Run the read-only environment doctor, explicitly initialize ignored local state,
then run the offline checks and fictional dry run. Creating an AVD is a separate
operator decision. Candidate selection, executable download, Android tooling,
external upload, and public posting retain their own gates.
