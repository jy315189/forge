---
description: "API design: RESTful conventions, request/response format, versioning, errors"
globs: "**/{api,routes,handlers,controllers,endpoints}/**/*.{go,ts,js,py,kt}"
---
# API Design Standards

## URL Conventions

- Use **nouns** for resources: `/users`, `/orders`, `/products`
- Use **plural** forms: `/users` not `/user`
- Nest for relationships: `/users/{id}/orders`
- Max 3 levels of nesting — beyond that, use query params or top-level resource
- Lowercase, hyphen-separated: `/order-items` not `/orderItems`
- No verbs in URLs: `POST /users` not `POST /create-user`
- No trailing slashes: `/users` not `/users/`

## HTTP Methods

| Method | Purpose | Idempotent | Request Body |
|--------|---------|------------|-------------|
| GET | Read resource(s) | Yes | No |
| POST | Create resource | No | Yes |
| PUT | Full replace | Yes | Yes |
| PATCH | Partial update | Yes | Yes (partial) |
| DELETE | Remove resource | Yes | No |

## Response Format

```json
{
  "data": { ... },
  "meta": { "page": 1, "per_page": 20, "total": 100 }
}
```

Error response:
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Email format is invalid",
    "details": [{ "field": "email", "reason": "must be a valid email" }]
  }
}
```

## Status Codes

| Code | When |
|------|------|
| 200 | Success with body |
| 201 | Resource created |
| 204 | Success, no body (DELETE) |
| 400 | Validation error, bad input |
| 401 | Not authenticated |
| 403 | Authenticated but not authorized |
| 404 | Resource not found |
| 409 | Conflict (duplicate, state conflict) |
| 422 | Semantic validation failure |
| 429 | Rate limited |
| 500 | Unexpected server error |

## Pagination

- Use cursor-based pagination for large/changing datasets: `?cursor=abc&limit=20`
- Use offset-based for simple cases: `?page=1&per_page=20`
- Always return pagination metadata in response
- Default page size: 20. Maximum: 100.

## Versioning

- Prefer URL prefix versioning: `/api/v1/users`
- Major version only — minor/patch changes must be backward-compatible
- Deprecate old versions with `Sunset` header and documentation

## Request Validation

- Validate ALL inputs at the API boundary
- Return 400 with specific field-level errors
- Reject unknown fields in strict mode
- Enforce maximum lengths, allowed values, format patterns
