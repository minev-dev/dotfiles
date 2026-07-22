# My dotfiles

hello world

## Hello world records

- 1) Hello world from the terminal.
- 2) Hello world from tmux.
- 3) Hello worldworld from Git.
- 4) Hello worldworld from automation.
- 5) Hello world from the README update.
- 8) Hello world from line 7.
- 7) Hello world from line 7.
- 8) Hello world from line 8.
- 9) Hello world from line 9.
## Installation

### Install GNU Stow

**macOS**

```bash
brew install stow
```

**Ubuntu / Debian**

```bash
sudo apt install stow
```

### Setup

```bash
git clone https://github.com/minev-dev/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```

### Install core tools

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

### Install AI agents

```bash
brew install codex gemini-cli
curl -fsSL https://claude.ai/install.sh | bash
```

### Linux-specific

#### `keyd`

Remapping linux key binging to mirrot MacOS

##### Link config to `/etc/keyd`

```bash
sudo ln -s ~/dotfiles/.config/keyd /etc/keyd
```

##### Install and enable `keyd`

```
sudo apt install keyd
sudo systemctl enable keyd --now
```

More info - https://github.com/rvaiya/keyd

## Post-installation

### Nvim

#### Install all LSP servers

```
:MasonInstallAll
```

#### Install additional binaries

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
