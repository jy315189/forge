---
description: "Java quality reminders extending common rules"
globs: ["**/*.java", "**/pom.xml", "**/build.gradle", "**/build.gradle.kts"]
alwaysApply: false
---
# Java Quality Reminders

> Quality checks to perform after editing Java files.

## After Every Edit

- [ ] No `System.out.println` — use SLF4J logger
- [ ] No raw types — always parameterize generics
- [ ] No field injection (`@Autowired` on fields) — use constructor injection
- [ ] No `null` returns for collections — return empty list/set/map
- [ ] Resources closed properly (try-with-resources)

## Static Analysis

- Run **SpotBugs** for bug detection
- Run **PMD** for code quality rules
- Run **Checkstyle** for formatting compliance
- Run **Error Prone** compiler plugin for compile-time checks

## Before Commit

- [ ] `mvn verify` or `gradle check` passes
- [ ] No compiler warnings
- [ ] No TODO without issue reference
- [ ] Javadoc on all public API methods
