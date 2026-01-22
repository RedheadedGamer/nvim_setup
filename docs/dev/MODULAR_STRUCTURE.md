# Neovim Modular Configuration Structure

## Visual Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         init.lua (Root)                          │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  config/options, config/keymaps, config/autocmds         │   │
│  │  Bootstrap lazy.nvim                                     │   │
│  │  Load plugins via require("plugins")                     │   │
│  │  Load theme via require("config.theme").init()           │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│              lua/plugins/init.lua (Plugin Loader)                │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  Load and merge all plugin modules:                      │   │
│  │  • ui/* → themes, snacks, utilities                      │   │
│  │  • editor/* → treesitter, mini.nvim modules              │   │
│  │  • git/* → gitsigns integration                          │   │
│  │  • lsp/* → LSP configuration                             │   │
│  │  • dev/* → formatting, linting, debugging                │   │
│  │  • lang/* → C/C++, Java, LaTeX                           │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
                              ↓
        ┌─────────────────────┴─────────────────────┐
        ↓                                           ↓
┌──────────────────┐                    ┌──────────────────┐
│   UI Plugins     │                    │  Editor Plugins   │
│  (3 files)       │                    │  (4 files)        │
├──────────────────┤                    ├──────────────────┤
│ • themes.lua     │                    │ • treesitter.lua │
│ • snacks.lua     │                    │ • mini-text.lua  │
│ • utilities.lua  │                    │ • mini-ui.lua    │
│                  │                    │ • mini-nav.lua   │
│ 15+ themes       │                    │ 20+ mini plugins │
│ Dashboard        │                    │ Syntax highlight │
│ Which-key        │                    │ Text objects     │
│ Telescope        │                    │ File explorer    │
└──────────────────┘                    └──────────────────┘
        ↓                                           ↓
┌──────────────────┐                    ┌──────────────────┐
│   Git Plugins    │                    │   LSP Plugins     │
│  (1 file)        │                    │  (1 + 3 configs) │
├──────────────────┤                    ├──────────────────┤
│ • gitsigns.lua   │                    │ • lspconfig.lua  │
│                  │                    │   + servers.lua  │
│ Git signs        │                    │   + keymaps.lua  │
│ Hunk navigation  │                    │   + diag.lua     │
│ Diff view        │                    │                  │
│                  │                    │ Mason            │
│                  │                    │ nvim-lspconfig   │
│                  │                    │ nvim-cmp         │
│                  │                    │ Trouble          │
└──────────────────┘                    └──────────────────┘
        ↓                                           ↓
┌──────────────────┐                    ┌──────────────────┐
│  Dev Tools       │                    │ Lang-Specific    │
│  (3 files)       │                    │  (3 files)       │
├──────────────────┤                    ├──────────────────┤
│ • formatting.lua │                    │ • c-cpp.lua      │
│ • linting.lua    │                    │ • java.lua       │
│ • debugging.lua  │                    │ • latex.lua      │
│                  │                    │                  │
│ conform.nvim     │                    │ CMake tools      │
│ nvim-lint        │                    │ clangd ext       │
│ nvim-dap         │                    │ nvim-jdtls       │
│ dap-ui           │                    │ vimtex           │
└──────────────────┘                    └──────────────────┘
```

## File Size Comparison

### Before: Monolithic
```
lua/plugins/init.lua ████████████████████████████████ 2832 lines
```

### After: Modular (Top 5 files)
```
lua/plugins/ui/snacks.lua      ███████████████ 381 lines
lua/plugins/ui/utilities.lua   ██████████████  361 lines
lua/plugins/ui/themes.lua      ████████████    251 lines
lua/plugins/lsp/lspconfig.lua  ████████████    222 lines
lua/plugins/editor/mini-ui.lua ████████        161 lines
... (11 more smaller files)
```

## Benefits at a Glance

| Aspect | Before | After |
|--------|--------|-------|
| Files | 1 massive file | 20 focused files |
| Largest file | 2832 lines | 381 lines |
| Average file | N/A | 122 lines |
| Find plugin | Search 2832 lines | Check category folder |
| Add plugin | Edit at line X | Add to category file |
| Remove plugin | Search & delete | Delete from category |
| Team work | Merge conflicts | Parallel edits |
| Understanding | Read everything | Read what you need |
| Debugging | Disable all or none | Disable by category |
| Maintenance | One giant file | Modular components |

## Loading Flow

1. **Neovim starts** → Loads `init.lua`
2. **init.lua** → Loads core config (options, keymaps, autocmds)
3. **init.lua** → Bootstraps lazy.nvim
4. **init.lua** → Calls `require("plugins")` 
5. **plugins/init.lua** → Loads all plugin modules
6. **Each module** → Returns table of plugin specs
7. **Plugin loader** → Merges all tables into one
8. **lazy.nvim** → Receives merged plugin table
9. **lazy.nvim** → Installs/configures plugins
10. **init.lua** → Initializes theme system

## Quick Reference

### Where to find...

| What | Location |
|------|----------|
| Add new theme | `lua/plugins/ui/themes.lua` |
| Configure snacks | `lua/plugins/ui/snacks.lua` |
| Add LSP server | `lua/config/lsp/servers.lua` |
| Change LSP keys | `lua/config/lsp/keymaps.lua` |
| Add formatter | `lua/plugins/dev/formatting.lua` |
| Add linter | `lua/plugins/dev/linting.lua` |
| Configure DAP | `lua/plugins/dev/debugging.lua` |
| Add C/C++ tool | `lua/plugins/lang/c-cpp.lua` |
| General options | `lua/config/options.lua` |
| General keys | `lua/config/keymaps.lua` |
| Autocommands | `lua/config/autocmds.lua` |
| Theme system | `lua/config/theme.lua` |
| Java config | `ftplugin/java.lua` |

