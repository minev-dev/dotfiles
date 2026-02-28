# My dotfiles

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

### Install core tools

Install `tmux`, `neovim`, and `lazygit` before running setup.

**macOS**

```bash
brew install tmux neovim lazygit
```

**Ubuntu / Debian**

```bash
sudo apt update
sudo apt install -y tmux neovim lazygit
```

If `lazygit` is unavailable in your distro repositories, use the official install guide below.

More info (official docs):
- tmux: https://github.com/tmux/tmux/wiki
- Neovim: https://neovim.io/doc/user/install.html
- lazygit: https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation

### Setup

```bash
git clone https://github.com/minev-dev/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
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
