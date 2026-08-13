# My NeoVim config

# File layout

- `init.lua` - bootstrap + lazy setup + startup hooks.
- `lua/options.lua` - base option overrides, including OSC52 contract.
- `lua/mappings.lua` - keymap composition for editor, OSC52, and terminals.
- `lua/configs/` - per-plugin setup for LSP, formatting, tree, and tree/signing behavior.
- `lua/plugins/` - plugin registration and plugin-local setup.

# Credits

1. Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
