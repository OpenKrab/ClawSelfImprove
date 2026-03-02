# ClawSelfImprove Learnings

This file captures corrections, knowledge gaps, and best practices discovered during development.

## Quick Reference
- Use format: [LRN-YYYYMMDD-XXX]
- Categories: correction, knowledge_gap, best_practice, workflow_improvement
- Priorities: low, medium, high, critical

---

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
