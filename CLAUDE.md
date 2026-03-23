# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

A personal dotfiles/profile repo for macOS + zsh. It contains shell configuration, CLI utilities, editor configs (Neovim/LazyVim, Warp, Lazygit), and Claude Code configuration (agents, commands, settings, plugins). It is sourced from `~/meza-profile-zsh` and sets `CLAUDE_CONFIG_DIR` to `~/meza-profile-zsh/claude`.

## Key Paths

- `.zsh-profile` - Main shell profile (aliases, functions, PATH). Sourced via `source ~/meza-profile-zsh/.zsh-profile`.
- `.local-profile` - Machine-local secrets and env vars (gitignored). Sourced at the end of `.zsh-profile`.
- `bin/` - Executable scripts added to PATH.
- `claude/` - Claude Code config dir (`CLAUDE_CONFIG_DIR`). Only `claude/settings.json`, `claude/agents/`, and `claude/commands/` are tracked; everything else is gitignored.
- `nvim/` - LazyVim-based Neovim config. Symlinked to `~/.config/nvim` via `bin/setup-nvim`.
- `lazygit/config.yml` - Lazygit config (referenced by `LG_CONFIG_FILE` env var). Includes a `<C-a>` custom command that runs `ai_commit_generator`.
- `warp/` - Warp terminal keybindings and themes.
- `glow/theme.json` - Glow markdown renderer theme.

## CLI Utilities (bin/)

- `cmux-dispatch-claude` - Launches Claude Code sessions in new cmux tabs. Supports single prompt, file input (`-f`), batch mode (`-b <dir>`), custom working dir (`-d`), and tab naming (`-n`).
- `new-worktree` - Python script to create git worktrees at `~/Worktrees/{repo}-{branch}-{name}`. Auto-copies `.env*`, `.nvmrc`, `.npmrc` into the new worktree and runs `nvm use && npm i`. Shell wrapper `nwt` calls this and `cd`s into the result.
- `ai_commit_generator` - Python script that generates commit messages via Gemini API from staged diffs, copies to clipboard, and shows macOS notification. Integrated into Lazygit via `<C-a>`.
- `compress_to_webp` - Batch image converter using ffmpeg. Usage: `compress_to_webp -i <dir> [-o <dir>] [-w <width>] [-q <quality>]`.
- `setup-nvim` - Creates symlink from `nvim/` to `~/.config/nvim`.

## Claude Code Configuration

### Agents (`claude/agents/`)
Custom agent definitions: `atomic-design-architect`, `e2e-testing-expert`, `spec-maintainer`, `testing-expert`, `typescript-expert`, `worker`.

### Commands (`claude/commands/`)
- `/cmux-dispatch` - Dispatches prompts to new cmux tabs via `cmux-dispatch-claude`.
- `/parallel-orchestrator` - Coordinates parallel work: analyzes tasks, creates assignments in `.claude/parallel/`, tracks worker status.
- `/parallel-worker <name>` - Worker agent that reads assignment from `.claude/parallel/<name>/task.md`, creates worktree via `nwt`, updates status files. Human-in-the-loop: never commits or pushes without approval.

### Plugins (settings.json)
Enabled: `superpowers`, `typescript-lsp`, `code-simplifier`, `playwright`, `frontend-design`.

### Hooks
- **Stop hook**: Sends macOS notification via `terminal-notifier` when Claude finishes.

## Shell Aliases & Functions

Key aliases defined in `.zsh-profile`:
- `zshrc` / `zshrco` / `zshrc-go` / `zshrc-local` - Edit/navigate profile files
- `refresh` - Re-source `.zsh-profile`
- `save` - Quick `git add . && commit "checkpoint" && push`
- `nwt <name>` - Create and cd into a new git worktree
- `lg` - Lazygit
- `gpsoc` - Push current branch to origin
- Docker Compose: `dc-rs`, `dc-rsd`, `dc-dw`, `dc-up`, `dc-upd`, `dc-it <container>`

## Working With This Repo

- After editing `.zsh-profile`, run `refresh` (or `source ~/meza-profile-zsh/.zsh-profile`) to apply changes.
- Scripts in `bin/` must be executable (`chmod +x`).
- Never commit `.local-profile` - it contains secrets and is gitignored.
- The `claude/` directory is mostly gitignored except `settings.json`, `agents/`, and `commands/`.
