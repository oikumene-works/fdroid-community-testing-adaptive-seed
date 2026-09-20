# Clean Newcomer Evaluation

## Question and method

On 2026-09-20, a fresh repository copy was created without `.git`, `.local`, a
remote, or prior conversation state, then initialized as a clean local Git
repository. A fresh ephemeral Codex session used `gpt-6-astra`, ignored personal
configuration, and had read-only filesystem access.

The complete task prompt was:

> Grow this seed

The evaluator received the repository instructions automatically. It received
no earlier chat, profile, private evidence, candidate, or additional task
guidance. Model-provider access was required to run the evaluator; repository
commands themselves used no project network or Android action.

## Observed path

The evaluator:

1. ran `scripts/session-bootstrap.sh`;
2. followed the then-current startup instruction and read the general operating
   documents;
3. ran `./seed grow`;
4. summarized discovery and recommended the read-only profile preview; and
5. stopped for the user's choice without creating `.local` or changing Git.

Discovery reported eight `READY`, one `MISSING`, one `UNSUPPORTED`, and two
`UNKNOWN` findings. `/dev/kvm` was absent inside the evaluation sandbox. Android
package compatibility remained unknown, and the network-capable app lane
remained unsupported. These were facts about the evaluation environment, not
claims about every installation.

The final response said that no files changed, summarized the four truth-state
classes, recommended profile preview, and offered exactly three choices:
preview, request details, or stop. It correctly refused to infer authority to
write the profile.

## Confusions and corrections

The evaluator explicitly noticed that the tracked handoff described an existing
ignored profile even though a clean copy correctly contained none. The handoff
now distinguishes development-worktree history from clean-copy state.

The evaluator also loaded about 440 lines of community-testing procedure before
the local discovery. The run remained correct, but used 18,475 model tokens.
Startup guidance now permits a grow-only session with no active case to read the
short handoff, run discovery, and stop. Full operational documents remain
mandatory before community-testing work.

## Correction recheck

A second fresh copy and ephemeral read-only session received the same exact
prompt. It read only `AGENTS.md` and the handoff before running `./seed grow`;
it did not load the operational protocol. It reported the same truthful local
states, made no change, proposed profile preview, and stopped with the same
three choices. It no longer reported a profile contradiction. Model use fell
from 18,475 to 7,328 tokens, about a 60 percent reduction. This verifies the
specific correction, not general usability.

## Evaluation limits

- This was one agent evaluation, not a human usability study.
- It tested one Linux-based read-only sandbox and does not prove macOS, Windows,
  WSL, container, or general Linux portability.
- Read-only mode proved the first stop boundary, not profile creation or later
  execution in the clean copy.
- The raw model trace was not added to source because it repeated hundreds of
  repository lines and contained a machine-specific temporary path. The exact
  prompt, command sequence, result, token count, corrections, and known limits
  are retained here.
