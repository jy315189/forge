# Source Information

**Upstream repository:** https://github.com/forrestchang/andrej-karpathy-skills
**Mirrored on:** 2026-05-01
**Mirrored by:** Forge external vendor process
**License:** MIT (upstream)

## What is this folder?

This folder is a **read-only local mirror** of the upstream `andrej-karpathy-skills` project. It is preserved for reference and provenance — when we later decide to merge any of these principles into Forge's own rule system, this folder shows exactly which version of the upstream we evaluated.

## Files mirrored

| Local path | Upstream path | Purpose |
|------------|---------------|---------|
| `README.md` | `README.md` | Project overview (English) |
| `README.zh.md` | `README.zh.md` | Project overview (中文) |
| `CLAUDE.md` | `CLAUDE.md` | Root instruction file for Claude Code |
| `CURSOR.md` | `CURSOR.md` | Cursor-specific setup notes |
| `.cursor/rules/karpathy-guidelines.mdc` | `.cursor/rules/karpathy-guidelines.mdc` | Cursor project rule (alwaysApply) |
| `skills/karpathy-guidelines/SKILL.md` | `skills/karpathy-guidelines/SKILL.md` | Reusable Cursor/Claude skill |
| `.claude-plugin/plugin.json` | `.claude-plugin/plugin.json` | Claude Code plugin manifest |
| `.claude-plugin/marketplace.json` | `.claude-plugin/marketplace.json` | Plugin marketplace listing |

## Do NOT modify these files

If you want to adapt the guidelines for Forge, do it in `.cursor/rules/` at the workspace root and record the change in `docs/evolution-log.md`. Keep this folder as the unmodified upstream snapshot.
