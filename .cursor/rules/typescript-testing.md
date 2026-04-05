---
description: "TypeScript testing extending common rules"
globs: ["**/*.ts", "**/*.tsx", "**/*.js", "**/*.jsx"]
alwaysApply: false
---
# TypeScript/JavaScript Testing

> This file extends the common testing rule with TypeScript/JavaScript specific content.

## E2E Testing

Use **Playwright** as the E2E testing framework for critical user flows.

## Unit Testing

Use **Vitest** or **Jest** for unit and integration tests.

## Test Organization

- Co-locate tests with source: `foo.ts` → `foo.test.ts`
- Use descriptive test names that document behavior
- Group related tests with `describe` blocks
