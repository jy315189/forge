---
description: "Project initialization checklist: structure, config, tooling, docs, CI setup"
alwaysApply: false
---
# Project Initialization

When creating a new project or bootstrapping a codebase, follow this checklist.

## Directory Structure

```
project-root/
├── src/                  # Source code
│   ├── lib/              # Shared utilities
│   ├── modules/          # Feature modules (domain-driven)
│   └── types/            # Shared type definitions
├── tests/                # Test files (mirror src/ structure)
├── docs/                 # Project documentation
├── scripts/              # Build/deploy/automation scripts
├── .cursor/rules/        # Cursor workspace rules
└── config/               # Environment and app config
```

Adapt to language conventions: `cmd/` + `internal/` for Go, `app/` for Rails/Django, `pages/` + `components/` for Next.js.

## Required Files at Root

| File | Purpose | Required |
|------|---------|----------|
| `README.md` | Project overview, setup, usage | Yes |
| `.gitignore` | Ignore build artifacts, secrets, deps | Yes |
| `.env.example` | Document ALL env vars (no real values) | Yes |
| `LICENSE` | License declaration | Yes (for open source) |
| `CHANGELOG.md` | Track notable changes per version | Recommended |
| Dependency manifest | `package.json`, `go.mod`, `requirements.txt`, etc. | Yes |
| Lock file | `yarn.lock`, `go.sum`, `poetry.lock`, etc. | Yes (commit it) |

## Configuration Checklist

- [ ] Linter configured (ESLint, golangci-lint, Ruff, ktlint)
- [ ] Formatter configured (Prettier, gofmt, Black, ktfmt)
- [ ] Pre-commit hooks (lint-staged, husky, or equivalent)
- [ ] TypeScript: `strict: true` in tsconfig
- [ ] Editor config: `.editorconfig` for consistent formatting
- [ ] Environment: `.env.example` with ALL variables documented

## Security from Day One

- [ ] `.env` in `.gitignore` — NEVER commit secrets
- [ ] Dependency audit configured (`npm audit`, `go vet`, `safety`)
- [ ] No hardcoded credentials in source code
- [ ] HTTPS-only configuration for any external calls

## First Commit Standard

The initial commit should include:
1. Project structure with placeholder files
2. Dependency manifest with core deps only
3. Linter + formatter config
4. README with: project name, description, setup steps, usage
5. `.gitignore` and `.env.example`
6. Basic CI config if platform is known

Message: `feat: initialize project with core structure and tooling`
