# Neovim Setup Optimization Plan

## Executive Summary

This comprehensive plan optimizes the Neovim configuration while **preserving all major features**. The optimization focuses on:

1. **Theme Consolidation**: Reduce from 60+ to ~15 high-quality, actively maintained themes (75% reduction)
2. **snacks.nvim Integration**: Modern all-in-one plugin replacing mini.starter/mini.animate and adding enhanced notifications
3. **Plugin Deduplication**: Remove duplicate plugin definitions and unclear/redundant plugins
4. **No Major Feature Removal**: All LSP servers, formatters, linters, C/C++ development tools, and essential mini.nvim plugins retained

## Current State Analysis

### Themes Analysis (60+ themes - TOO MANY)

#### Themes to KEEP (15 core themes + variants = ~15 total)

**Tier 1: Essential Modern Themes** (6)
- ✅ `onedarkpro.nvim` - Modern OneDark (default theme)
- ✅ `tokyonight.nvim` - Popular theme with 4 variants (night, storm, moon, day)
- ✅ `gruvbox.nvim` - Classic retro theme
- ✅ `dracula.nvim` - Popular dark theme
- ✅ `catppuccin/nvim` - Modern theme with 4 variants (mocha, latte, frappe, macchiato)
- ✅ `nord.nvim` - Arctic bluish theme

**Tier 2: Quality Theme Collections** (5)
- ✅ `nightfox.nvim` - 7 fox-themed variants (nightfox, dawnfox, dayfox, duskfox, nordfox, terafox, carbonfox)
- ✅ `rose-pine/neovim` - 3 variants (main, moon, dawn)
- ✅ `kanagawa.nvim` - 3 Japanese-inspired variants (wave, dragon, lotus)
- ✅ `github-nvim-theme` - 11 GitHub variants with accessibility support
- ✅ `material.nvim` - Material Design theme

**Tier 3: High-Quality Supplementary** (4)
- ✅ `sonokai` - High contrast elegant theme
- ✅ `edge` - Clean and sophisticated theme
- ✅ `everforest` - Comfortable green theme
- ✅ `gruvbox-material` - Material Design Gruvbox variant

**Total: 15 theme plugins providing ~40 theme variants**

#### Themes to REMOVE (45+ themes)

**Category 1: Duplicate Definitions** (4)
- ❌ `lualine.nvim` (line 521-525) - NOT a theme, theme collection dependency
- ❌ Duplicate `nightfox.nvim` entry (lines 529-549) - already defined at lines 87-97
- ❌ Duplicate `tokyonight.nvim` entry (lines 567-593) - already defined at lines 21-34
- ❌ Duplicate `papercolor-theme` entry (line 740-744) - already defined at lines 596-600

**Category 2: Abandoned/Unmaintained** (8)
- ❌ `aurora` (line 265-268) - Low activity, unclear maintenance
- ❌ `darkplus.nvim` (line 261-263) - Abandoned, last commit 2+ years ago
- ❌ `vesper.nvim` (line 469-472) - Very new, unstable
- ❌ `lackluster.nvim` (line 497-500) - Deliberately muted (niche use case)
- ❌ `rigel` (line 659-663) - Abandoned
- ❌ `blue-moon` (line 666-670) - Abandoned
- ❌ `embark` (line 688-694) - Low activity
- ❌ `miramare` (line 746-751) - Abandoned

**Category 3: Redundant (GitHub Themes Cover These)** (3)
- ❌ `vscode.nvim` (line 199-209) - Use `github_dark` instead
- ❌ `codedark` (line 604-607) - Use `github_dark` instead
- ❌ `vim-one` (line 610-614) - Use onedarkpro or github themes instead

