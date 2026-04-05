---
description: "Dependency management: selection, versioning, updates, security audits"
globs: "**/{package.json,go.mod,requirements*.txt,Pipfile,pyproject.toml,build.gradle*,pom.xml,Gemfile,Cargo.toml,pubspec.yaml}"
---
# Dependency Management Standards

## Adding Dependencies

Before adding a new dependency, evaluate:

| Criterion | Check |
|-----------|-------|
| **Necessity** | Can this be done with stdlib or existing deps in < 50 lines? |
| **Maintenance** | Last commit < 6 months? Active maintainers? |
| **Popularity** | Significant community adoption (stars, downloads)? |
| **Size** | Bundle impact acceptable? (check with bundlephobia for JS) |
| **License** | Compatible with project license? (MIT, Apache OK; GPL may conflict) |
| **Security** | No known CVEs? No excessive permissions? |

**Rule**: If standard library can do it in ≤ 50 lines, don't add a dependency.

## Version Pinning

- **Lock files** (`yarn.lock`, `go.sum`, `poetry.lock`): ALWAYS commit
- **Pin exact versions** in production deps: `"lodash": "4.17.21"` not `"^4.17.0"`
- **Allow ranges** only for dev deps and libraries (not applications)
- **Never use `latest`** tag in production manifests

## Update Strategy

- **Weekly**: automated security patch updates (Dependabot, Renovate)
- **Monthly**: review and apply minor version updates
- **Quarterly**: evaluate major version upgrades — check changelogs and test thoroughly
- **Immediately**: update when a CVE is reported for a direct dependency

## Security Auditing

- Run `npm audit` / `pip audit` / `go vuln` in CI — fail on high/critical
- Review transitive dependencies — not just direct ones
- Remove unused dependencies regularly (`depcheck`, `go mod tidy`)
- Monitor advisories: GitHub Security Alerts, Snyk, or equivalent

## Vendoring

- **Go**: `go mod vendor` for reproducible builds in CI
- **Node**: use lock file, do NOT vendor `node_modules`
- **Python**: use virtual environments, pin in `requirements.txt` or `pyproject.toml`

## Documentation

- Document WHY each major dependency was chosen (not just what)
- Note any dependency with a restrictive license in README or `docs/licenses.md`
- When replacing a dependency, document the migration in CHANGELOG
