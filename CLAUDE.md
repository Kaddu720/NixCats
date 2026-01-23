# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix-based Neovim configuration using nixCats for dependency management and lze (lazy-loading engine) for plugin management. The configuration emphasizes performance optimization and uses a modular structure for LSP configurations.

**Important**: This configuration is actively used within Claude Code. When making changes, prioritize improvements that enhance the Claude Code experience, such as:
- LSP configurations that work well with AI-assisted coding workflows
- Performance optimizations that reduce latency during rapid file operations
- Diagnostic and linting configurations that provide clear, actionable feedback
- Keybindings and plugins that complement AI pair programming

**Hardware Note**: The user uses a split keyboard. Ergonomic considerations matter - prefer left-hand number keys (1-5) for navigation counts when possible. Line numbers use a custom "comfy" display that converts relative numbers to only use digits 1-5 (bijective base-5).

**Philosophy**: Neovim should focus on editing and managing files only. Avoid plugins that manage external tools (git, kubectl, docker, etc.) - the user prefers to use those tools directly in the terminal. LSPs and syntax highlighting are welcome; tool wrappers are not.

**Role**: The user is a senior SRE primarily managing Kubernetes clusters. Relevant file types include YAML (K8s manifests, Helm charts, Kustomize), Terraform, Dockerfiles, and shell scripts.

## Build System

This configuration uses Nix flakes for reproducible builds and dependency management:

```bash
# Build the default nvim package
nix build

# Enter development shell with nvim-dev package (unwrapped config for testing)
nix develop

# Run the built nvim directly
nix run

# Update flake inputs
nix flake update
```

The configuration uses direnv (`.envrc` contains `use flake`) to automatically load the development environment when entering the directory.

## Package Variants

Two package configurations are defined in `flake.nix`:
- `nvim`: Production package with `wrapRc = true` (default)
- `nvim-dev`: Development package with `wrapRc = false` for testing configuration changes

## Testing and Linting

```bash
# Lua linting with Selene
selene lua/

# Format Lua code
stylua lua/ lsp/ init.lua

# Format Nix code
alejandra flake.nix
```

Configuration for Selene is in `selene.toml`.

## Architecture

### Entry Point Flow

1. `init.lua` - Entry point with startup time measurement and performance settings
2. `lua/config/init.lua` - Loads core configuration modules in order:
   - `config.options` - Neovim options and performance settings
   - `config.keymaps` - Global keymaps
   - `config.colorscheme` - Colorscheme setup
   - `config.language` - Language-specific LSP enablement and settings
   - `plugins` - Plugin loading via lze

### Plugin Architecture

Plugins are managed by `lze` (lazy-loading engine). All plugins except `lze` itself are lazy-loaded using various triggers:
- Event-based loading (`InsertEnter`, `LspAttach`, `DeferredUIEnter`)
- Filetype-based loading (`ft = "markdown"`)
- Command or key-based loading

Plugin configurations are modular, with each plugin in its own file under `lua/plugins/`.

**Important**: When adding or removing plugins, you must update TWO places:
1. `lua/plugins/<plugin-name>.lua` - The plugin's configuration file
2. `lua/plugins/init.lua` - The plugin must be registered in the `require("lze").load()` call

The `init.lua` file loads all plugin specs by requiring each plugin file.

### LSP Configuration

LSP servers are configured in separate files under `lsp/` directory:
- Each language server has its own configuration file (e.g., `lsp/pyright.lua`, `lsp/nixd.lua`)
- LSP servers are enabled per-language in `lua/config/language.lua` using `vim.lsp.enable()`
- Language-specific settings (indentation, etc.) are set via FileType autocmds in `language.lua`

Example LSP enablement:
```lua
-- In lua/config/language.lua
vim.lsp.enable({ "pyright", "ruff" })
```

The LSP configuration files return a table with server settings that get loaded by Neovim's LSP client.

### Formatting and Linting

Formatting and linting are handled by `none-ls.nvim` (null-ls fork) configured in `lua/plugins/none-ls.lua`:
- Formatters: stylua (Lua), alejandra (Nix), shfmt (Bash)
- Linters: selene (Lua), mypy (Python), deadnix (Nix), yamllint (YAML), dotenv_linter (env files), vale (Markdown)
- Format keymap: `<leader>fm`

### Completion

Uses `blink-cmp` for completion with multiple sources:
- LSP completions
- Path completions
- Snippets (friendly-snippets)
- Buffer completions
- Ecolog (environment variable completions)

Performance optimizations include limited completion items per source and delayed documentation display.

### Language Support

Configured languages with their LSP servers:
- **Lua**: lua-language-server (luals)
- **Python**: pyright (completion only, type checking disabled), ruff (linting/formatting), mypy (type checking via none-ls)
- **Nix**: nil_ls, nixd
- **Markdown**: ltex-ls-plus (grammar/spell checking)
- **Terraform**: terraform-ls
- **YAML**: yaml-language-server (with K8s, GitHub Actions, Docker Compose, Helm, Kustomize, ArgoCD schemas)
- **Bash**: bash-language-server
- **Docker**: dockerfile-language-server
- **Helm**: helm_ls (Go template support in Helm charts)

Python uses a division of responsibility: pyright for completions, ruff for linting/formatting, mypy for type checking.

### Obsidian Integration

The configuration includes Obsidian vault integration with workspace detection based on hostname:
- Home machines (Home-Box, Mobile-Box): Default to Second_Brain workspace
- Work machines: Default to Work_Brain workspace
- Workspace paths differ between home and work machines
- Custom keymaps under `<leader>o` prefix for Obsidian commands
- Uses fzf-lua for file picking

## Key Technologies

- **nixCats**: Nix-based Neovim distribution framework
- **lze**: Lazy-loading plugin manager (successor to lazy.nvim)
- **Treesitter**: Syntax highlighting and code navigation
- **fzf-lua**: Fuzzy finder for files, text, and more
- **oil.nvim**: File explorer
- **flash.nvim**: Quick navigation
- **gitsigns**: Git integration

## Performance Considerations

This configuration is heavily optimized for startup time and runtime performance:
- Shada file disabled during startup, loaded after 100ms
- Limited completion items per source
- LSP diagnostic mode set to `openFilesOnly` where applicable
- Increased debounce times (e.g., 300ms for pyright)
- `synmaxcol` limited to 120 columns
- Single file support disabled for pyright
- Lazy-loading for all plugins

## Common Keymaps

Leader key: `<Space>`

### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>fm` - Format buffer

### Navigation
- `<C-d>/<C-u>` - Page down/up (centered)
- `n/N` - Next/previous search result (centered)

### Obsidian
- `<leader>os` - Sync vault
- `<leader>od` - Open daily notes
- `<leader>ot` - Insert template
- `<leader>on` - New note
- `<leader>ob` - Show backlinks
- `<leader>ow` - Switch workspace
- `<leader>fo` - Find Obsidian file
- `<leader>ft` - Find Obsidian tags

## Nix Flake Structure

Dependencies are defined in `flake.nix`:
- `categoryDefinitions.lspsAndRuntimeDeps`: External tools (LSPs, formatters, linters)
- `categoryDefinitions.startupPlugins`: Plugins loaded at startup (only lze)
- `categoryDefinitions.optionalPlugins`: Lazy-loaded plugins
- Custom plugins from GitHub are added as flake inputs (e.g., ecolog, obsidian)
