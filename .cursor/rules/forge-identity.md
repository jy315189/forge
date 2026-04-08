---
description: "Forge: the development rules system identity, versioning, and extension protocol"
alwaysApply: true
---
# Forge — Development Rules System

**Forge** is the name of this development rules and knowledge system. Use "Forge" when referencing, discussing, or extending this system.

## System Composition

```
Forge = Rules (编码约束) + Skills (领域知识) + CE (工作流引擎) + CALOR (进化循环) + Experiences (经验库)
```

| Layer | Component | Count | Scope |
|-------|-----------|-------|-------|
| 0 | Cursor Built-in Skills | 7 | System |
| 1 | CE Plugin Skills | 41 | Plugin |
| 2 | Workspace Rules (`.cursor/rules/`) | dynamic | Project |
| 3 | User Skills (`~/.cursor/skills/`) | dynamic | Global |
| 4 | Extension Framework (CALOR) | — | Meta |
| 5 | Experience Store (`~/.cursor/experiences/`) | dynamic | Global |

## Current Version

- **Forge v1.4** | Updated: 2026-04-08
- Token budget: ≤ 10000 tokens (5% of 200K context)
- Evolution log: `docs/evolution-log.md`
- Dashboard: `docs/forge-dashboard.html`

## Extension Protocol

To add new rules or skills to Forge:
1. Check `_evolution` skill for CALOR process
2. Follow naming convention: `{scope}-{aspect}.md`
3. Keep description ≤ 15 English words
4. Use `globs` for language/file-specific rules (not `alwaysApply`)
5. Record change in `docs/evolution-log.md`

## Quick Reference

- Add language: create 5 files `{lang}-{coding-style|patterns|security|testing|hooks}.md`
- Add domain skill: create `~/.cursor/skills/{domain}/SKILL.md`
- Record experience: `@experience-system` or auto-prompted after fixing errors
- Query experiences: search `~/.cursor/experiences/` by keyword/category
- Run audit: invoke `@_evolution` skill
- Monitor status: open `docs/forge-dashboard.html`
