---
description: "Kotlin quality checks: format, detekt, gradle build"
globs: ["**/*.kt", "**/*.kts", "**/build.gradle.kts"]
alwaysApply: false
---
# Kotlin Quality Reminders

## After Editing Kotlin Files

Run these checks to catch issues early:

- **ktfmt/ktlint**: Format `.kt` and `.kts` files after editing
- **detekt**: Run static analysis on modified Kotlin files
- **./gradlew build**: Verify compilation after changes

Ensure code passes all checks before committing.
