---
description: "Java design patterns extending common rules"
globs: ["**/*.java", "**/pom.xml", "**/build.gradle", "**/build.gradle.kts"]
alwaysApply: false
---
# Java Design Patterns

> This file extends the common patterns rule with Java specific content.

## Layered Architecture

```
controller/   → HTTP handlers, request validation, response mapping
service/      → Business logic, transaction boundaries
repository/   → Data access, queries
domain/       → Entities, value objects, domain events
dto/          → Data transfer objects (API contracts)
config/       → Configuration classes, beans
```

## Repository Pattern

```java
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    List<User> findByStatusIn(List<UserStatus> statuses);
}
```

## Service Pattern

```java
@Service
@Transactional(readOnly = true)
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository repo, PasswordEncoder encoder) {
        this.userRepository = repo;
        this.passwordEncoder = encoder;
    }

    @Transactional
    public UserDto createUser(CreateUserRequest request) {
        // validate → execute → map → return
    }
}
```

## Builder Pattern (for complex objects)

```java
User user = User.builder()
    .name("John")
    .email("john@example.com")
    .role(Role.ADMIN)
    .build();
```

## Exception Hierarchy

```java
public abstract class DomainException extends RuntimeException {
    private final String code;
    protected DomainException(String code, String message) {
        super(message);
        this.code = code;
    }
}

public class NotFoundException extends DomainException {
    public NotFoundException(String entity, Object id) {
        super("NOT_FOUND", entity + " not found: " + id);
    }
}
```

## Global Exception Handler

```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(NotFoundException.class)
    public ResponseEntity<ErrorResponse> handleNotFound(NotFoundException ex) {
        return ResponseEntity.status(404)
            .body(new ErrorResponse(ex.getCode(), ex.getMessage()));
    }
}
```
