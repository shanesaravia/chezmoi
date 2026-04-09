---
name: review
description: Review code changes for bugs, security issues, and improvements. Asks for scope (uncommitted changes or branch vs main), then presents findings with severity levels and offers to apply fixes.
argument-hint: "[uncommitted|branch]"
allowed-tools: Bash(git diff:*), Bash(git log:*), Bash(git branch:*), Bash(git status:*), Bash(git merge-base:*), AskUserQuestion, Read, Edit
disable-model-invocation: true
---

## Context

- Current branch: !`git branch --show-current`
- Git status: !`git status --short`

## Your task

### Step 1: Determine scope

If `$ARGUMENTS` clearly indicates a scope (e.g., contains "uncommitted", "staged", "branch", "main", or similar intent), infer it directly and skip asking. Otherwise, ask the user using AskUserQuestion with these options:

- **Uncommitted changes** — Review only staged + unstaged changes not yet committed
- **Branch vs main** — Review all changes on this branch compared to main

### Step 2: Gather the diff

- **Uncommitted changes**: Run `git diff` and `git diff --cached`. If both are empty, inform the user there's nothing to review and stop.
- **Branch vs main**: Run `git diff main...HEAD`. Also run `git diff` and `git diff --cached` to include any uncommitted work. Combine them for the full review scope. If the branch *is* main, inform the user and stop.

### Step 3: Review

The diff is now gathered — proceed directly to analysis. Use the review categories, severity levels, and output format defined in `~/.claude/agents/code-reviewer.md`. Use the Read tool to read surrounding file context as needed to understand how changes fit into the existing code.

### Step 4: Offer to apply fixes

After presenting findings, ask the user which fixes they'd like using AskUserQuestion with `multiSelect: true`. List each finding as its own option: `[Severity] file:line — short description`. Include a final option **"None — review only"**.

Apply only the selected fixes. If none selected or user picks "None — review only", stop without making changes.
