# Report Policy

A report must identify its evidence class in the title and first paragraph:
functional test, pre-installation review stop, source-only review, or another
accurate bounded category.

Every report should include:

- independent, non-F-Droid status;
- exact candidate identifiers and digests;
- executor and human involvement;
- completed checks and explicit untested surfaces;
- separate test-safety and claim-review statuses and all known product findings;
- observations separated from inference;
- a sanitized timeline and phase durations;
- cleanup and upload state; and
- external mutations, or an explicit statement that none occurred.

Do not call a pre-installation stop a failed or completed functional test. Do
not generalize a bounded pass into security, privacy, accessibility, usability,
policy compliance, or publication acceptance.

Preserve unresolved product findings when a safe function passes. Explain
excluded coverage and source-only evidence without presenting the candidate or
author as generally rejected. Public findings should identify the version,
contrast evidence with the claim, suggest a small correction and invite correction.

Before publication, audit names, paths, identities, links, licenses, secrets,
and third-party material. Review the exact file digest and destination. A
moving branch link is insufficient for a later report-link comment; use an
immutable commit or release permalink.
