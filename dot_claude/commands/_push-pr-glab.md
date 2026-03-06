---
allowed-tools: Bash(git checkout:*), Bash(git add:*), Bash(git status:*), Bash(git push:*), Bash(git commit:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(git ls-remote:*), Bash(glab mr list:*), Bash(glab mr create:*), Bash(glab mr view:*), AskUserQuestion
description: Commit and push changes — updates existing MR or creates a new one (GitLab)
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Default branch: main

## Your task

Follow these steps in order:

### Step 1: Check for protected branch

If the current branch is `main` or `master`, **stop and ask the user for confirmation** using AskUserQuestion before proceeding. Phrase it as: "You're currently on `<branch>`. Do you want to push directly to this branch?" with options "Yes, push to `<branch>`" and "No, create a new branch". If they deny, create a new branch (Step 3a) before continuing. If they approve, skip branch creation and continue to Step 2.

### Step 2: Check for active MR

Run `glab mr list --source-branch <current-branch> --output json` to check if an open MR already exists for the current branch. (Note: `glab mr list` shows open MRs by default — no `--state` flag needed.)

- **If an active MR exists** → go to Step 3b (push to existing MR)
- **If no active MR exists** → go to Step 3a (create new branch + MR)

Also check if the current branch exists on the remote with `git ls-remote --heads origin <current-branch>`. If the branch doesn't exist on remote, treat this as "no active MR" and go to Step 3a.

### Step 3a: New branch + MR flow

1. Analyze the changes to understand what was modified/added
2. Create a new branch with a descriptive name based on the changes (e.g., `feat/add-user-authentication`, `fix/resolve-null-pointer-error`). Use kebab-case with a prefix like `feat/`, `fix/`, `refactor/`, `docs/`, `chore/`
3. Stage all relevant changes
4. Create a commit with a clear, descriptive message
5. Push the branch to origin with `-u` flag
6. Create a merge request using `glab mr create -t "<title>" -d "<description>" -b main -y` targeting the default branch. Use `-t` for title, `-d` for description, `-b` for target branch, and `-y` to skip the confirmation prompt
7. Return the MR URL

### Step 3b: Push to existing MR flow

1. Stage all relevant changes
2. Create a commit with a clear, descriptive message
3. Push to the current branch on origin
4. Print the existing MR URL so the user can find it easily

### Rules

- Do NOT use `git add -A` blindly — avoid staging secrets (.env, credentials, etc.)
- Do NOT push with `--force` unless explicitly asked
- Always return the MR URL at the end
- Execute steps efficiently — use parallel tool calls where possible
