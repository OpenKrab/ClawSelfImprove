## [LRN-YYYYMMDD-XXX] category

**Logged**: ISO-8601 timestamp
**Priority**: low | medium | high | critical
**Status**: pending
**Area**: frontend | backend | infra | tests | docs | config

### Summary
One-line description of what was learned

### Details
Full context: what happened, what was wrong, what's correct

### Suggested Action
Specific fix or improvement to make

### Metadata
- Source: conversation | error | user_feedback
- Related Files: path/to/file.ext
- Tags: tag1, tag2
- See Also: LRN-20260302-001 (if related to existing entry)
- Pattern-Key: simplify.dead_code | harden.input_validation (optional)
- Recurrence-Count: 1 (optional)
- First-Seen: 2026-03-02 (optional)
- Last-Seen: 2026-03-02 (optional)

---

## Learning Categories

### correction
User corrects the AI:
- "No, that's not right..."
- "Actually, it should be..."
- "You're wrong about..."
- "That's outdated..."

### knowledge_gap
AI learns something new from user:
- User provides information AI didn't know
- Documentation AI referenced is outdated
- API behavior differs from AI's understanding

### best_practice
Discover a better approach:
- Performance improvement
- Code simplification
- Security enhancement
- User experience improvement

### workflow_improvement
Find a better way to work:
- Process optimization
- Remove unnecessary steps
- Make things more reproducible

## Priority Guidelines

| Priority | When to Use |
|----------|-------------|
| `critical` | Blocks core functionality, data loss risk, security issue |
| `high` | Significant impact, affects common workflows, recurring issue |
| `medium` | Moderate impact, workaround exists |
| `low` | Minor inconvenience, edge case, nice-to-have |

## Area Tags

| Area | Scope |
|------|-------|
| `frontend` | UI, components, client-side code |
| `backend` | API, services, server-side code |
| `infra` | CI/CD, deployment, Docker, cloud |
| `tests` | Test files, testing utilities, coverage |
| `docs` | Documentation, comments, READMEs |
| `config` | Configuration files, environment, settings |

## Example Learning Entry

## [LRN-20260302-001] correction

**Logged**: 2026-03-02T14:30:00+07:00
**Priority**: high
**Status**: pending
**Area**: backend

### Summary
Use async/await instead of .then() for better error handling in API calls

### Details
User corrected that async/await pattern should be used instead of .then() chains
because:
1. Better error handling with try/catch blocks
2. More readable sequential flow
3. Easier debugging

Example provided by user:
```javascript
// Instead of .then()
fetch('/api/data')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error(error));

// Use async/await
async function fetchData() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();
    console.log(data);
  } catch (error) {
    console.error(error);
  }
}
```

### Suggested Action
1. Convert all API calls using .then() to async/await
2. Add proper error handling
3. Update documentation to show async/await examples

### Metadata
- Source: user_feedback
- Related Files: src/api/*.js
- Tags: javascript, async, await, error-handling
- Pattern-Key: javascript.async_await_pattern
- Recurrence-Count: 1
- First-Seen: 2026-03-02
- Last-Seen: 2026-03-02

---
