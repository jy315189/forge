---
description: "Architecture standards: module structure, boundaries, dependencies, decisions"
alwaysApply: false
---
# Architecture Standards

## Module Design Principles

- **Single Responsibility**: each module owns one domain concept
- **Explicit Dependencies**: import what you need, no global state
- **Dependency Direction**: outer layers depend on inner (UI → Service → Domain → Infra)
- **Interface Boundaries**: modules communicate through defined contracts, not internal details

## Layered Architecture

```
┌─────────────────┐
│   Presentation   │  UI components, API handlers, CLI
├─────────────────┤
│    Application   │  Use cases, orchestration, DTOs
├─────────────────┤
│     Domain       │  Business logic, entities, rules
├─────────────────┤
│  Infrastructure  │  Database, external APIs, file I/O
└─────────────────┘
```

- Domain layer has ZERO external dependencies
- Infrastructure implements domain interfaces (dependency inversion)
- Application layer coordinates domain objects to fulfill use cases

## Dependency Rules

- **No circular dependencies** between modules
- **No skipping layers**: Presentation must not directly call Infrastructure
- **Shared code**: extract to a `lib/` or `shared/` module only when used by ≥3 modules
- **Third-party wrappers**: wrap external libraries behind your own interface for replaceability

## When to Split vs. Merge

**Split** a module when:
- It has multiple unrelated responsibilities
- Changes in one area frequently break another
- Different parts need different deployment or scaling

**Merge** modules when:
- They always change together
- Splitting creates excessive boilerplate with no isolation benefit
- The "module" has only 1-2 files

## Decision Records

For any significant architecture decision:
1. Create `docs/adr/NNNN-title.md`
2. Include: Context, Options (≥2), Decision, Consequences
3. Decisions are immutable — create a new ADR to supersede

## Anti-Patterns to Avoid

- **God module**: one module that knows everything — split by domain
- **Premature abstraction**: don't create interfaces before you have 2+ implementations
- **Shared mutable state**: use message passing or explicit state management
- **Framework coupling**: business logic must not depend on framework types
- **Config sprawl**: centralize configuration, validate at startup
