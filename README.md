# meza-profile-zsh

Personal dotfiles and shell profile for macOS + zsh.

## Setup

```bash
# Clone to home directory
git clone git@github.com:mezawebdev/meza-profile-zsh.git ~/meza-profile-zsh

# Source the profile in your ~/.zshrc
echo 'source ~/meza-profile-zsh/.zsh-profile' >> ~/.zshrc

# Create .local-profile for machine-specific secrets/env vars
touch ~/meza-profile-zsh/.local-profile

# Set up Neovim config (symlinks nvim/ to ~/.config/nvim)
~/meza-profile-zsh/bin/setup-nvim
```

## What's Included

| Directory | Description |
|-----------|-------------|
| `bin/` | CLI utilities added to PATH |
| `claude/` | Claude Code config (agents, commands, plugins, settings) |
| `nvim/` | Neovim config (LazyVim) |
| `lazygit/` | Lazygit config with AI commit generator (`<C-a>`) |
| `warp/` | Warp terminal themes and keybindings |
| `glow/` | Glow markdown renderer theme |

## CLI Utilities

| Command | Description |
|---------|-------------|
| `cmux-dispatch-claude` | Launch Claude Code sessions in cmux tabs |
| `new-worktree` / `nwt` | Create git worktrees with auto-setup (copies `.env*`, runs `npm i`) |
| `ai_commit_generator` | Generate commit messages from staged diffs via Gemini API |
| `compress_to_webp` | Batch convert images to WebP using ffmpeg |
| `setup-nvim` | Symlink Neovim config to `~/.config/nvim` |

## Dependencies

- [Lazygit](https://github.com/jesseduffield/lazygit)
- [delta](https://github.com/dandavella/delta) (git pager)
- [Glow](https://github.com/charmbracelet/glow)
- [terminal-notifier](https://github.com/julienXX/terminal-notifier)
- [ffmpeg](https://ffmpeg.org/) (for `compress_to_webp`)
- [Claude Code](https://claude.ai/code)
- Python 3.10+
