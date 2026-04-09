---
name: push-pr
description: Commit and push local changes — updates an existing PR or creates a new one. Use when the user wants to publish their work to GitHub.
argument-hint: "[commit message or notes]"
disable-model-invocation: true
allowed-tools: Bash(git checkout:*), Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(git fetch:*), Bash(git stash:*), Bash(gh pr list:*), Bash(gh pr create:*), Bash(gh pr view:*), AskUserQuestion, Edit
---

## Context

- Current git status: !`git status`
- Changed files: !`git diff --stat HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`
- Default branch: main

$ARGUMENTS

## Your task

Determine which flow applies based on the current branch, then execute it.

### Step 1: Check for changes

If `git diff --stat HEAD` and `git status --short` both show nothing (no staged, unstaged, or untracked changes), inform the user there is nothing to commit and stop.

### Step 2: Determine flow

Check the current branch and whether an open PR exists for it (`gh pr list --head <current-branch> --state open --json number,title,url`). Run these checks in parallel.

| Situation | Flow |
|-----------|------|
| On `main` or `master` | **Flow A** — stash if needed, pull latest, create branch, push + open PR |
| On a feature branch with an open PR | **Flow B** — fetch, push to existing PR |
| On a feature branch with no open PR | **Flow C** — stash, switch to main, pull latest, create branch, push + open PR |

---

### Flow A — On main/master

1. If there are uncommitted changes, stash them: `git stash`
2. Pull latest from remote: `git fetch origin main && git pull origin main`
3. Ask the user for the new branch name using AskUserQuestion (free text). Suggest a descriptive kebab-case name based on the changes (e.g., `feat/add-user-auth`). Prefixes: `feat/`, `fix/`, `refactor/`, `docs/`, `chore/`
4. Create and switch to the new branch: `git checkout -b <branch-name>`
5. Pop the stash if it was used: `git stash pop`. If conflicts arise, resolve them using the Edit tool before continuing
6. Stage all relevant changes (avoid secrets: `.env`, credentials, etc.)
7. Create a commit with a clear, descriptive message — incorporate any notes from `$ARGUMENTS` if provided
8. Push the branch to origin with `-u` flag
9. Create a PR using `gh pr create` targeting `main`. Include a concise title and summary body
10. Return the PR URL

---

### Flow B — Feature branch with open PR

1. Fetch from remote: `git fetch origin`
2. Check if the remote branch is ahead of local (`git status` after fetch). If so, inform the user and ask via AskUserQuestion whether to pull first or push anyway (risking a rejected push)
3. Stage all relevant changes (avoid secrets: `.env`, credentials, etc.)
4. Create a commit with a clear, descriptive message — incorporate any notes from `$ARGUMENTS` if provided
5. Push to the current branch on origin
6. Print the existing PR URL

---

### Flow C — Feature branch with no open PR

1. If there are uncommitted changes, stash them: `git stash`
2. Switch to main: `git checkout main`
3. Pull latest: `git fetch origin main && git pull origin main`
4. Ask the user for the new branch name using AskUserQuestion (free text). Suggest a descriptive kebab-case name based on the changes (e.g., `feat/add-user-auth`). Prefixes: `feat/`, `fix/`, `refactor/`, `docs/`, `chore/`
5. Create and switch to the new branch: `git checkout -b <branch-name>`
6. Pop the stash if it was used: `git stash pop`. If conflicts arise, resolve them using the Edit tool before continuing
7. Stage all relevant changes (avoid secrets: `.env`, credentials, etc.)
8. Create a commit with a clear, descriptive message — incorporate any notes from `$ARGUMENTS` if provided
9. Push the branch to origin with `-u` flag
10. Create a PR using `gh pr create` targeting `main`. Include a concise title and summary body
11. Return the PR URL

---

### Rules

- Do NOT use `git add -A` blindly — avoid staging secrets (.env, credentials, etc.)
- Do NOT push with `--force` unless explicitly asked
- Always return the PR URL at the end
- Execute steps efficiently — use parallel tool calls where possible
