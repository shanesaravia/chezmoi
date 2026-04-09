---
name: commit
description: Stage and commit local changes with a well-formed conventional commit message. Use when you want to save progress locally without pushing or creating a PR.
argument-hint: "[commit message or notes]"
disable-model-invocation: true
allowed-tools: Bash(git diff:*), Bash(git status:*), Bash(git add:*), Bash(git commit:*), Bash(git log:*), Bash(git branch:*), AskUserQuestion
---

## Context

- Current branch: !`git branch --show-current`
- Git status: !`git status --short`
- Changed files: !`git diff --stat HEAD`
- Recent commits: !`git log --oneline -10`

$ARGUMENTS

## Your task

### Step 1: Check for changes

Run `git status --short`. If there are no staged or unstaged changes, inform the user there is nothing to commit and stop.

### Step 2: Review the diff

Run `git diff` and `git diff --cached` to understand what changed. Avoid staging secrets (`.env`, credentials, `configs/firebase/`).

### Step 3: Propose a commit message

Analyze the changes and propose a conventional commit message:

- Format: `<type>(<scope>): <description>`
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `style`
- Scope: the domain or module affected (e.g., `budgets`, `auth`, `migrations`)
- Description: concise, imperative, lowercase

If `$ARGUMENTS` is provided, incorporate it into the message.

Use AskUserQuestion to present the proposed message and ask: "Use this commit message?" with options:
- **Yes** — use as-is
- **Edit** — user provides a custom message (free text follow-up)

### Step 4: Commit

1. Stage all relevant changed files (avoid secrets)
2. Commit with the confirmed message
3. Confirm the commit was created with `git log --oneline -1`