**Category 4: Less Popular/Niche** (12)
- ❌ `tender.vim` (line 359-363) - Niche purple theme
- ❌ `spaceduck` (line 365-370) - Retro space theme (niche)
- ❌ `vim-deep-space` (line 372-377) - Cosmic theme (niche)
- ❌ `moonfly` (line 379-385) - Less popular than nightfox
- ❌ `nightfly` (line 387-393) - Less popular than nightfox
- ❌ `zephyr-nvim` (line 395-400) - Less popular
- ❌ `melange-nvim` (line 431-435) - Warm palette (niche)
- ❌ `fluoromachine.nvim` (line 507-518) - Neon themes (niche)
- ❌ `oxocarbon.nvim` (line 424-428) - IBM inspired (niche)
- ❌ `flow.nvim` (line 437-450) - Minimal and clean (redundant with edge)
- ❌ `bamboo.nvim` (line 475-485) - Natural green (redundant with everforest)
- ❌ `flexoki` (line 488-493) - Modern neutral (redundant with nord)

**Category 5: Premium Themes (Good but Redundant)** (6)
- ❌ `monokai-pro.nvim` (line 275-285) - Professional but covered by material
- ❌ `solarized.nvim` (line 288-316) - Classic but less popular now
- ❌ `neovim-ayu` (line 319-330) - Elegant minimal (redundant with edge)
- ❌ `oceanic-next` (line 333-337) - Beautiful blue (covered by nightfox/nordfox)
- ❌ `palenight.vim` (line 340-344) - Material inspired (redundant with material)
- ❌ `gruvbox-baby` (line 347-356) - Modern Gruvbox (redundant with gruvbox-material)

**Category 6: Legacy Themes** (5)
- ❌ `doom-one.nvim` (line 552-564) - Doom Emacs theme (niche)
- ❌ `papercolor-theme` (line 596-600, duplicate 740-744) - Old theme
- ❌ `apprentice.nvim` (line 625-642) - Requires lush dependency
- ❌ `zenburn` (line 644-649) - Very old theme
- ❌ `boo-colorscheme-nvim` (line 652-656) - Base16 alternative (niche)

**Category 7: Additional Niche** (7)
- ❌ `horizon.nvim` (line 673-687) - Sunset theme (niche)
- ❌ `forest-night` (line 697-707) - Similar to everforest
- ❌ `iceberg.vim` (line 709-714) - Clean theme but less popular
- ❌ `challenger-deep` (line 716-722) - Space theme (niche)
- ❌ `jellybeans.vim` (line 724-728) - Old theme
- ❌ `srcery-vim` (line 730-736) - Dark theme (less popular)
- ❌ `vim-illuminate` (line 753-758) - NOT A THEME, unclear purpose, redundant

**Total themes to remove: ~47**

### Mini.nvim Ecosystem (28 plugins - MOSTLY KEEP)

All 28 mini.nvim plugins provide unique functionality. **Only 2 will be replaced by snacks.nvim**:

#### Mini.nvim Plugins to KEEP (26 plugins)

**Editing Enhancements** (9 plugins)
- ✅ `mini.pairs` - Auto-close brackets/quotes with smart patterns
- ✅ `mini.surround` - Surround text with brackets, quotes, tags
- ✅ `mini.ai` - Better text objects (around/inside)
- ✅ `mini.move` - Move lines and selections with Alt+hjkl
- ✅ `mini.jump` - Jump to next/previous single character
- ✅ `mini.splitjoin` - Split/join function arguments
- ✅ `mini.operators` - Additional operators (evaluate, exchange, multiply, replace, sort)
- ✅ `mini.trailspace` - Show and remove trailing whitespace
- ✅ `mini.align` - Text alignment with ga and gA

**File & Buffer Management** (5 plugins)
- ✅ `mini.files` - File explorer with preview
- ✅ `mini.bufremove` - Delete buffers without losing layout
- ✅ `mini.pick` - Alternative picker (complements telescope)
- ✅ `mini.visits` - Track recently visited files
- ✅ `mini.sessions` - Session management

**UI & Visual** (7 plugins)
- ✅ `mini.statusline` - Fast minimal statusline
- ✅ `mini.tabline` - Customizable tabline
- ✅ `mini.icons` - Icon provider
- ✅ `mini.cursorword` - Highlight word under cursor
- ✅ `mini.hipatterns` - Highlight TODO, FIXME, hex colors
- ✅ `mini.indentscope` - Visual indent guides
- ✅ `mini.map` - Buffer text overview (minimap)

