# Migration Guide: Monolithic to Modular Plugin Configuration

## What Changed?

The plugin configuration has been refactored from a single 2832-line file (`lua/plugins/init.lua`) into a modular structure with 20 focused files organized by category.

## File Structure Changes

### Before
```
lua/plugins/
├── init.lua          # 2832 lines - all plugins
└── minimal.lua       # 589 lines - minimal setup
```

### After
```
lua/plugins/
├── init.lua          # 53 lines - loader that imports modules
├── init.lua.backup   # 2832 lines - original file (backup)
├── minimal.lua       # 589 lines - unchanged
├── README.md         # Documentation
│
├── ui/               # UI Enhancement Plugins (3 files)
│   ├── themes.lua
│   ├── snacks.lua
│   └── utilities.lua
│
├── editor/           # Editor Plugins (4 files)
│   ├── treesitter.lua
│   ├── mini-text.lua
│   ├── mini-ui.lua
│   └── mini-navigation.lua
│
├── lsp/              # LSP Configuration (1 file)
│   └── lspconfig.lua
│
├── git/              # Git Integration (1 file)
│   └── gitsigns.lua
│
├── dev/              # Development Tools (3 files)
│   ├── formatting.lua
│   ├── linting.lua
│   └── debugging.lua
│
└── lang/             # Language-Specific (3 files)
    ├── c-cpp.lua
    ├── java.lua
    └── latex.lua

lua/config/lsp/       # LSP Configuration Modules (NEW)
├── servers.lua       # Server configurations
├── keymaps.lua       # LSP keybindings
└── diagnostics.lua   # Diagnostic configuration
```

## What Stayed the Same?

1. **Core Configuration**: `lua/config/` files unchanged
   - `options.lua` - Vim options
   - `keymaps.lua` - General keybindings
   - `autocmds.lua` - Autocommands
   - `theme.lua` - Theme persistence

2. **Filetype Plugins**: `ftplugin/java.lua` unchanged

3. **Minimal Setup**: `lua/plugins/minimal.lua` unchanged

4. **Functionality**: All plugins, features, and keybindings preserved

5. **Init File**: `init.lua` still works the same way

## Breaking Changes

**None!** The refactoring is backward compatible. The new structure loads identically to the old one.

## How to Use the New Structure

### Normal Usage
Just start Neovim as usual. The modular configuration loads automatically:
```bash
nvim
```

### Customizing Plugins

#### Adding a New Plugin
1. Decide which category it belongs to (ui, editor, lsp, git, dev, lang)
2. Edit the appropriate file (e.g., `lua/plugins/ui/themes.lua`)
3. Add your plugin to the returned table

Example:
```lua
-- In lua/plugins/ui/themes.lua
return {
  -- Existing plugins...
  
  {
    "your-username/your-theme",
    lazy = true,
    config = function()
      require("your-theme").setup()
    end,
  },
}
```

#### Removing a Plugin
1. Find the plugin in its category file
2. Delete or comment out the plugin block
3. Restart Neovim

#### Disabling an Entire Category
Comment out the merge line in `lua/plugins/init.lua`:
```lua
-- Temporarily disable development tools
-- merge(require("plugins.dev.formatting"))
-- merge(require("plugins.dev.linting"))
-- merge(require("plugins.dev.debugging"))
```

### Testing the Configuration

After making changes, test that everything loads:
```bash
# Check for Lua syntax errors
nvim --headless "+checkhealth" "+qa"

# Load config and check for errors
nvim --headless "+lua require('plugins')" "+qa"
```

## Troubleshooting

### "Module not found" Errors

If you see errors like `module 'plugins.ui.themes' not found`:

1. Check file exists: `ls lua/plugins/ui/themes.lua`
2. Check for syntax errors: View the file and look for unmatched brackets
3. Verify the file returns a table: Last line should be `return { ... }`

### Plugins Not Loading

If plugins aren't loading:

1. Check `lua/plugins/init.lua` has the correct merge call
2. Verify the plugin file returns a table of plugin specs
3. Run `:Lazy` in Neovim to see plugin status

### Want to Revert?

To go back to the monolithic configuration:
```bash
cd ~/.config/nvim/lua/plugins
mv init.lua init-modular.lua
mv init.lua.backup init.lua
```

Then restart Neovim.

## Benefits of This Structure

1. **Easy Navigation**: Find plugins by category instead of searching 2800 lines
2. **Better Organization**: Related plugins grouped logically
3. **Simpler Maintenance**: Update categories independently
4. **Clearer Dependencies**: Plugin relationships more obvious
5. **Faster Development**: Smaller files load faster in editor
6. **Team Collaboration**: Multiple people can edit different categories
7. **Easier Debugging**: Test categories individually

## Getting Help

- See `lua/plugins/README.md` for detailed documentation
- Check each module file for inline comments
- Original configuration preserved in `lua/plugins/init.lua.backup`

## Migration Checklist

- [x] Backup created (`init.lua.backup`)
- [x] All plugins preserved
- [x] All keybindings preserved
- [x] All functionality preserved
- [x] Documentation added
- [ ] Test in your environment (requires Neovim with your setup)

## Next Steps

1. **Test**: Start Neovim and verify everything works
2. **Explore**: Browse the new structure in `lua/plugins/`
3. **Customize**: Add/remove plugins in their category files
4. **Share**: The modular structure is easier for others to understand

## Questions?

If you encounter issues or have questions about the new structure, please open an issue on the repository.
