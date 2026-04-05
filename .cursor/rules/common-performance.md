---
description: "Performance: context management, build troubleshooting"
alwaysApply: true
---
# Performance Optimization

## Context Window Management

Avoid last 20% of context window for:
- Large-scale refactoring
- Feature implementation spanning multiple files
- Debugging complex interactions

Lower context sensitivity tasks:
- Single-file edits
- Independent utility creation
- Documentation updates
- Simple bug fixes

## Build Troubleshooting

If build fails:
1. Analyze error messages carefully
2. Fix incrementally, one error at a time
3. Verify after each fix
4. Check for similar issues in related files