**Navigation** (2 plugins)
- ✅ `mini.jump2d` - Jump to any position with Enter
- ✅ `mini.bracketed` - Go to next/previous targets

**Git Integration** (1 plugin)
- ✅ `mini.diff` - Work with diff hunks

**Extras** (3 plugins)
- ✅ `mini.extra` - Extra textobjects and pickers
- ✅ `mini.fuzzy` - Fuzzy matching algorithms
- ✅ `mini.misc` - Miscellaneous functions (zoom, etc.)

#### Mini.nvim Plugins to REPLACE with snacks.nvim (2 plugins)

- ❌ `mini.starter` → 🍿 `snacks.dashboard` (better UX, more features)
- ❌ `mini.animate` → 🍿 `snacks.scroll` (smoother animations, better performance)

### snacks.nvim Integration (NEW ADDITION)

**snacks.nvim** is a modern, all-in-one plugin by folke (creator of lazy.nvim) that provides:

#### Features to Enable

1. **snacks.dashboard** (replaces mini.starter)
   - Modern, beautiful start screen
   - Better customization options
   - Recent files, quick actions, and project integration

2. **snacks.notifier** (NEW - replaces basic vim.notify)
   - Beautiful animated notifications
   - History and management
   - Better than nvim-notify in many ways

3. **snacks.scroll** (replaces mini.animate scroll)
   - Smoother scroll animations
   - Better performance
   - Configurable easing functions

4. **snacks.indent** (OPTIONAL - complements mini.indentscope)
   - Enhanced indent guides with scope highlighting
   - Can work alongside mini.indentscope or replace it

5. **snacks.statuscolumn** (OPTIONAL)
   - Enhanced statuscolumn with git signs
   - Better than default

6. **snacks.terminal** (OPTIONAL)
   - Improved terminal management
   - Floating terminal windows

#### Configuration
```lua
{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Core features (replacing mini plugins)
    dashboard = { enabled = true },
    notifier = { enabled = true },
    scroll = { enabled = true },
    
    -- Optional enhancements
    indent = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    
    -- Additional useful features
    bigfile = { enabled = true },  -- Disable features for large files
    quickfile = { enabled = true }, -- Faster file loading
    words = { enabled = true },     -- Enhanced word motions
  },
}
```

### Other Plugins Analysis

#### Plugins to REMOVE (3 plugins)

1. ❌ **vim-illuminate** (line 753-758)
   - Purpose unclear from config
   - Appears redundant with mini.cursorword
   - No clear benefit over existing tools

2. ❌ **Duplicate nightfox.nvim** (lines 529-549)
   - Already defined at lines 87-97
   - Complete duplicate

3. ❌ **Duplicate tokyonight.nvim** (lines 567-593)
   - Already defined at lines 21-34
   - Complete duplicate

4. ❌ **lualine.nvim** (line 521-525)
   - Listed as theme collection but not configured
   - Not actually used as mini.statusline is the statusline
   - Unnecessary dependency

#### Plugins to KEEP - NO CHANGES (ALL MAJOR FEATURES)

**LSP & Completion** (10 plugins)
- ✅ nvim-lspconfig - LSP configurations
- ✅ mason.nvim - LSP server management
- ✅ mason-lspconfig.nvim - Mason-LSP integration
- ✅ mason-tool-installer.nvim - Automatic tool installation
- ✅ mason-nvim-dap.nvim - Mason-DAP integration
- ✅ nvim-cmp - Completion engine
- ✅ cmp-nvim-lsp, cmp-buffer, cmp-path, cmp-cmdline - Completion sources
- ✅ LuaSnip - Snippet engine
- ✅ cmp_luasnip - LuaSnip integration
- ✅ friendly-snippets - Snippet collection

