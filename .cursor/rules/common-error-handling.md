---
description: "Error handling: structured errors, logging, user feedback, recovery patterns"
alwaysApply: true
---
# Error Handling Standards

## Error Classification

| Category | Example | User Impact | Action |
|----------|---------|-------------|--------|
| **Validation** | Invalid email format | Show inline error | Block submission, guide correction |
| **Business** | Insufficient balance | Show clear message | Explain what to do ("Top up your balance") |
| **Auth** | Token expired | Redirect to login | Clear session, re-authenticate |
| **Infrastructure** | DB connection lost | Show generic error | Retry with backoff, alert ops |
| **Programming** | Null reference | Show generic error | Log full stack, fix in code |

## Error Structure

Errors should carry:
- **Code**: machine-readable identifier (`VALIDATION_ERROR`, `NOT_FOUND`)
- **Message**: human-readable description
- **Context**: relevant data for debugging (user ID, request ID, input that caused it)
- **Source**: where the error originated (service, function)

## Handling Rules

- **Catch at boundaries**: HTTP handlers, message consumers, CLI entry points
- **Wrap, don't swallow**: add context when re-throwing (`"failed to create user: " + err`)
- **Never ignore errors**: no empty `catch {}` blocks. At minimum, log the error
- **Fail fast**: validate inputs at the entry point, before any side effects
- **Return, don't panic**: use error returns over exceptions for expected failures
- **Idempotent retries**: operations that may be retried must be safe to repeat

## Logging Standards

- **ERROR**: Something broke and needs attention (failed payment, data corruption)
- **WARN**: Unexpected but handled (retried successfully, deprecated API used)
- **INFO**: Significant business events (user registered, order placed)
- **DEBUG**: Developer diagnostics (query params, cache hit/miss) — off in production

Every log entry should include: timestamp, level, message, request ID, relevant IDs.

**Never log**: passwords, tokens, credit card numbers, PII in plain text.

## User-Facing Errors

- Use plain language, not technical jargon ("Something went wrong" not "500 Internal Server Error")
- Tell the user what happened AND what they can do about it
- Provide actionable next steps ("Try again", "Contact support", "Check your input")
- Never expose stack traces, SQL queries, or internal paths to users

## Recovery Patterns

- **Retry with exponential backoff**: for transient failures (network, rate limits)
- **Circuit breaker**: stop calling a failing service, return fallback, recover periodically
- **Graceful degradation**: if a non-critical feature fails, continue without it
- **Dead letter queue**: for async jobs that fail repeatedly, park for manual review
