# ClawSelfImprove Errors

This file captures command failures, exceptions, and unexpected behaviors for analysis and prevention.

## Quick Reference
- Use format: [ERR-YYYYMMDD-XXX]
- Categories: command_failure, api_error, runtime_error, configuration_error
- Priorities: low, medium, high, critical

---

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
