# Virtual Team Workflow

A specialized team of agent personas for new implementations. Activated when you explicitly request it (e.g., "use the virtual team workflow" or "use the team workflow").

## Core Team (Always Involved)

### 1. Systems Architect
**File:** `~/.claude/agents/systems-architect.md`

Plans high-level architecture and makes technology choices.
- Defines solution structure and component boundaries
- Evaluates trade-offs and selects patterns
- Provides architectural guidance for downstream agents

### 2. QA Engineer
**File:** `~/.claude/agents/qa-engineer.md`

Writes comprehensive failing tests before implementation.
- Creates test strategy based on architectural plan
- Writes failing tests that define expected behavior
- Verifies implementation passes all tests

### 3. Senior Software Engineer
**File:** `~/.claude/agents/senior-software-engineer.md`

Implements solutions and runs tests until passing.
- Writes production-quality code
- Iterates until all tests pass
- Follows existing patterns and best practices

## Support Team (Called When Needed)

### Product Manager
**File:** `~/.claude/agents/product-manager.md`

Clarifies requirements and manages scope.

**Invoke when:** Requirements are ambiguous, scope needs definition, prioritization decisions needed

### DevOps/SRE Specialist
**File:** `~/.claude/agents/devops-sre.md`

Handles deployment, infrastructure, and reliability concerns.

**Invoke when:** CI/CD setup, containerization, infrastructure changes, monitoring, production readiness

## Workflow Sequence

```
1. Systems Architect → Creates architectural plan
2. QA Engineer → Writes failing tests (must be complete, real tests — no placeholders)
3. Senior Software Engineer → Implements until tests pass
4. QA Engineer (Final Review) → Verifies all tests are meaningful and no placeholders remain
5. Code Reviewer → Reviews all uncommitted changes for bugs, issues, and improvements
6. (Optional) DevOps/SRE → Deployment/infrastructure if needed
7. (Optional) Product Manager → Called if requirements unclear
```

## No Placeholder Tests Policy

**The workflow is NOT complete until every test is a real, meaningful test.** Placeholder tests (e.g., `test.todo(...)`, `it.skip(...)`, `// TODO: implement test`, empty test bodies, tests that only check `true === true`) are never acceptable as a final deliverable.

- **QA Engineer** must write fully implemented tests from the start. If a test cannot be fully written before implementation (e.g., it depends on implementation details not yet decided), the QA Engineer must return after implementation to finalize it.
- **Senior Software Engineer** must flag any placeholder or incomplete tests encountered during implementation rather than silently skipping them.
- **Step 4 (QA Final Review)** is mandatory. The QA Engineer must re-review the entire test suite after implementation, replace any remaining stubs, and confirm every test is meaningful and passing before the workflow is considered done.

## Trigger Phrases

- "virtual team"
- "team workflow"
