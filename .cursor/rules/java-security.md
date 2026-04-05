---
description: "Java security extending common rules"
globs: ["**/*.java", "**/pom.xml", "**/build.gradle", "**/build.gradle.kts"]
alwaysApply: false
---
# Java Security

> This file extends the common security rule with Java specific content.

## SQL Injection Prevention

- ALWAYS use parameterized queries or JPA named parameters
- NEVER concatenate user input into SQL strings
- Use `@Query` with named parameters: `WHERE u.email = :email`

## Input Validation

- Use Bean Validation annotations on all DTOs: `@NotNull`, `@Size`, `@Email`, `@Pattern`
- Validate at controller level with `@Valid` or `@Validated`
- Sanitize HTML input with OWASP Java HTML Sanitizer

```java
public record CreateUserRequest(
    @NotBlank @Size(max = 100) String name,
    @NotBlank @Email String email,
    @NotBlank @Size(min = 12) String password
) {}
```

## Authentication & Authorization

- Use Spring Security with method-level security (`@PreAuthorize`)
- Store passwords with `BCryptPasswordEncoder` (strength ≥ 12)
- JWT: validate signature, expiry, issuer — reject unsigned tokens
- Never expose internal IDs in tokens — use opaque references

## Dependency Security

- Run `mvn dependency-check:check` or `gradle dependencyCheckAnalyze` in CI
- Update dependencies with known CVEs immediately
- Pin dependency versions in `pom.xml` / `build.gradle`

## Secrets Management

- Use Spring Cloud Config or HashiCorp Vault for secrets
- Never commit `application-prod.yml` with real credentials
- Use `@Value("${...}")` from environment, not hardcoded strings

## Logging Security

- Never log passwords, tokens, credit cards, or PII
- Use structured logging (SLF4J + Logback/Log4j2)
- Include request ID in all log entries for traceability
