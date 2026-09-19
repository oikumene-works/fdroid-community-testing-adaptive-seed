# Report Policy

A report must identify its evidence class in the title and first paragraph:
functional test, pre-installation review stop, source-only review, or another
accurate bounded category.

Every report should include:

- independent, non-F-Droid status;
- exact candidate identifiers and digests;
- executor and human involvement;
- completed checks and explicit untested surfaces;
- claim-review status and any material contradiction;
- observations separated from inference;
- a sanitized timeline and phase durations;
- cleanup and upload state; and
- external mutations, or an explicit statement that none occurred.

Do not call a pre-installation stop a failed or completed functional test. Do
not generalize a bounded pass into security, privacy, accessibility, usability,
policy compliance, or publication acceptance.

Before publication, audit names, paths, identities, links, licenses, secrets,
and third-party material. Review the exact file digest and destination. A
moving branch link is insufficient for a later report-link comment; use an
immutable commit or release permalink.
