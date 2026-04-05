---
description: "Go quality checks: format, vet, staticcheck"
globs: ["**/*.go", "**/go.mod", "**/go.sum"]
alwaysApply: false
---
# Go Quality Reminders

## After Editing Go Files

Run these checks to catch issues early:

- **gofmt/goimports**: Format `.go` files after editing
- **go vet**: Run static analysis on modified packages
- **staticcheck**: Run extended static checks when available

Ensure code passes all three before committing.
