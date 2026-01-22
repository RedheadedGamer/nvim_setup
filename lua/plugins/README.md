# Modular Neovim Plugin Configuration

This directory contains the modularized plugin configuration for the nvim_setup repository. The plugins are organized into logical categories for easier maintenance and understanding.

## Directory Structure

```
lua/plugins/
├── init.lua                  # Main plugin loader (imports all modules)
│
├── ui/                       # UI Enhancement Plugins
│   ├── themes.lua           # Colorscheme plugins (15+ themes)
│   ├── snacks.lua           # Snacks.nvim (dashboard, notifications, etc.)
│   └── utilities.lua        # UI utilities (which-key, telescope, dressing)
│
├── editor/                   # Editor Enhancement Plugins
│   ├── treesitter.lua       # Treesitter and syntax highlighting
│   ├── mini-text.lua        # Mini.nvim text manipulation plugins
│   ├── mini-ui.lua          # Mini.nvim UI plugins
│   └── mini-navigation.lua  # Mini.nvim navigation and utility plugins
│
├── lsp/                      # LSP Configuration
│   └── lspconfig.lua        # Mason, nvim-lspconfig, nvim-cmp, trouble
│
├── git/                      # Git Integration
│   └── gitsigns.lua         # Gitsigns and mini.diff
│
├── dev/                      # Development Tools
│   ├── formatting.lua       # Code formatting (conform.nvim)
│   ├── linting.lua          # Code linting (nvim-lint)
│   └── debugging.lua        # Debugging (nvim-dap, dap-ui)
│
└── lang/                     # Language-Specific Plugins
    ├── c-cpp.lua            # C/C++ tools (cmake-tools, clangd_extensions)
    ├── java.lua             # Java support (nvim-jdtls)
    └── latex.lua            # LaTeX support (vimtex)
```

## LSP Configuration Files

The LSP configuration is further modularized into separate files:

```
lua/config/lsp/
├── servers.lua      # LSP server configurations
├── keymaps.lua      # LSP keybindings
└── diagnostics.lua  # Diagnostic configuration
```

## Plugin Categories

### UI Plugins (`ui/`)
- **themes.lua**: 15+ colorscheme plugins with transparency support
- **snacks.lua**: All-in-one plugin for dashboard, notifications, scroll animations, terminal, git integration, zen mode, and more
- **utilities.lua**: Which-key (keybinding popup), Telescope (fuzzy finder), Dressing (better UI for vim.ui)

### Editor Plugins (`editor/`)
- **treesitter.lua**: Syntax highlighting, rainbow brackets, commenting
- **mini-text.lua**: Text manipulation (pairs, surround, move, ai, jump, splitjoin, trailspace, operators, align)
- **mini-ui.lua**: UI enhancements (statusline, tabline, cursorword, hipatterns, icons, map, files, jump2d, misc)
- **mini-navigation.lua**: Navigation tools (bracketed, pick, visits, sessions, fuzzy, extra)

### LSP Plugins (`lsp/`)
- **lspconfig.lua**: Complete LSP setup including Mason, nvim-lspconfig, nvim-cmp, and Trouble

### Git Plugins (`git/`)
- **gitsigns.lua**: Git signs in the gutter, git hunk navigation and operations, mini.diff integration

### Development Tools (`dev/`)
- **formatting.lua**: Automatic code formatting with conform.nvim
- **linting.lua**: Code linting with nvim-lint
- **debugging.lua**: Debugging support with nvim-dap and dap-ui

### Language-Specific Plugins (`lang/`)
- **c-cpp.lua**: C/C++ development tools (CMake integration, clangd extensions, header/source switching)
- **java.lua**: Java development with nvim-jdtls
- **latex.lua**: LaTeX support with vimtex

## Adding New Plugins

### Adding a Plugin to an Existing Category

1. Open the appropriate file in the category (e.g., `lua/plugins/ui/themes.lua` for a new theme)
2. Add the plugin configuration to the returned table
3. Save the file - it will be automatically loaded

Example:
```lua
-- In lua/plugins/ui/themes.lua
return {
  -- ... existing plugins ...
  
  -- Add your new plugin
  {
    "author/plugin-name",
    lazy = true,
    config = function()
      require("plugin-name").setup({
        -- your config
      })
    end,
  },
}
```

### Creating a New Plugin Category

1. Create a new directory: `mkdir lua/plugins/your-category`
2. Create a plugin file: `lua/plugins/your-category/your-file.lua`
3. Add your plugin configuration as a returned table
4. Import it in `lua/plugins/init.lua`:
   ```lua
   -- Add to the load_plugin_modules function
   merge(require("plugins.your-category.your-file"))
   ```

## Benefits of Modular Structure

1. **Easier Navigation**: Find plugins by category instead of scrolling through 2800+ lines
2. **Better Organization**: Related plugins are grouped together logically
3. **Simpler Maintenance**: Update or remove entire categories without affecting others
4. **Clearer Dependencies**: Plugin relationships are more obvious
5. **Faster Loading**: Lazy.nvim can better optimize load times with smaller files
6. **Team Collaboration**: Multiple people can work on different categories without conflicts
7. **Testing**: Easier to disable/enable specific categories for troubleshooting

## Reverting to Monolithic Configuration

The original monolithic configuration (2832 lines) has been moved to `docs/dev/plugins_init.lua.old` for historical reference.

## Configuration Files

Core configuration files remain unchanged:
- `lua/config/options.lua` - Vim options
- `lua/config/keymaps.lua` - General keybindings
- `lua/config/autocmds.lua` - Autocommands
- `lua/config/theme.lua` - Theme persistence system
- `ftplugin/java.lua` - Java-specific configuration

## Minimal Setup

The minimal setup (`lua/plugins/minimal.lua`) is unchanged and can be activated by creating a `.minimal_setup` file in the config directory.
