---
description: "TypeScript quality checks: format, type-check, console.log"
globs: ["**/*.ts", "**/*.tsx", "**/*.js", "**/*.jsx"]
alwaysApply: false
---
# TypeScript Quality Reminders

## After Editing TS/JS Files

Run these checks to catch issues early:

- **Prettier**: Format JS/TS files after editing
- **TypeScript check**: Run `tsc --noEmit` after editing `.ts`/`.tsx` files
- **console.log audit**: Check modified files for leftover `console.log` statements

Ensure code passes formatting and type-checking before committing.
