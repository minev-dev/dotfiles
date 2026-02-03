# Gemini Context & Configuration

This file documents the architectural patterns, conventions, and constraints for this `dotfiles` repository. It serves as a guide for the agent to safely modify and maintain the configuration.

> **Note to Agent:** Always update this file if new architectural patterns, tooling standards, or critical constraints are introduced.

## Project Scope
- **Purpose**: Personal configuration files (dotfiles).
- **Supported Platforms**: **Linux** and **macOS**.
- **Critical Constraint**: Ensure all changes are compatible with both platforms unless explicitly scoped to one (e.g., `keyd` for Linux).

## Component Architecture

### 1. NeoVim (NvChad)
- **Base**: [NvChad](https://nvchad.com/).
- **Location**: `.config/nvim/`.
- **Structure**:
  - `lua/plugins/init.lua`: Main registry for user plugins.
  - `lua/configs/*.lua`: Setup logic for specific plugins (referenced by `plugins/init.lua`).
  - `lua/mappings.lua`: General keymaps.
  - `lua/chadrc.lua`: NvChad UI/Theme overrides.
- **Convention**:
  - **Do not** modify generated files or core NvChad files outside of the `custom` directory structure.
  - **Styling**: Strictly follow `.stylua.toml` (2 spaces, double quotes).
  - **LSP/Formatting**: Prefer `conform.nvim` for formatting and `nvim-lspconfig` for server setup.

### 2. Terminal (Ghostty)
- **Location**: `.config/ghostty/config`.
- **Strategy**: Single config file targeting cross-platform compatibility where possible.
- **Keybindings**: Mimics macOS shortcuts (Cmd+C/V/T/W) natively or via remapping.

### 3. Key Remapping (Linux Only)
- **Tool**: `keyd`.
- **Location**: `.config/keyd/default.conf`.
- **Purpose**: Emulates macOS modifier behavior on Linux (Thumb key as Command/Super).
- **Agent Note**: Do not attempt to configure `keyd` on macOS systems.

### 4. Tmux
- **Location**: `.tmux.conf`.
- **Style**: Vi-mode enabled.
- **Clipboard**: Uses `osc52` (via `set-clipboard on`) for remote capability.

## Tooling & Standards

| Category | Tool | Constraint |
| :--- | :--- | :--- |
| **Lua** | `stylua` | formatting |
| **Python** | `ruff`, `pyright` | formatting/linting, LSP |
| **Git** | `lazygit` | Preferred UI within Neovim |
| **Clipboard** | `osc52` | **CRITICAL**: Maintain `osc52` support for SSH/remote sessions. Avoid relying solely on local system providers (xclip/pbcopy) in Neovim. |

## Workflow Rules
1. **Read First**: Always read the specific config file (e.g., `lua/mappings.lua`) before making changes to understand existing overrides.
2. **Cross-Platform**: When adding shell commands or paths, verify they are valid for both Linux and macOS zsh/bash environments.
3. **Dependencies**: Do not assume external tools (like `ripgrep`, `fd`, `npm`) are installed unless verified.