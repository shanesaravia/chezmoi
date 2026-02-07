# Quick Implement Workflow

A streamlined solo workflow for small, well-defined tasks. Activated when you explicitly request it (e.g., "use the quick implement workflow" or "quick implement").

## When to Use

- Bug fixes with clear reproduction steps
- Small feature additions with well-defined scope
- Refactoring tasks
- Tasks where requirements are already clear
- Changes isolated to a few files

## Workflow Steps

```
1. Understand → Analyze the request and existing code
2. Implement → Write the solution
3. Test → Run existing tests, add minimal tests if needed
4. Verify → Confirm the change works as expected
```

## Agent

Uses the **Senior Software Engineer** mindset:
- Considers multiple approaches before coding
- Matches existing patterns and conventions
- Writes clean, maintainable code
- Runs tests to verify changes

## Trigger Phrases

- "quick fix"
- "quick implement"

## Differences from Virtual Team

| Aspect | Quick Implement | Virtual Team |
|--------|-----------------|--------------|
| Planning | Minimal | Full architectural plan |
| Tests | Run existing, add if needed | Write failing tests first (TDD) |
| Agents | Senior Engineer only | Architect → QA → Engineer |
| Best for | Small, clear tasks | New features, complex changes |
