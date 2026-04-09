---
name: fix-pr
description: Fetch PR review comments, assess them, and apply approved fixes. Use when responding to code review feedback on an open pull request.
argument-hint: "[PR number]"
disable-model-invocation: true
allowed-tools: Bash(gh pr view:*), Bash(gh pr diff:*), Bash(gh pr list:*), Bash(gh api:*), Bash(git diff:*), Bash(git branch:*), Bash(git status:*), Bash(git add:*), Bash(git commit:*), Bash(git push:*), AskUserQuestion, Read, Edit
---

## Context

- Current branch: !`git branch --show-current`
- Git status: !`git status --short`

## Your task

### Step 1: Find the PR

If `$ARGUMENTS` contains a PR number, use it directly. Otherwise, check for an open PR on the current branch:

```
gh pr list --head <current-branch> --state open --json number,title,url
```

- If an open PR is found, use that PR number
- If no open PR is found, ask the user for a PR number using AskUserQuestion (free text)
- If the user doesn't provide one, stop

### Step 2: Fetch review comments

Gather all feedback from the PR. Run these in parallel:

1. `gh pr view <number> --json reviews,comments` — top-level PR comments and review summaries
2. `gh api repos/{owner}/{repo}/pulls/<number>/comments` — inline review comments on specific lines
3. `gh pr diff <number>` — the current PR diff for context

Filter out already-resolved threads from the inline comments results. Only surface comments where the thread is still open/unresolved.

If there are no actionable unresolved review comments (only approvals, emoji reactions, or resolved threads), inform the user and stop.

### Step 3: Investigate and assess each comment

For each review comment:

1. Use the Read tool to read the relevant file for full context around the commented lines
2. Evaluate whether the suggestion is valid — consider correctness, relevance, and whether it could introduce regressions
3. Form your own recommendation: **agree**, **disagree**, or **partially agree** with reasoning

### Step 4: Present analysis

Print a detailed summary:

```markdown
## PR Feedback Analysis

Found **N** review comments on PR #<number>:

### 1. [file:line] — [short description of what's requested]
**Reviewer says:** [brief quote or paraphrase]
**Assessment:** [agree / disagree / partially agree]
**Reasoning:** [why you agree or disagree, any risks or trade-offs]
**Suggested fix:** [what you would do if approved, or why no change is needed]

### 2. ...
```

### Step 5: Ask for confirmation

Use AskUserQuestion to ask "Apply fixes?" with these options:

- **Apply all recommended** — apply only the ones assessed as agree/partially agree
- **Apply all** — fix everything regardless of assessment
- **Let me pick** — user specifies which ones to address

If "Let me pick", follow up with a multiSelect listing each comment by number.

### Step 6: Apply fixes

For each comment being addressed:

1. Apply the fix using the Edit tool
2. If a comment is unclear or conflicts with another, ask the user for clarification using AskUserQuestion instead of guessing

### Step 7: Commit and push

1. Check for staged or unstaged changes with `git status --short`. If there are no changes, inform the user that no files were modified and stop.
2. Use AskUserQuestion to ask "Ready to commit and push?" with options:
   - **Yes, commit and push** — proceed
   - **No, I want to review first** — stop here so the user can inspect the changes
3. If proceeding: stage all changed files
4. Create a single commit with message: `Address PR review feedback`
   - In the commit body, list each comment that was addressed
5. Push to the current branch
6. Print the PR URL so the user can verify
