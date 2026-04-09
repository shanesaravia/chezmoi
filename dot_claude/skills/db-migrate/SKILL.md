---
name: db-migrate
description: Safely manage Flask-Migrate database migrations — generate, review, apply, or rollback. Use when making model changes that require a migration.
argument-hint: "[generate|upgrade|downgrade|history]"
disable-model-invocation: true
allowed-tools: Bash(poetry run flask db:*), Bash(poetry run flask:*), Bash(git diff:*), Bash(git status:*), Bash(git log:*), AskUserQuestion, Read
---

## Context

- Current branch: !`git branch --show-current`
- Recent migrations: !`poetry run flask db history --indicate-current 2>/dev/null | head -10`

$ARGUMENTS

## Your task

If `$ARGUMENTS` clearly indicates an operation (`generate`, `upgrade`, `downgrade`, `history`), proceed to that step directly. Otherwise, ask the user using AskUserQuestion with these options:

- **Generate** — create a new migration from model changes
- **Upgrade** — apply pending migrations to the database
- **Downgrade** — roll back the last migration
- **History** — view migration history

---

### Generate

1. Show the user the current model changes with `git diff -- models/` so they can confirm what will be detected
2. Ask for a short migration message using AskUserQuestion (free text, e.g. "add icon to categories")
3. Run: `poetry run flask db migrate -m "<message>"`
4. Read the generated migration file from `migrations/versions/`
5. Present the migration to the user and highlight any concerns:
   - Dropped columns or tables
   - Non-nullable columns added to existing tables
   - Missing `down_revision` or empty `upgrade()`/`downgrade()` functions
6. Ask: "Apply this migration?" via AskUserQuestion with options **Yes — run upgrade**, **No — review manually**
7. If yes, run upgrade (see below)

---

### Upgrade

1. Show pending migrations: `poetry run flask db heads` and `poetry run flask db current`
2. Remind the user to ensure a database backup exists for production
3. Ask: "Proceed with upgrade?" via AskUserQuestion — **Yes** or **No**
4. If yes: `poetry run flask db upgrade`
5. Confirm current state: `poetry run flask db current`

---

### Downgrade

1. Show current migration: `poetry run flask db current`
2. Show what will be rolled back: `poetry run flask db history --indicate-current | head -5`
3. Warn: downgrade may result in data loss if columns or tables are dropped
4. Ask: "Confirm downgrade?" via AskUserQuestion — **Yes** or **No**
5. If yes: `poetry run flask db downgrade`
6. Confirm current state: `poetry run flask db current`

---

### History

Run `poetry run flask db history --indicate-current` and display the output.

---

### Rules

- Never run `upgrade` or `downgrade` without user confirmation
- Always read and surface the generated migration file before applying it
- Flag any destructive operations (dropped columns/tables, non-nullable additions) before proceeding
