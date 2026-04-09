---
name: virtual-team
description: Orchestrates a virtual engineering team for new implementations. Activates when the user says "virtual team", "team workflow", or requests a full multi-agent implementation workflow with Architect → QA → Engineer.
argument-hint: "[task description]"
allowed-tools: Agent
---

## User's Request

$ARGUMENTS

---

Orchestrate a team of specialized agent personas to implement the request above. Invoke each role using the Agent tool with the `subagent_type` matching the agent name (e.g., `subagent_type: "systems-architect"`). Follow the sequence below exactly.

**Context handoff:** After each agent completes, capture its full output. Include the user's original request plus all prior agents' full outputs in each subsequent agent's prompt — every agent starts cold and needs this chain to have full context.

## Team

### Core (always involved)

| Role | subagent_type | Responsibility |
|------|---------------|----------------|
| Systems Architect | `systems-architect` | High-level architecture, component boundaries, trade-offs |
| QA Engineer | `qa-engineer` | Test strategy, failing tests before implementation |
| Senior Software Engineer | `senior-software-engineer` | Production-quality implementation until all tests pass |
| Code Reviewer | `code-reviewer` | Reviews all uncommitted changes for bugs and issues |

### Support (invoke when needed)

| Role | subagent_type | When to invoke |
|------|---------------|----------------|
| Product Manager | `product-manager` | Requirements are ambiguous or scope needs definition — invoke **before** Systems Architect |
| DevOps/SRE | `devops-sre` | CI/CD, containerization, infrastructure, production readiness |

## Sequence

```
0. Product Manager      → (if needed) clarify ambiguous requirements BEFORE architecture begins
1. Systems Architect    → Creates architectural plan
2. QA Engineer          → Writes failing tests (real tests — no placeholders)
3. Senior Engineer      → Implements until all tests pass
4. QA Engineer (review) → Verifies every test is meaningful, no placeholders remain
5. Code Reviewer        → Reviews all uncommitted changes for bugs and issues
6. DevOps/SRE           → (if needed) deployment / infrastructure
```

## No Placeholder Tests Policy

The workflow is NOT complete until every test is real and meaningful.

- Placeholder tests (`test.todo(...)`, `it.skip(...)`, empty bodies, `true === true`) are never acceptable
- QA Engineer must write fully implemented tests from the start
- Senior Engineer must flag any incomplete tests encountered rather than silently skipping them
- Step 4 (QA final review) is mandatory — replace any stubs and confirm all tests pass
