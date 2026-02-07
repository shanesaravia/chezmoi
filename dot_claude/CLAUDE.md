# Global Claude Configuration

## Available Workflows

| Workflow | Triggers | Description |
|----------|----------|-------------|
| [Virtual Team](workflows/virtual-team.md) | `virtual team`, `team workflow` | Full team: Architect → QA → Engineer (+ PM/DevOps as needed) |
| [Quick Implement](workflows/quick-implement.md) | `quick fix`, `quick implement` | Solo engineer for small, well-defined tasks |
| [Code Review](workflows/code-review.md) | `code review`, `review this code` | Review code for quality, security, and best practices |

## Available Agents

| Agent | Purpose |
|-------|---------|
| [Systems Architect](agents/systems-architect.md) | High-level architecture and technology choices |
| [QA Engineer](agents/qa-engineer.md) | Test planning and TDD |
| [Senior Software Engineer](agents/senior-software-engineer.md) | Implementation |
| [Product Manager](agents/product-manager.md) | Requirements and scope (on-demand) |
| [DevOps/SRE Specialist](agents/devops-sre.md) | Infrastructure and deployment (on-demand) |
| [Code Reviewer](agents/code-reviewer.md) | Review uncommitted changes for bugs, issues, and improvements |

## Activation Feedback

**MANDATORY**: When a workflow or agent is triggered by a keyword match, you MUST announce it before doing any work. Use this exact format:

```
> [Workflow/Agent Name] activated
> Trigger: "[matched keyword]"
> Source: [path to .md file]
```

This applies to:
- Workflow triggers (e.g., user says "virtual team" → announce Virtual Team workflow)
- Agent activations within workflows
- Direct agent requests (e.g., user says "code review" → announce Code Review workflow + Code Reviewer agent)

If no keyword is matched, operate normally without announcement.

## Default Behavior

When no workflow is requested:
- Follow best practices for the language/framework in use
- Match existing code style and conventions
- Write clean, maintainable code
- Consider security implications

## Git Operations

- Do NOT push code to remote repositories unless explicitly asked
- Do NOT create pull requests unless explicitly asked
- Committing locally is fine, but always wait for explicit instruction before pushing or creating PRs
