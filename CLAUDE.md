# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration built with **lazy.nvim** plugin manager. The configuration follows a modular architecture where each plugin lives in its own file under `lua/plugins/` and is automatically discovered by lazy.nvim.

## Architecture

### Entry Point Flow

1. **init.lua** - Bootstraps lazy.nvim, loads global settings, and triggers plugin discovery
2. **lua/vim-options.lua** - Global Vim settings, keymaps, and Python environment configuration
3. **lua/plugins/*.lua** - Individual plugin specifications loaded automatically by lazy.nvim

### Plugin Loading Pattern

Each file in `lua/plugins/` returns a Lua table (or array of tables) with this structure:
```lua
{
  "author/plugin-name",
  dependencies = { "required/plugin" },  -- Optional
  config = function()
    -- Setup code runs after plugin loads
  end,
  build = ":Command",  -- Optional: runs after install/update
  lazy = false,        -- Optional: set to false for immediate loading
  priority = 1000,     -- Optional: higher = loads earlier
}
```

### Python Environment Detection

The configuration auto-detects Python virtual environments in this order:
1. `$VIRTUAL_ENV/bin/python` (active virtualenv)
2. `./venv/bin/python` (project-local venv)
3. System `python3` or `python`

This is configured in `lua/vim-options.lua` via `vim.g.python3_host_prog`.

## Plugin Categories

### Language Server Protocol (LSP)
- **Files**: `lua/plugins/lsp-config.lua`
- **Servers installed**: lua_ls, marksman, pyright, yamlls, bashls, clangd
- **Tools**: mason.nvim (LSP installer), nvim-lspconfig (configuration)
- LSP servers are auto-installed by mason-lspconfig when referenced in configuration

### Completion
- **Files**: `lua/plugins/completions.lua`
- **Engine**: nvim-cmp with LSP source and LuaSnip snippet engine
- Snippets from friendly-snippets (VS Code compatible)

### Formatting & Linting
- **Files**: `lua/plugins/none-ls.lua`
- **Tools**: none-ls.nvim (null-ls replacement)
- **Configured sources**:
  - Lua: stylua
  - Python: black, isort
  - JavaScript: eslint
  - General: spell completion

### Debugging
- **Files**: `lua/plugins/debugging.lua`
- **Protocol**: nvim-dap (Debug Adapter Protocol)
- **Keymaps**:
  - `<Leader>dt` - Toggle breakpoint
  - `<Leader>dc` - Continue/start debugging
  - `<Leader>dx` - Terminate session
  - `<Leader>do` - Step over

### Navigation & Search
- **Files**: `lua/plugins/telescope.lua`, `lua/plugins/neo-tree.lua`
- **Keymaps**:
  - `<Leader>pf` - Find files (Telescope)
  - `<Leader>fg` - Live grep (Telescope)
  - `<C-n>` - Toggle Neo-tree file explorer

## Common Operations

### Adding a New Plugin
1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/my-plugin.lua`)
2. Return a plugin specification table:
   ```lua
   return {
     "author/plugin-name",
     config = function()
       require("plugin-name").setup({})
     end,
   }
   ```
3. Restart Neovim - lazy.nvim will auto-install the plugin

### Modifying Plugin Configuration
Edit the corresponding file in `lua/plugins/` and restart Neovim or run `:Lazy reload <plugin-name>`.

### Adding a Language Server
Edit `lua/plugins/lsp-config.lua`:
1. Add server name to mason-lspconfig's `ensure_installed` table
2. Add configuration: `lspconfig.server_name.setup({})`
3. Restart Neovim - mason will auto-install the server

### Testing Configuration Changes
Use the `dev` script to symlink your working directory:
```bash
./dev  # Creates symlink from current directory to ~/.config/nvim
```

## Key Configuration Files

- **init.lua** (16 lines) - Entry point, bootstraps lazy.nvim
- **lua/vim-options.lua** (55 lines) - Global settings, keymaps, Python setup
- **lazy-lock.json** - Plugin version lockfile (managed by lazy.nvim)

## Global Settings

- **Leader key**: `<Space>`
- **Tabs**: 2 spaces (expandtab)
- **Line numbers**: Relative numbering enabled
- **Window navigation**: `<C-k/j/h/l>` for moving between splits
- **Quick escape**: `jj` in insert/visual mode
- **Python formatting**: Auto-format on save via LSP

## Important Notes

- lazy.nvim auto-discovers all `.lua` files in `lua/plugins/` directory
- Plugin dependencies are automatically installed before the dependent plugin
- The catppuccin color scheme has `priority = 1000` to ensure it loads first
- Python LSP (pyright) integrates with the virtual environment detection
- none-ls.nvim is the maintained replacement for null-ls (no longer maintained)