**C/C++ Development Suite** (7 plugins)
- ✅ clangd_extensions.nvim - Enhanced clangd features
- ✅ cmake-tools.nvim - CMake integration
- ✅ nvim-dap - Debug Adapter Protocol
- ✅ nvim-dap-ui - Debugging interface
- ✅ nvim-dap-virtual-text - Virtual text in debugger
- ✅ nvim-lint - Static analysis with cppcheck
- ✅ vim-lsp-cxx-highlight - Enhanced C/C++ syntax
- ✅ CurtineIncSw.vim - Header/source switching

**Assembly Language Support** (1 plugin + LSP)
- ✅ asm-lsp - Assembly LSP for NASM/GAS/MASM/TASM

**Formatting & Linting** (2 plugins)
- ✅ conform.nvim - Code formatting with Mason integration
- ✅ nvim-lint - Linting with Mason integration

**Git Integration** (3 plugins - all serve different purposes)
- ✅ gitsigns.nvim - Git decorations and inline hunks
- ✅ vim-fugitive - Comprehensive Git wrapper
- ✅ mini.diff - Lightweight diff viewer (already counted in mini.nvim)

**UI & Navigation** (5 plugins)
- ✅ telescope.nvim - Fuzzy finder (essential)
- ✅ trouble.nvim - Diagnostics panel
- ✅ nvim-treesitter - Syntax highlighting (essential)
- ✅ which-key.nvim - Key binding popup (essential for discoverability)
- ✅ dressing.nvim - Better UI for vim.ui interfaces
- ✅ rainbow-delimiters.nvim - Rainbow brackets

**Editing & Productivity** (2 plugins)
- ✅ Comment.nvim - Smart commenting
- ✅ vimtex - LaTeX support

**Essential Dependencies** (2 plugins)
- ✅ plenary.nvim - Lua utility functions
- ✅ nvim-nio - Async I/O for DAP
- ✅ nvim-web-devicons - Icons (used by many plugins)
- ✅ nvim-tree/nvim-web-devicons - Icons (telescope dependency)

## Implementation Plan

### Phase 1: Add snacks.nvim

1. Add snacks.nvim plugin definition at the top of plugins/init.lua
2. Configure with dashboard, notifier, scroll, indent, statuscolumn, terminal
3. Set up keymaps for snacks features

### Phase 2: Remove mini.starter and mini.animate

1. Remove mini.starter plugin block (lines 1000-1094)
2. Remove mini.animate plugin block (lines 1098-1123)
3. Update any keymaps that referenced these plugins

### Phase 3: Theme Consolidation

1. Remove all 47 theme plugins identified in "Themes to REMOVE"
2. Keep only the 15 core theme plugins
3. Update theme.lua to reflect new theme list
4. Test theme switcher with new theme list

### Phase 4: Remove Duplicate and Redundant Plugins

1. Remove vim-illuminate plugin block
2. Remove duplicate nightfox.nvim entry
3. Remove duplicate tokyonight.nvim entry
4. Remove lualine.nvim entry (not used)

### Phase 5: Testing and Validation

1. Test full setup loads without errors
2. Test minimal setup loads without errors
3. Verify theme switcher works with new themes
4. Verify snacks.nvim features work (dashboard, notifier, scroll)
5. Verify all LSP, formatters, linters work
6. Verify C/C++ development tools work
7. Verify all major features preserved

### Phase 6: Documentation Updates

1. Update README.md with new theme count
2. Update PLUGIN_GUIDE.md with snacks.nvim info
3. Create this OPTIMIZATION_PLAN.md document
4. Update any references to removed themes

## Expected Results

### Metrics

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| **Themes** | 60+ | ~15 | 75% reduction |
| **Theme Variants** | ~80 | ~40 | 50% reduction |
| **Plugin File Size** | 3,107 lines | ~1,900 lines | 39% reduction |
| **Plugin Count** | ~90 | ~50 | 44% reduction |
| **Startup Time** | Baseline | Faster | Better lazy loading |
| **Code Quality** | Good | Excellent | snacks.nvim integration |
| **Maintainability** | Fair | Excellent | Fewer abandoned plugins |
| **Modern Features** | Good | Excellent | snacks.nvim features |

