# Setup Comparison: Full vs Minimal

This document provides a detailed comparison between Full and Minimal setup options to help you choose the right configuration for your needs.

## Quick Comparison Table

| Feature | Full Setup | Minimal Setup |
|---------|------------|---------------|
| **LSP Support** | ✅ Yes (Mason managed) | ❌ No |
| **Auto-completion** | ✅ Yes (nvim-cmp) | ❌ No |
| **Syntax Highlighting** | ✅ Treesitter | ✅ Treesitter |
| **Linters/Formatters** | ✅ Yes (conform.nvim, nvim-lint) | ❌ No |
| **C/C++ Development** | ✅ Full suite | ❌ No |
| **Debugging (DAP)** | ✅ Yes | ❌ No |
| **Themes** | ✅ 50+ themes | ⚡ 5 themes |
| **Mini.nvim plugins** | ✅ All 28 plugins | ⚡ 15 core plugins |
| **File Explorer** | ✅ mini.files | ✅ mini.files |
| **Fuzzy Finder** | ✅ Telescope (extended) | ✅ Telescope (basic) |
| **Git Integration** | ✅ gitsigns + fugitive | ✅ gitsigns |
| **Startup Time** | ~200-300ms | 🚀 ~50-100ms |
| **Disk Space** | ~500MB | ⚡ ~100MB |
| **Dependencies** | Node.js, Python, ripgrep | None required |

## Detailed Feature Breakdown

### Language Server Protocol (LSP)

**Full Setup:**
- ✅ Mason for automatic LSP server management
- ✅ Pre-configured servers: lua_ls, pyright, ts_ls, html, cssls, jsonls, jdtls, cmake, bashls
- ✅ Auto-completion with nvim-cmp
- ✅ Code actions and refactoring
- ✅ Go to definition, references, implementations
- ✅ Hover documentation
- ✅ Symbol renaming
- ✅ Diagnostics with severity levels

**Minimal Setup:**
- ❌ No LSP servers
- ❌ No Mason
- ❌ Manual language tooling only

### Completion Engine

**Full Setup:**
- ✅ nvim-cmp with multiple sources:
  - LSP completions
  - Buffer completions
  - Path completions
  - Command-line completions
  - Snippet completions (LuaSnip)

**Minimal Setup:**
- ❌ No completion engine
- Uses Vim's built-in completion (`<C-n>`, `<C-p>`)

### C/C++ Development Tools

**Full Setup:**
- ✅ clangd LSP with enhanced features
- ✅ clangd_extensions for inlay hints
- ✅ cmake-tools.nvim for CMake integration
- ✅ nvim-dap for debugging (codelldb/gdb)
- ✅ nvim-dap-ui for debug interface
- ✅ nvim-lint with cppcheck
- ✅ vim-lsp-cxx-highlight for enhanced syntax
- ✅ CurtineIncSw for header/source switching
- ✅ Keybindings for CMake: `<leader>cg`, `<leader>cb`, `<leader>cr`
- ✅ Keybindings for debugging: `<leader>db`, `<leader>dc`, `<leader>di`

**Minimal Setup:**
- ❌ No C/C++ specific tools
- Basic Treesitter syntax highlighting for C/C++
- Manual compilation and debugging

### Mini.nvim Ecosystem

**Full Setup (28 plugins):**
- ✅ All 28 mini.nvim plugins including:
  - Advanced text objects (mini.ai)
  - Session management (mini.sessions)
  - Advanced operators (mini.operators)
  - Git diff integration (mini.diff)
  - Bracketed navigation (mini.bracketed)
  - Jump2d (mini.jump2d)
  - Minimap (mini.map)
  - Fuzzy search (mini.fuzzy)
  - Advanced picking (mini.pick)
  - And many more...

**Minimal Setup (15 plugins):**
- ⚡ Core editing plugins:
  - mini.pairs (auto-close brackets)
  - mini.surround (surround text)
  - mini.indentscope (indent visualization)
  - mini.move (move lines)
  - mini.ai (text objects)
  - mini.files (file explorer)
  - mini.statusline (statusline)
  - mini.bufremove (buffer management)
  - mini.starter (start screen)
  - mini.animate (animations)
  - mini.cursorword (highlight word)
  - mini.hipatterns (highlight patterns)
  - mini.trailspace (whitespace management)
  - mini.comment (commenting)
  - mini.tabline (tab line)
  - mini.icons (icons)

### Themes

**Full Setup:**
- 50+ premium themes including:
  - onedark, tokyonight, gruvbox, dracula, catppuccin
  - nord, nightfox, rose-pine, kanagawa
  - sonokai, edge, everforest, gruvbox-material
  - material, vscode, github themes
  - And many more specialized themes

**Minimal Setup:**
- 5 popular themes:
  - onedark (default)
  - tokyonight
  - gruvbox
  - dracula
  - catppuccin

### Git Integration

**Full Setup:**
- ✅ gitsigns.nvim (inline git decorations)
- ✅ vim-fugitive (comprehensive Git wrapper)
- ✅ mini.diff (diff hunks)
- ✅ Extended git keybindings
- ✅ Git blame integration

**Minimal Setup:**
- ✅ gitsigns.nvim (inline git decorations)
- ✅ Basic git keybindings
- ✅ Git blame support

### Diagnostics

**Full Setup:**
- ✅ Native LSP diagnostics
- ✅ Trouble.nvim for organized diagnostic view
- ✅ nvim-lint for additional linters
- ✅ Auto-hover diagnostics (toggleable)
- ✅ Severity-based navigation (`[e`, `]e`, `[w`, `]w`)

