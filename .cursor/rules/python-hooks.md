---
description: "Python quality checks: format, type-check, print statements"
globs: ["**/*.py", "**/*.pyi"]
alwaysApply: false
---
# Python Quality Reminders

## After Editing Python Files

Run these checks to catch issues early:

- **black/ruff**: Format `.py` files after editing
- **mypy/pyright**: Run type checking after editing `.py` files
- **print() audit**: Check for leftover `print()` statements — use `logging` module instead

Ensure code passes formatting and type-checking before committing.
