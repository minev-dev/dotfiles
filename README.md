# My dotfiles

Repository layout and onboarding guidance for terminal workflows (shell, tmux, Neovim, and keyd).

## Module map

- **Neovim**: `.config/nvim/`
  - NvChad-based configuration, plugin setup, and language tooling.
- **Ghostty**: `.config/ghostty/config`
  - Terminal defaults and keybinding parity.
- **tmux**: `.tmux.conf`
  - Session behavior, copy-mode preferences, OSC52 clipboard behavior, and UX shortcuts.
- **lazygit**: `.config/lazygit/config.yml`
  - Git terminal UI settings and keymaps.
- **keyd (Linux)**: `.config/keyd/default.conf`
  - Remaps Linux modifier keys to macOS-style behavior for shell/tmux workflows.

## Install GNU Stow

**macOS**

```bash
brew install stow
```

**Ubuntu / Debian**

```bash
sudo apt install stow
```

## Setup

```bash
git clone https://github.com/minev-dev/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```

`stow .` deploys the files and symlinks configuration for any managed module.

## Install core tools

**macOS**

```bash
brew install tmux neovim lazygit starship gh glab
```

**Ubuntu / Debian**

```bash
curl -sSL "https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository" | sudo bash

sudo apt update
sudo apt install -y tmux neovim lazygit starship gh glab
```

If `lazygit` is unavailable in your distro repositories, use the official install guide below.

More info (official docs):
- tmux: https://github.com/tmux/tmux/wiki
- Neovim: https://neovim.io/doc/user/install.html
- lazygit: https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation

### Install `Rust`

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Install `uv`

Install `uv` (official docs): https://docs.astral.sh/uv/getting-started/installation/

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Install `pre-commit`

```bash
uv tool install pre-commit
```

## AI agent tooling (optional)

```bash
brew install codex gemini-cli
curl -fsSL https://claude.ai/install.sh | bash
```

## Linux-specific setup: keyd

Remapping Linux key behavior to mirror macOS for shell/tmux flow.

### Link config to `/etc/keyd`

```bash
sudo ln -s ~/dotfiles/.config/keyd /etc/keyd
```

### Install and enable `keyd`

```bash
sudo apt install keyd
sudo systemctl enable keyd --now
```

More info - https://github.com/rvaiya/keyd

## Post-installation

### Neovim

#### Install all LSP servers

```vim
:MasonInstallAll
```

#### Install additional binaries

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)

## Shell onboarding and maintenance checklist

- Restart or reopen your shell after stowing so terminal apps read symlinks.
- Verify module files exist in expected locations (`ls .config/nvim .config/ghostty .config/keyd .config/lazygit`).
- Use `git pull` then `stow .` after updates to refresh installed symlinks.
- Keep behavior changes scoped to:
  - `.tmux.conf`
  - `.config/ghostty/config`
  - `.config/keyd/default.conf`
  - `.config/nvim/init.lua`
  - `.config/nvim/lua/`
  - `.config/lazygit/config.yml`
- Run formatting/linting from each module’s toolchain only when you edit behavior files.

## Planned refactor touch list

- `.tmux.conf`
- `.config/ghostty/config`
- `.config/keyd/default.conf`
- `.config/lazygit/config.yml`
- `.config/nvim/README.md`
- `.config/nvim/init.lua`
- `.config/nvim/lua/*`

## Post-refactor validation checklist

- [ ] macOS: verify tmux startup, Neovim plugin load, and Ghostty launch after running `stow .`.
- [ ] macOS: confirm paste/OSC52 behavior in tmux and Neovim sessions.
- [ ] Linux: verify `/etc/keyd` symlink and `systemctl status keyd` are healthy.
- [ ] Linux: validate shell/tmux keybinding parity and fallback behavior when running SSH.
- [ ] All: check `lazygit` opens and uses the repo config with no unknown merge markers.