**Minimal Setup:**
- ❌ No diagnostics system
- Basic Treesitter error detection

### Code Formatting

**Full Setup:**
- ✅ conform.nvim for formatting
- ✅ Multiple formatters supported
- ✅ Format on save (configurable)
- ✅ Manual formatting: `<leader>lf`

**Minimal Setup:**
- ❌ No automatic formatting
- Manual indentation and formatting

### Telescope Integration

**Full Setup:**
- ✅ Extended Telescope features:
  - Find files, live grep, buffers
  - LSP diagnostics picker
  - Quickfix, location list
  - Enhanced theme switcher with preview
  - Keymap browser by mode
  - Recent files, marks, jumplist
  - Project picker

**Minimal Setup:**
- ⚡ Basic Telescope features:
  - Find files
  - Live grep
  - Buffers
  - Help tags
  - Commands, keymaps
  - Recent files
  - Basic theme switcher

### LaTeX Support

**Both Setups:**
- ✅ VimTeX for LaTeX document editing
- ✅ Configured for common LaTeX workflows

## Use Case Recommendations

### Choose Full Setup If You:
- 🎯 Want a complete IDE experience
- 💻 Do active software development
- 🔬 Work with C/C++ projects
- 🚀 Need LSP features (completions, diagnostics)
- 🎨 Want maximum customization options
- 📦 Don't mind installing dependencies
- ⚡ Have a modern system with good resources

### Choose Minimal Setup If You:
- 📝 Primarily edit text/config files
- 🚀 Want fast startup times
- 💾 Have limited disk space
- 🔧 Prefer manual language tooling
- 🎓 Are learning Vim/Neovim basics
- 🖥️ Work on systems with limited resources
- ⚡ Want a lightweight editor

## Performance Comparison

### Startup Time

| Metric | Full Setup | Minimal Setup |
|--------|------------|---------------|
| Initial load | 200-300ms | 50-100ms |
| Lazy loading | Yes | Yes |
| Plugin count | ~70 plugins | ~25 plugins |

### Memory Usage

| Metric | Full Setup | Minimal Setup |
|--------|------------|---------------|
| Base memory | ~100-150MB | ~50-80MB |
| With LSP active | ~200-300MB | ~50-80MB |
| C/C++ project | ~300-400MB | ~50-80MB |

### Disk Space

| Component | Full Setup | Minimal Setup |
|-----------|------------|---------------|
| Plugins | ~400MB | ~80MB |
| LSP servers | ~100MB | 0MB |
| Total | ~500MB | ~100MB |

## Migration Path

### Starting with Minimal, Upgrading to Full

If you start with Minimal setup and later need Full features:

```bash
# Remove the minimal marker
rm ~/.config/nvim/.minimal_setup

# Restart Neovim and sync plugins
nvim +Lazy\ sync

# Install system dependencies
# (Node.js, Python, ripgrep, etc.)
```

### Starting with Full, Downgrading to Minimal

If you want to switch from Full to Minimal:

```bash
# Create the minimal marker
touch ~/.config/nvim/.minimal_setup

# Restart Neovim and sync plugins
nvim +Lazy\ sync

# Optionally clean unused plugins
nvim +Lazy\ clean
```

## Frequently Asked Questions

### Can I add LSP to Minimal setup?

Not directly. The Minimal setup is designed to be LSP-free. If you need LSP, switch to Full setup. However, you can manually configure LSP by editing `lua/plugins/minimal.lua` to add LSP plugins.

### Can I remove C/C++ tools from Full setup?

Yes! Edit `lua/plugins/init.lua` and comment out or remove the C/C++ development sections (starting around line 2430). Then run `:Lazy clean` in Neovim.

### Can I use Minimal setup with external LSP?

Yes! You can use external language servers (like clangd) and Neovim will work with them if they're in your PATH. You just won't have Mason for management.

### Which themes are included in Minimal?

Minimal includes:
1. onedark (default)
2. tokyonight (multiple variants)
3. gruvbox
4. dracula
5. catppuccin (multiple flavors)

### Can I add more themes to Minimal?

Yes! Edit `lua/plugins/minimal.lua` and add theme plugins. Keep in mind this increases the plugin count.

### How do I know which setup I'm using?

Check for the marker file:
```bash
[ -f ~/.config/nvim/.minimal_setup ] && echo "MINIMAL" || echo "FULL"
```

Or in Neovim:
```vim
:lua print(vim.fn.filereadable(vim.fn.stdpath("config") .. "/.minimal_setup") == 1 and "MINIMAL" or "FULL")
```

### Can I have different setups for different projects?

Not directly per-project, but you can:
1. Keep multiple Neovim configs in different directories
2. Use `NVIM_APPNAME` environment variable to switch configs
3. Symlink different configs as needed

Example:
```bash
# Use minimal config
NVIM_APPNAME=nvim-minimal nvim

# Use full config
NVIM_APPNAME=nvim-full nvim
```

## Conclusion

Both Full and Minimal setups are designed to provide excellent Neovim experiences:

- **Full Setup** is perfect for developers who want a complete, batteries-included IDE experience
- **Minimal Setup** is ideal for those who want a fast, lightweight editor with essential features

The best choice depends on your specific needs, system resources, and workflow preferences. The good news is you can easily switch between them at any time!

For more information, see:
- [INSTALL.md](INSTALL.md) - Detailed installation instructions
- [README.md](README.md) - Main documentation
- [PLUGIN_GUIDE.md](PLUGIN_GUIDE.md) - Plugin usage guide
