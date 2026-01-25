# My dotfiles

## Installation

### Install GNU Stow

**MacOS**

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
