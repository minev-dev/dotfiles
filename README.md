# My dotfiles

## Installation

```bash
git clone https://github.com/minev-dev/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```

### Linux-specific

```bash
sudo ln -s ~/dotfiles/.config/keyd /etc/keyd
```

## Post-installation

### Nvim

#### Install all LSP servers

```
:MasonInstallAll
```

#### Install additional binaries

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
