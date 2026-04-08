---
description: "Forge extension and upgrade framework: templates, versioning, migration"
alwaysApply: false
---
# Forge Extensibility & Upgrade Framework

## Versioning Scheme

```
Forge vMAJOR.MINOR

MAJOR: Architecture change (new layers, breaking restructure)
MINOR: New rules/skills added, optimized, or retired
```

Update version in `forge-identity.md` and `docs/evolution-log.md` after changes.

## Adding a New Language

```
Template: .cursor/rules/{lang}-{aspect}.md

Required files (5):
  {lang}-coding-style.md   → Style, formatting, naming, idioms
  {lang}-patterns.md       → Design patterns, architecture
  {lang}-security.md       → Language-specific security
  {lang}-testing.md        → Testing framework, conventions
  {lang}-hooks.md          → Quality reminders, static analysis

Frontmatter template:
  ---
  description: "{Lang} {aspect} extending common rules"
  globs: ["**/*.{ext}", "**/config-file"]
  alwaysApply: false
  ---

Token budget: ≤ 1200 tokens for all 5 files combined.
Record in: docs/evolution-log.md
```

## Adding a New Common Rule

```
Template: .cursor/rules/common-{topic}.md

Decide loading strategy:
  alwaysApply: true   → Universal rules (coding style, security, errors)
  globs: [...]        → File-type-specific (API, DB, frontend)
  alwaysApply: false  → On-demand (architecture, project-init)

Token impact:
  alwaysApply = +150~250 tokens per rule (budget-sensitive!)
  globs/on-demand = +0 tokens to baseline

Red line: total alwaysApply rules ≤ 15 (to keep under budget)
```

## Adding a New Skill

```
Template: ~/.cursor/skills/{domain}/SKILL.md

Requirements:
  - YAML frontmatter with name and description
  - description ≤ 15 English words (WHAT + WHEN)
  - No overlap with existing skill descriptions
  - Content ≤ 500 lines

Process:
  1. Check CE plugin skills — already covered?
  2. Check _evolution candidate list — existing candidate?
  3. Create SKILL.md with proper frontmatter
  4. Record in docs/evolution-log.md
```

## Upgrading Existing Components

```
Safe upgrade checklist:
  □ Read current file fully before editing
  □ Preserve the frontmatter structure
  □ Maintain backward compatibility of advice
  □ Update version comment if present
  □ Record change in evolution-log.md
  □ Verify token budget still within limits
```

## Migration Between Projects

```
Full migration:
  cp -r .cursor/rules/ <new-project>/.cursor/rules/

Selective migration (by project type):
  Common rules: always copy all common-*.md
  Language rules: copy only languages used in project
  Design rules: copy only if project has frontend

Shared skills (no migration needed):
  ~/.cursor/skills/ is global — available in all projects
```

## Retirement Process

```
When to retire:
  - Unused for 3+ months (quarterly audit)
  - Fully superseded by CE plugin or new rule
  - Content became obsolete (framework EOL)

How to retire:
  Rules: delete from .cursor/rules/ (tracked in git)
  Skills: move SKILL.md → SKILL.md.bak in _archived/
  Always: record in evolution-log.md with reason
```
