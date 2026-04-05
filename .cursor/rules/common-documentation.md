---
description: "Documentation standards: README, code comments, API docs, changelog"
alwaysApply: true
---
# Documentation Standards

## Code Comments — Less is More

**DO comment:**
- Non-obvious business logic ("// Retry 3x because payment gateway rate-limits at 10 req/s")
- Why, not what ("// Using LRU instead of LFU — cache is read-heavy, 95th percentile < 5ms")
- Public API contracts (function purpose, params, return, errors)
- TODOs with context: `// TODO(username): migrate to v3 API after 2026-06 deprecation`
- Workarounds: `// HACK: upstream bug #1234 — remove after their fix`

**DO NOT comment:**
- What the code literally does (`// increment counter` on `counter++`)
- Closing braces (`// end if`, `// end function`)
- Change narration (`// added error handling`)
- Commented-out code — delete it, git has history

## README Structure

Every project README must contain:

```markdown
# Project Name
One-sentence description of what it does and who it's for.

## Quick Start
Step-by-step to get running locally (≤ 5 steps).

## Architecture
High-level diagram or description of how components connect.

## Development
- Prerequisites, environment setup
- How to run, test, lint, build

## Deployment
How to deploy (or link to deployment docs).

## Contributing
Branch strategy, PR process, code style expectations.
```

## API Documentation

- Every public function/method: purpose, params, return type, possible errors
- Use language-native doc tools: JSDoc, GoDoc, docstrings, KDoc
- Include at least one usage example for complex APIs
- Document error responses and edge cases

## CHANGELOG

Follow [Keep a Changelog](https://keepachangelog.com/) format:

```markdown
## [1.2.0] - 2026-04-05
### Added
- User avatar upload with image optimization
### Fixed
- Session timeout not resetting on activity
### Changed
- Password minimum length increased from 8 to 12
```

Categories: Added, Changed, Deprecated, Removed, Fixed, Security.

## Decision Records

For significant technical decisions, create `docs/adr/NNN-title.md`:
- Context: What situation prompted this decision?
- Decision: What was decided?
- Alternatives: What else was considered and why rejected?
- Consequences: What trade-offs does this introduce?
