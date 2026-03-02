## [ERR-YYYYMMDD-XXX] skill_or_command_name

**Logged**: ISO-8601 timestamp
**Priority**: high
**Status**: pending
**Area**: frontend | backend | infra | tests | docs | config

### Summary
Brief description of what failed

### Error
```
Actual error message or output
```

### Context
- Command/operation attempted
- Input or parameters used
- Environment details if relevant

### Suggested Fix
If identifiable, what might resolve this

### Metadata
- Reproducible: yes | no | unknown
- Related Files: path/to/file.ext
- See Also: ERR-20260302-001 (if recurring)

---

## Error Categories

### command_failure
Command line tool failures:
- Build tools (npm, yarn, webpack, etc.)
- Git operations
- Database commands
- System utilities

### api_error
External API failures:
- HTTP 4xx/5xx responses
- Authentication failures
- Rate limiting
- Service unavailable

### runtime_error
Application runtime errors:
- Exceptions
- Stack traces
- Memory issues
- Performance problems

### configuration_error
Setup and config issues:
- Missing environment variables
- Invalid configuration
- Dependency conflicts
- Permission issues

## Priority Guidelines for Errors

| Priority | When to Use |
|----------|-------------|
| `critical` | Production outage, data corruption, security breach |
| `high` | Build failure, test suite failure, blocked development |
| `medium` | Non-critical feature broken, workaround available |
| `low` | Cosmetic issue, minor inconvenience, edge case |

## Example Error Entry

## [ERR-20260302-001] npm_install

**Logged**: 2026-03-02T15:45:00+07:00
**Priority**: high
**Status**: pending
**Area**: infra

### Summary
npm install failed due to peer dependency conflict with React 18

### Error
```
npm ERR! code ERESOLVE
npm ERR! ERESOLVE unable to resolve dependency tree
npm ERR! 
npm ERR! While resolving: my-project@1.0.0
npm ERR! Found: react@18.2.0
npm ERR! Could not resolve dependency:
npm ERR! peer react@"^16.8.0 || ^17.0.0" from some-library@2.1.0
```

### Context
- Running `npm install` in fresh clone
- Node.js version: 18.15.0
- npm version: 9.5.0
- Project uses React 18 but some library expects React 16/17

### Suggested Fix
1. Check if newer version of some-library supports React 18
2. Use `--force` or `--legacy-peer-deps` as temporary workaround
3. Consider downgrading React to 17 if library is critical
4. Look for alternative library with React 18 support

### Metadata
- Reproducible: yes
- Related Files: package.json, package-lock.json
- See Also: ERR-20260215-003 (similar dependency issue)

---
