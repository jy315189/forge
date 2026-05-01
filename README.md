# Forge — Development Rules System

> A comprehensive, evolving development rules and knowledge system for [Cursor IDE](https://cursor.com).
> 
> 一套完整的、持续进化的 Cursor 开发规则与知识体系。

---

## What is Forge?

**Forge** is a production-ready Cursor configuration that combines:

- **43 Workspace Rules** — coding style, security, testing, architecture, API design, and more
- **22 User Skills** — domain knowledge for orchestration, TDD, error handling, content creation, etc.
- **CALOR Evolution Cycle** — a systematic framework for continuous rule improvement
- **Integration with Compound Engineering (CE)** — 41 plugin skills for workflow automation

### Supported Languages

| Language | Rules | Coverage |
|----------|-------|----------|
| Go | 5 | Style, patterns, security, testing, quality |
| TypeScript/JavaScript | 5 | Style, patterns, security, testing, quality |
| Python | 5 | Style, patterns, security, testing, quality |
| Kotlin | 5 | Style, patterns, security, testing, quality |
| Java | 5 | Style, patterns, security, testing, quality |
| Frontend (framework-agnostic) | 1 | Components, state, performance, CSS, a11y |

### Common Rules (all languages)

| Rule | Loading | Purpose |
|------|---------|---------|
| `forge-identity` | alwaysApply | System identity, version, extension protocol |
| `common-coding-style` | alwaysApply | Immutability, naming, structure |
| `common-git-workflow` | alwaysApply | Conventional commits, PR workflow |
| `common-patterns` | alwaysApply | Design patterns, architecture |
| `common-security` | alwaysApply | Security checklist, secret management |
| `common-testing` | alwaysApply | TDD, 80% coverage, test organization |
| `common-performance` | alwaysApply | Context management, build optimization |
| `common-development-workflow` | alwaysApply | 5W1H analysis, task routing, CE pipeline |
| `common-documentation` | alwaysApply | Comments, README, API docs, changelog |
| `common-error-handling` | alwaysApply | Error classification, logging, recovery |
| `common-llm-behavior` | alwaysApply | Karpathy guidelines: surgical changes, simplicity, goal-driven |
| `common-project-init` | on-demand | Project bootstrapping checklist |
| `common-architecture` | on-demand | Layered architecture, module boundaries |
| `common-design-system` | glob | UI/UX: layout, color, typography, a11y |
| `common-api-design` | glob | RESTful conventions, status codes, pagination |
| `common-database` | glob | Schema design, migrations, indexing |
| `common-dependency` | glob | Dependency selection, versioning, auditing |
| `forge-extensibility` | on-demand | Extension templates, versioning, migration |

---

## Quick Start

### New Project on This Machine

```powershell
# Run the Forge project generator
.\scripts\forge-new.bat "D:\projects\my-new-project"
```

This copies `.cursor/` to your new project with all 43 rules ready to go.

### New Machine Setup

```powershell
# 1. Clone this repo
git clone https://github.com/YOUR_USERNAME/forge.git

# 2. Run the sync script to install user-level skills
.\forge\scripts\forge-sync.bat

# 3. Done — skills are globally available for all projects
```

### Manual Setup

```powershell
# Just copy the .cursor folder to any project
Copy-Item -Path ".cursor" -Destination "D:\projects\my-project\.cursor" -Recurse
```

---

## Project Structure

```
forge/
├── .cursor/
│   ├── rules/                  # 43 workspace rules
│   │   ├── forge-*.md          # System identity & extensibility
│   │   ├── common-*.md         # Language-agnostic rules (15)
│   │   ├── golang-*.md         # Go rules (5)
│   │   ├── typescript-*.md     # TypeScript/JS rules (5)
│   │   ├── python-*.md         # Python rules (5)
│   │   ├── kotlin-*.md         # Kotlin rules (5)
│   │   ├── java-*.md           # Java rules (5)
│   │   └── frontend-*.md      # Frontend engineering (1)
│   └── settings.json           # CE plugin config
├── docs/
│   ├── evolution-log.md        # Change tracking (CALOR cycle)
│   ├── forge-dashboard.html    # Visual monitoring dashboard
│   └── cursor-integration-plan.md  # Architecture reference
├── scripts/
│   ├── forge-new.bat           # Create new project with Forge
│   └── forge-sync.bat          # Sync skills to new machine
├── .gitignore
└── README.md
```

---

## How It Works

### Two-Layer Architecture

```
Layer 1: Project-Level (travels with each project)
  └── .cursor/rules/ — copied to each project via forge-new.bat

Layer 2: User-Level (global, shared across all projects)
  └── ~/.cursor/skills/ — installed once via forge-sync.bat
  └── CE Plugin — managed by Cursor automatically
```

### Token Budget

Forge is designed to stay within **3% of Cursor's 200K context window** (~6000 tokens):

- `alwaysApply` rules load every conversation (~2050 tokens)
- `glob` rules load only when matching files are open (~0-800 tokens)
- `on-demand` rules load only when referenced (~0 tokens)
- Skill descriptions are trimmed to ≤15 words each (~440 tokens)

### CALOR Evolution Cycle

```
Candidate → Assess → Load → Optimize → Review
   ↑                                      │
   └──────────────────────────────────────┘
```

Rules and skills are continuously improved through the CALOR cycle.
Track all changes in `docs/evolution-log.md`.
Monitor system health at `docs/forge-dashboard.html`.

---

## Extending Forge

### Add a New Language

Create 5 files in `.cursor/rules/`:

```
{lang}-coding-style.md    # Style, formatting, naming
{lang}-patterns.md        # Design patterns, architecture
{lang}-security.md        # Security best practices
{lang}-testing.md         # Testing framework, conventions
{lang}-hooks.md           # Quality reminders, static analysis
```

Each file needs this frontmatter:

```yaml
---
description: "{Lang} {aspect} extending common rules"
globs: ["**/*.{ext}"]
alwaysApply: false
---
```

### Add a New Skill

Create `~/.cursor/skills/{domain}/SKILL.md` with:

```yaml
---
name: {domain}
description: "≤15 word description of WHAT and WHEN to use"
---
```

### Record Changes

Always update `docs/evolution-log.md` after adding, modifying, or retiring components.

---

## Version

**Forge v1.5** — 2026-05-01

| Metric | Value |
|--------|-------|
| Rules | 46 |
| Skills | 23 |
| Languages | 6 |
| Token Budget | ~6420 (~3.21%) |
| CALOR Round | 1 complete |

### Version History

| Version | Date | Highlight |
|---------|------|-----------|
| v1.2 | 2026-04-06 | System named Forge, +Java(5) +Frontend(1) +identity(2) +Dashboard |
| v1.3 | 2026-04-08 | +frontend-design-tokens, token budget raised to 10000 (5%) |
| v1.4 | 2026-04-08 | +Experience Store layer, experience loop in workflow |
| v1.5 | 2026-05-01 | +common-llm-behavior (Karpathy), LLM-Behavior layer added |

---

## License

MIT
