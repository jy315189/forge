---
description: "Java coding style extending common rules"
globs: ["**/*.java", "**/pom.xml", "**/build.gradle", "**/build.gradle.kts"]
alwaysApply: false
---
# Java Coding Style

> This file extends the common coding style rule with Java specific content.

## Formatting

- Use **4 spaces** for indentation (never tabs)
- Max line length: 120 characters
- Use **google-java-format** or **Checkstyle** — no style debates
- Braces on same line (K&R style)

## Naming

- Classes: `PascalCase` (`UserService`, `OrderRepository`)
- Methods/variables: `camelCase` (`findById`, `userName`)
- Constants: `UPPER_SNAKE_CASE` (`MAX_RETRY_COUNT`)
- Packages: all lowercase, no underscores (`com.example.userservice`)
- Interfaces: no `I` prefix — `UserRepository` not `IUserRepository`
- Booleans: prefix with `is`, `has`, `can` (`isActive`, `hasPermission`)

## Modern Java (17+)

- Use **records** for immutable data carriers
- Use **sealed classes** for restricted hierarchies
- Use **pattern matching** for `instanceof` checks
- Use **text blocks** for multi-line strings
- Prefer `var` for local variables when type is obvious from RHS

```java
public record UserDto(String name, String email, Instant createdAt) {}

public sealed interface PaymentResult
    permits PaymentSuccess, PaymentFailure {}
```

## Stream API

- Keep stream pipelines ≤ 5 operations
- Extract complex lambdas into named methods
- Prefer `toList()` over `collect(Collectors.toList())` (Java 16+)
- Use `Optional` for return types, never for parameters or fields

## Dependencies

- Prefer constructor injection over field injection
- No `@Autowired` on fields — use constructor with `final` fields
- Favor composition over inheritance
