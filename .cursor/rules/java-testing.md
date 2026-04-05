---
description: "Java testing extending common rules"
globs: ["**/*.java", "**/pom.xml", "**/build.gradle", "**/build.gradle.kts"]
alwaysApply: false
---
# Java Testing

> This file extends the common testing rule with Java specific content.

## Framework Stack

- **JUnit 5** for unit and integration tests
- **Mockito** for mocking dependencies
- **AssertJ** for fluent assertions (prefer over JUnit assertions)
- **Testcontainers** for integration tests with real databases
- **MockMvc** or **WebTestClient** for controller tests

## Test Organization

```
src/test/java/
├── unit/           # Pure logic, no Spring context
├── integration/    # With Spring context, DB, external services
└── e2e/            # Full application tests
```

## Naming Convention

```java
@Test
void shouldReturnUserWhenEmailExists() { ... }

@Test
void shouldThrowNotFoundExceptionWhenUserDoesNotExist() { ... }
```

## Unit Test Pattern

```java
@ExtendWith(MockitoExtension.class)
class UserServiceTest {
    @Mock UserRepository userRepository;
    @InjectMocks UserService userService;

    @Test
    void shouldCreateUser() {
        // given
        var request = new CreateUserRequest("John", "john@test.com", "password123!");
        when(userRepository.save(any())).thenReturn(testUser());
        // when
        var result = userService.createUser(request);
        // then
        assertThat(result.name()).isEqualTo("John");
        verify(userRepository).save(any());
    }
}
```

## Integration Test Pattern

```java
@SpringBootTest
@Testcontainers
class UserRepositoryIntegrationTest {
    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16");

    @Test
    void shouldFindUserByEmail() { ... }
}
```

## Coverage

- Minimum 80% line coverage for business logic (`service/`, `domain/`)
- Run with `jacoco-maven-plugin` or `jacoco` Gradle plugin
- Exclude DTOs, configs, and generated code from coverage
