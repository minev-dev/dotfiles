# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

> **Note to Agent:** Always update this file if new architectural patterns, tooling standards, or critical constraints are introduced.

## Overview

Personal dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Targets both **Linux** and **macOS** — all changes must be cross-platform compatible unless explicitly scoped to one OS (e.g., `keyd` is Linux-only).

## Setup

```bash
git clone https://github.com/minev-dev/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```

Stow symlinks everything from this repo into `$HOME`. File paths here mirror the home directory structure (e.g., `.config/nvim/` becomes `~/.config/nvim/`).

## Architecture

### Neovim (NvChad v2.5)

- **Base framework**: [NvChad](https://nvchad.com/) v2.5, loaded via lazy.nvim.
- **Plugin manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) — configured in `lua/configs/lazy.lua`.
- **Key files**:
  - `lua/plugins/init.lua` — main plugin registry (add new plugins here).
  - `lua/plugins/nvimtree.lua` — NvimTree overrides (separate file).
  - `lua/configs/*.lua` — per-plugin setup logic referenced from `plugins/init.lua`.
  - `lua/mappings.lua` — all custom keymaps + TextYankPost autocmd for OSC52 clipboard.
  - `lua/chadrc.lua` — NvChad UI/theme overrides (theme: `zenburn`).
  - `lua/options.lua` — vim options; clipboard is explicitly set to `""` (handled via OSC52).
  - `init.lua` — bootstrap, cmp filter, NvimTree auto-open on startup.
- **Lua style**: enforced by `.config/nvim/.stylua.toml` — 2-space indent, double quotes, 120 col width, `call_parentheses = "None"`.
- **Formatting on save**: `conform.nvim` handles format-on-save (lua→stylua, python→ruff, terraform→terraform_fmt, markdown→prettier).
- **LSP servers**: configured in `lua/configs/lspconfig.lua` via `vim.lsp.enable()` — html, cssls, pyright, marksman, terraformls. Rust uses `rustaceanvim` (separate plugin, not in lspconfig).
- **Clipboard**: Uses `nvim-osc52` for clipboard via OSC52 escape sequences. This is critical for SSH/remote sessions. Do not switch to xclip/pbcopy.

### Ghostty Terminal

- Single config file: `.config/ghostty/config`.
- Keybindings duplicate both `super+` (macOS) and `ctrl+` (Linux via keyd) variants for cross-platform parity.

### keyd (Linux Only)

- Config: `.config/keyd/default.conf`.
- Remaps left Alt (thumb key) to act as macOS Command, making `Alt+C`→`Ctrl+Insert` (copy), `Alt+V`→`Shift+Insert` (paste), etc.
- Must be symlinked to `/etc/keyd` and enabled via systemd.
- Do not configure keyd for macOS.

### Tmux

- `.tmux.conf` — minimal config: vi-mode, OSC52 clipboard (`set-clipboard on`), passthrough enabled.

## Tooling & Standards

| Category      | Tool              | Constraint                                                                         |
| :------------ | :---------------- | :--------------------------------------------------------------------------------- |
| **Lua**       | `stylua`          | formatting (see `.config/nvim/.stylua.toml`)                                       |
| **Python**    | `ruff`, `pyright` | formatting/linting, LSP                                                            |
| **Git**       | `lazygit`         | Preferred UI within Neovim                                                         |
| **Clipboard** | `osc52`           | **CRITICAL**: Maintain for SSH/remote sessions. Never rely solely on xclip/pbcopy. |

## Constraints

- **OSC52 clipboard is critical**: Neovim, tmux, and Ghostty all rely on OSC52 for clipboard. Never replace with platform-specific clipboard tools.
- **Do not modify NvChad core files**: Only modify files in the custom directory structure (`lua/plugins/`, `lua/configs/`, `lua/mappings.lua`, `lua/chadrc.lua`, `lua/options.lua`).
- **Cross-platform by default**: When adding shell commands or paths, ensure they work on both Linux and macOS.
- **Read before writing**: Always read the specific config file before making changes to understand existing overrides.
- **Do not assume dependencies**: Do not assume external tools (like `ripgrep`, `fd`, `npm`) are installed unless verified.

## Git Conventions

- When preparing a commit, gather context in a single tool call by chaining independent commands: `git status && git diff && git log -n 5 --format="---%n%B"`. This provides working tree status, staged/unstaged changes, and recent commit history for style consistency — all in one invocation.
- Follow the "commit title and description" style:
  - The first line should be a concise summary (the "title") in present simple tense (e.g., "Fix cursor offset" not "Fixed cursor offset").
  - Use a blank line between the title and the body.
  - The body (the "description") should provide more detail on _why_ and _how_ in present simple tense. It is not needed when the title is self-explanatory.
- Do not use conventional commit prefixes (e.g., `feat:`, `fix:`).
- Do not add `Co-Authored-By` trailers or any AI attribution to commit messages.
