# Workflow

This repo is the foundation for agent-driven development. The rules below apply to every agent (and human) working in it.

## Core rules

- **Agents never commit to `main`.** `main` only changes via reviewed and merged pull requests.
- **Every task happens on its own feature branch, in its own git worktree.** Branches are named `agent/<task-name>`, and each lives in a separate worktree under `C:\dev\worktrees\ai-foundation-<task-name>`. This lets multiple agents (or sessions) work in parallel without stepping on each other's working directory or uncommitted state.
- **Changes go in via pull request.** When a task's work is ready, push the branch and open a PR with `gh pr create`. The repo owner reviews and merges — agents do not merge their own PRs or push directly to `main`.

## Starting a new task

Use `scripts/new-agent.ps1 -TaskName "<task-name>"` from the repo root. It creates the branch and worktree, and prints the path to open Claude Code in.

## Branch protection

`main` is (or should be) protected to require a pull request before merging. If branch protection isn't available (e.g. private repo on a free plan), treat the no-direct-commit rule as a convention enforced by discipline, not by GitHub.