### File Size Breakdown

**Current (plugins/init.lua):**
- Total: 3,107 lines
- Themes: ~1,500 lines (48%)
- Mini.nvim: ~900 lines (29%)
- LSP/Tools: ~600 lines (19%)
- Other: ~107 lines (4%)

**After Optimization (estimated):**
- Total: ~1,900 lines
- Themes: ~400 lines (21%)
- Mini.nvim: ~750 lines (40%) - less starter/animate + snacks
- LSP/Tools: ~600 lines (32%)
- Snacks.nvim: ~50 lines (3%)
- Other: ~100 lines (5%)

### Feature Preservation Guarantee

✅ **All Major Features Retained:**
- ✅ All LSP servers retained (lua_ls, pyright, ts_ls, clangd, etc.)
- ✅ All formatters retained (stylua, black, prettier, clang-format, etc.)
- ✅ All linters retained (pylint, eslint_d, cppcheck, cpplint, etc.)
- ✅ All C/C++ development tools retained (cmake-tools, dap, clangd_extensions, etc.)
- ✅ All assembly support retained (asm_lsp with NASM/x86 config)
- ✅ All git integration retained (gitsigns, fugitive, mini.diff)
- ✅ All mini.nvim core plugins retained (26 out of 28)
- ✅ All navigation tools retained (telescope, trouble, mini.jump2d, etc.)
- ✅ All essential UI plugins retained (which-key, dressing, statusline, etc.)
- ✅ All editing tools retained (Comment, surround, pairs, etc.)

✨ **New Features Added:**
- ✨ snacks.nvim dashboard (better than mini.starter)
- ✨ snacks.nvim notifier (better notifications)
- ✨ snacks.nvim scroll (better than mini.animate)
- ✨ snacks.nvim terminal (enhanced terminal)
- ✨ snacks.nvim indent (enhanced indent guides)
- ✨ Better startup time with improved lazy loading

### Benefits

1. **Reduced Complexity**
   - Fewer themes to maintain and test
   - Fewer plugin dependencies
   - Cleaner configuration

2. **Better Performance**
   - Faster startup with fewer theme plugins
   - Better lazy loading configuration
   - snacks.nvim is highly optimized

3. **Modern Features**
   - snacks.nvim provides cutting-edge features
   - Better notifications with history
   - Smoother animations
   - Beautiful dashboard

4. **Maintainability**
   - Only actively maintained themes
   - Fewer abandoned plugins to track
   - Better documented setup

5. **User Experience**
   - Better notification system
   - More polished dashboard
   - Smoother animations
   - All major features preserved

## Risk Mitigation

### Backup Strategy
- Git commit before each phase
- Can revert individual phases if issues arise
- Test both full and minimal setups

### Testing Checklist
- [ ] Full setup loads without errors
- [ ] Minimal setup loads without errors
- [ ] Theme switcher works with all 15 themes
- [ ] snacks.dashboard displays correctly
- [ ] snacks.notifier shows notifications
- [ ] snacks.scroll animations work
- [ ] All LSP servers work (test at least 3 languages)
- [ ] All formatters work (test at least 3 languages)
- [ ] All linters work (test at least 2 languages)
- [ ] C/C++ development tools work (cmake, debug, linting)
- [ ] Assembly LSP works
- [ ] Git integration works (gitsigns, fugitive, diff)
- [ ] All keybinds work (check which-key)
- [ ] Telescope finds files and greps
- [ ] Mini.nvim plugins work (test at least 10)

### Rollback Plan
If critical issues arise:
1. Revert to previous commit
2. Identify specific problem plugin/theme
3. Add back only what's necessary
4. Document the issue

## Conclusion

This optimization plan reduces plugin count by 44% and file size by 39% while **preserving all major features**. The focus is on quality over quantity, removing abandoned/redundant themes and adding modern snacks.nvim for enhanced UX. All LSP servers, formatters, linters, C/C++ tools, and essential editing plugins are retained. The result is a faster, cleaner, more maintainable configuration with better features.
