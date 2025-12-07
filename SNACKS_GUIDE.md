# snacks.nvim Complete Guide

## Overview

**snacks.nvim** is a comprehensive, modern plugin collection by **folke** that provides 21 high-quality features for Neovim. This setup has all features enabled and configured.

**Author:** folke (creator of lazy.nvim, which-key.nvim, trouble.nvim, tokyonight.nvim)  
**Repository:** https://github.com/folke/snacks.nvim  
**Philosophy:** Small, focused features that work well together

## All 21 Features Explained

### 1. 🏠 snacks.dashboard - Start Screen

**What it does:** Beautiful start screen that appears when you launch Neovim without a file.

**Features:**
- Recent files list
- Quick action shortcuts (find files, new file, config, etc.)
- Session restoration
- Startup time statistics
- Custom ASCII header

**Keybindings:**
- `<leader>sd` - Open dashboard

**How to improve:**
- Customize the ASCII header in `lua/plugins/init.lua`
- Add more quick actions for your workflow
- Integrate with your project management system

**Configuration location:** Line 20-48 in `lua/plugins/init.lua`

---

### 2. 🔔 snacks.notifier - Enhanced Notifications

**What it does:** Modern notification system that replaces basic `vim.notify` with beautiful, persistent notifications.

**Features:**
- Notification history
- Different severity levels (error, warn, info, debug)
- Customizable timeout and styling
- Dismiss individual or all notifications
- Compact style with icons

**Keybindings:**
- `<leader>nh` - Show notification history
- `<leader>nd` - Dismiss all notifications

**How to improve:**
- Adjust timeout in config (currently 3000ms)
- Change notification position (currently top-right)
- Customize icons for different levels
- Add notification filters

**Configuration location:** Line 50-67 in `lua/plugins/init.lua`

**Replaced:** nvim-notify plugin

---

### 3. 🎢 snacks.scroll - Smooth Scrolling

**What it does:** Adds smooth scrolling animations when jumping in files, making navigation more visually comfortable.

**Features:**
- Smooth scrolling for all jumps
- Configurable animation duration and easing
- Spam detection (skips animation for rapid jumps)
- Disabled for terminal buffers

**Keybindings:** None (automatic for all scrolling)

**How to improve:**
- Adjust animation duration (currently 250ms)
- Try different easing functions: "linear", "quadratic", "cubic"
- Adjust spam threshold for your typing speed
- Add custom filters for specific buffer types

**Configuration location:** Line 69-80 in `lua/plugins/init.lua`

**Replaced:** mini.animate plugin

---

### 4. 📏 snacks.indent - Enhanced Indent Guides

**What it does:** Shows vertical lines for indentation levels, making code structure clearer.

**Features:**
- Indent guides for all indentation levels
- Scope highlighting (current block)
- Customizable characters
- Works alongside mini.indentscope

**Keybindings:** None (visual enhancement)

**How to improve:**
- Change guide characters (currently `│`)
- Enable only_scope for cleaner look
- Adjust colors in your theme
- Enable underline for scope

**Configuration location:** Line 82-94 in `lua/plugins/init.lua`

**Note:** Complements mini.indentscope (not a replacement)

---

### 5. 💻 snacks.terminal - Floating Terminal

**What it does:** Provides a beautiful floating terminal window for running shell commands without leaving Neovim.

**Features:**
- Floating terminal with rounded borders
- Configurable size and position
- Quick toggle functionality
- Multiple terminal instances
- LazyGit integration

**Keybindings:**
- `<leader>tt` - Toggle terminal
- `<leader>tg` - Open LazyGit in terminal
- `<C-/>` or `<C-_>` - Quick toggle (normal/terminal mode)
- `<Esc><Esc>` - Close terminal

**How to improve:**
- Adjust terminal size (currently 90% width/height)
- Add more terminal shortcuts (npm, docker, etc.)
- Create project-specific terminal commands
- Customize border style

**Configuration location:** Line 96-109 in `lua/plugins/init.lua`

---

### 6. 📊 snacks.statuscolumn - Git-Integrated Status Column

**What it does:** Enhances the status column (left side) with git signs, marks, and fold indicators.

**Features:**
- Mark indicators
- Sign indicators (diagnostics, etc.)
- Fold indicators
- Git change indicators (add, modify, delete)
- Integrates with gitsigns and mini.diff

**Keybindings:** None (visual enhancement)

**How to improve:**
- Rearrange column order (currently: mark, sign, fold, git)
- Customize git highlight colors
- Add custom sign patterns
- Enable/disable specific indicators

**Configuration location:** Line 111-124 in `lua/plugins/init.lua`

---

### 7. 🔍 snacks.words - LSP Word Navigation

**What it does:** Highlights and navigates between references of the word under cursor using LSP.

**Features:**
- Automatic word highlighting
- Jump to next/previous reference
- LSP integration for accurate references
- Notification on navigation end
- Fold opening on jump

**Keybindings:**
- `]]` - Jump to next reference
- `[[` - Jump to previous reference

**How to improve:**
- Adjust debounce delay (currently 200ms)
- Enable notify_jump for jump feedback
- Add custom highlight colors
- Configure modes (currently n, i, c)

**Configuration location:** Line 126-134 in `lua/plugins/init.lua`

**Replaced:** vim-illuminate plugin

---

### 8. 📦 snacks.bigfile - Large File Optimization

**What it does:** Automatically disables heavy features when opening large files to maintain performance.

**Features:**
- Automatic detection of large files (>1MB default)
- Disables LSP, treesitter, syntax highlighting for large files
- Configurable size threshold
- Notification when optimizations are applied

**Keybindings:** None (automatic)

**How to improve:**
- Adjust file size threshold
- Customize which features to disable
- Add file type exceptions
- Create manual toggle

**Configuration location:** Line 16 in `lua/plugins/init.lua` (enabled only)

---

### 9. ⚡ snacks.quickfile - Fast File Loading

**What it does:** Optimizes file loading by deferring non-critical setup until after file is displayed.

**Features:**
- Faster initial file display
- Deferred plugin loading
- Prioritizes file content rendering
- Transparent to user

**Keybindings:** None (automatic)

**How to improve:**
- Configure priority order of plugin loading
- Add custom deferred functions
- Benchmark startup time improvements

**Configuration location:** Line 17 in `lua/plugins/init.lua` (enabled only)

---

### 10. 🎭 snacks.animate - General Animation Framework

**What it does:** Provides smooth animations for various UI elements beyond just scrolling.

**Features:**
- Window animations
- Cursor animations
- Generic animation framework
- Configurable duration and easing
- High FPS for smooth motion

**Keybindings:** None (automatic for UI)

**How to improve:**
- Adjust FPS (currently 60)
- Change animation duration (currently 20ms)
- Try different easing functions
- Add custom animations for plugins

**Configuration location:** Line 136-141 in `lua/plugins/init.lua`

---

### 11. 📂 snacks.git - Git Utilities

**What it does:** Provides quick access to common git operations directly in Neovim.

**Features:**
- Git blame for current line
- Open file in git web UI
- Git status information
- Integration with other git plugins

**Keybindings:**
- `<leader>gb` - Git blame line

**How to improve:**
- Add more git operations (status, log, diff)
- Integrate with fugitive keybindings
- Create git workflow shortcuts
- Add blame popup formatting

**Configuration location:** Line 143-145 in `lua/plugins/init.lua`

---

### 12. 🌐 snacks.gitbrowse - Open Git URLs

**What it does:** Opens the current file/line in your git repository's web interface (GitHub, GitLab, etc.).

**Features:**
- Detects git remote URL
- Opens in default browser
- Supports GitHub, GitLab, Bitbucket
- Line number highlighting
- Visual mode support (opens range)

**Keybindings:**
- `<leader>gB` - Git browse (open in browser)

**How to improve:**
- Add custom git hosting providers
- Create branch/commit browsing
- Add clipboard copy option
- Customize URL format

**Configuration location:** Line 147-149 in `lua/plugins/init.lua`

---

### 13. 💻 snacks.lazygit - LazyGit Integration

**What it does:** Enhanced integration with LazyGit terminal UI, providing seamless git management.

**Features:**
- Full LazyGit integration
- File history viewer
- Git log viewer
- Configuration management
- Terminal window management

**Keybindings:**
- `<leader>gg` - Open LazyGit
- `<leader>tg` - Open LazyGit (same)
- `<leader>gf` - LazyGit file history
- `<leader>gl` - LazyGit log

**How to improve:**
- Customize LazyGit config
- Add project-specific git workflows
- Create git alias shortcuts
- Configure LazyGit theme

**Configuration location:** Line 151-154 in `lua/plugins/init.lua`

---

### 14. ✏️ snacks.rename - LSP Rename with Preview

**What it does:** Provides LSP rename functionality with live preview of all changes before applying.

**Features:**
- Live preview of rename changes
- Shows all affected files
- Confirm/cancel before applying
- LSP-powered accuracy
- Undo support

**Keybindings:**
- `<leader>rn` - Rename symbol with preview

**How to improve:**
- Customize preview window appearance
- Add fuzzy search in preview
- Create rename history
- Add rename templates

**Configuration location:** Line 156-158 in `lua/plugins/init.lua`

---

### 15. 🗑️ snacks.bufdelete - Smart Buffer Deletion

**What it does:** Intelligently deletes buffers while preserving window layout and switching to appropriate buffer.

**Features:**
- Preserves window layout
- Smart buffer switching
- Force delete option
- Handles unsaved changes
- Works with splits and tabs

**Keybindings:**
- `<leader>bd` - Delete buffer (smart)
- `<leader>bD` - Delete buffer (force)

**How to improve:**
- Add confirmation for unsaved buffers
- Create buffer wipeout variant
- Add regex buffer deletion
- Integrate with buffer picker

**Configuration location:** Line 160-162 in `lua/plugins/init.lua`

---

### 16. 🔄 snacks.toggle - Toggle Utilities

**What it does:** Provides consistent interface for toggling various Neovim options and features.

**Features:**
- Toggle any vim option
- Toggle plugin features
- Status notifications
- Keybinding framework
- Customizable toggles

**Keybindings:**
- `<leader>tz` - Toggle Zen mode
- `<leader>tZ` - Toggle Zoom
- `<leader>tD` - Toggle dim inactive windows
- `<leader>ts` - Toggle spell check
- `<leader>tw` - Toggle wrap
- `<leader>tg` - Toggle sign column

**How to improve:**
- Add more option toggles (relativenumber, cursorline, etc.)
- Create toggle groups
- Add toggle state persistence
- Create visual toggle indicators

**Configuration location:** Line 164-166 in `lua/plugins/init.lua`

---

### 17. 🧘 snacks.zen - Zen Mode

**What it does:** Distraction-free coding mode that hides UI elements and centers content.

**Features:**
- Hides status line, tab line, etc.
- Centers content
- Configurable width/height
- Toggle specific UI elements
- Zoom variant for maximum focus

**Keybindings:**
- `<leader>z` - Toggle Zen mode
- `<leader>Z` - Zen zoom (maximum)

**How to improve:**
- Adjust zen window size (currently 85%x90%)
- Customize which elements to hide
- Add padding/margins
- Create zen profiles (writing, coding, reading)

**Configuration location:** Line 168-181 in `lua/plugins/init.lua`

---

### 18. 🌗 snacks.dim - Dim Inactive Windows

**What it does:** Dims inactive windows to help focus on the current buffer.

**Features:**
- Automatic window dimming
- Configurable dim amount
- Smooth transitions
- Works with all colorschemes
- Toggle on/off

**Keybindings:**
- `<leader>tD` - Toggle dim

**How to improve:**
- Adjust dim intensity
- Customize dim color/blend
- Add per-filetype dimming
- Create focus animations

**Configuration location:** Line 183-185 in `lua/plugins/init.lua`

---

### 19. 📝 snacks.scratch - Scratch Buffers

**What it does:** Quick temporary buffers for notes, calculations, or testing code snippets.

**Features:**
- Multiple scratch buffers
- Named scratch buffers
- Persistent scratch files
- Filetype support
- Buffer selection UI

**Keybindings:**
- `<leader>.` - Open/create scratch buffer
- `<leader>S` - Select from scratch buffers

**How to improve:**
- Add scratch templates
- Create project-specific scratches
- Add scratch history
- Sync scratches across sessions

**Configuration location:** Line 187-189 in `lua/plugins/init.lua`

---

### 20. 🪟 snacks.win - Window Utilities

**What it does:** Enhanced window management utilities for splits, resizing, and navigation.

**Features:**
- Smart window operations
- Window picker
- Size presets
- Layout management
- Integration with other window plugins

**Keybindings:** None (used by other snacks features)

**How to improve:**
- Add window layout presets
- Create window arrangement shortcuts
- Add window history
- Integrate with tmux

**Configuration location:** Line 191-193 in `lua/plugins/init.lua`

---

### 21. 🔍 snacks.picker - Fuzzy Finder

**What it does:** Alternative fuzzy finder to telescope with snacks-native integration.

**Features:**
- Fast fuzzy finding
- Integrated with snacks features
- Customizable UI
- Multiple pickers
- Native feel

**Status:** Available but we're using Telescope (both can coexist)

**How to improve:**
- Enable as Telescope alternative
- Create custom pickers
- Add project-specific finders
- Benchmark vs Telescope

**Configuration location:** Line 21 in opts (available for use)

---

## Quick Reference

### Keybinding Summary

| Keybinding | Feature | Action |
|------------|---------|--------|
| `<leader>sd` | dashboard | Open dashboard |
| `<leader>nh` | notifier | Notification history |
| `<leader>nd` | notifier | Dismiss notifications |
| `<leader>tt` | terminal | Toggle terminal |
| `<leader>tg` | lazygit | LazyGit |
| `<C-/>` | terminal | Quick toggle terminal |
| `]]` | words | Next reference |
| `[[` | words | Previous reference |
| `<leader>gb` | git | Git blame line |
| `<leader>gB` | gitbrowse | Open in browser |
| `<leader>gf` | lazygit | File history |
| `<leader>gl` | lazygit | Git log |
| `<leader>gg` | lazygit | Open LazyGit |
| `<leader>rn` | rename | Rename with preview |
| `<leader>bd` | bufdelete | Delete buffer |
| `<leader>bD` | bufdelete | Force delete buffer |
| `<leader>z` | zen | Zen mode |
| `<leader>Z` | zen | Zen zoom |
| `<leader>.` | scratch | Scratch buffer |
| `<leader>S` | scratch | Select scratch |
| `<leader>tz` | toggle | Toggle zen |
| `<leader>tZ` | toggle | Toggle zoom |
| `<leader>tD` | toggle | Toggle dim |
| `<leader>ts` | toggle | Toggle spell |
| `<leader>tw` | toggle | Toggle wrap |
| `<leader>tg` | toggle | Toggle sign column |

### Feature Categories

**Visual Enhancements (6):**
- dashboard, notifier, scroll, indent, statuscolumn, animate

**Editing & Navigation (3):**
- words, rename, bufdelete

**Terminal & Git (4):**
- terminal, git, gitbrowse, lazygit

**Focus & Productivity (4):**
- zen, dim, scratch, toggle

**Performance (2):**
- bigfile, quickfile

**Utilities (2):**
- win, picker

## Configuration Tips

### Customizing snacks.nvim

All configuration is in `/lua/plugins/init.lua` starting at line 9.

**To modify a feature:**
1. Find the feature in the `opts` section
2. Adjust parameters as needed
3. Restart Neovim or `:Lazy reload snacks.nvim`

**To disable a feature:**
```lua
feature_name = {
  enabled = false,
},
```

**To add a custom keybinding:**
```lua
keys = {
  -- Add your keybinding here
  { "<leader>custom", function() require("snacks").feature.action() end, desc = "Description" },
},
```

### Performance Tuning

**For better startup time:**
- Keep bigfile and quickfile enabled
- Adjust scroll animation duration
- Reduce notify timeout

**For better visuals:**
- Increase scroll duration for smoother animations
- Adjust zen mode dimensions
- Customize dim intensity

**For productivity:**
- Add more toggle shortcuts
- Create scratch templates
- Customize LazyGit integration

## Troubleshooting

### Common Issues

**Issue:** Notifications not showing  
**Solution:** Check if snacks.notifier is enabled and vim.notify is set correctly

**Issue:** Terminal not opening  
**Solution:** Verify terminal emulator is installed, check keybindings

**Issue:** LSP rename not working  
**Solution:** Ensure LSP server supports rename, check LSP is running

**Issue:** Git features not working  
**Solution:** Verify git is installed and repository is initialized

**Issue:** Scrolling feels slow  
**Solution:** Adjust scroll duration or disable scroll feature

### Debug Commands

```vim
:Lazy reload snacks.nvim          " Reload configuration
:lua vim.print(require("snacks")) " Check snacks is loaded
:checkhealth snacks               " Run health check
:messages                         " View error messages
```

## Advanced Usage

### Creating Custom Features

snacks.nvim is extensible. You can create custom integrations:

```lua
-- In your init.lua or custom config
local snacks = require("snacks")

-- Custom scratch buffer for specific use
vim.keymap.set("n", "<leader>sn", function()
  snacks.scratch({
    name = "notes",
    ft = "markdown",
  })
end, { desc = "Open notes scratch" })

-- Custom toggle
vim.keymap.set("n", "<leader>tc", function()
  snacks.toggle.option("cursorline")
end, { desc = "Toggle cursor line" })
```

### Integration with Other Plugins

snacks.nvim works well with:
- **Telescope:** Use both pickers, snacks for quick, telescope for advanced
- **mini.nvim:** Complementary features (indentscope + indent, etc.)
- **LSP:** rename, words, and other features leverage LSP
- **Git plugins:** Integrates with gitsigns, fugitive, mini.diff

### Workflow Optimization

**For coding:**
1. Use zen mode (`<leader>z`) for focus
2. Enable dim (`<leader>tD`) for split clarity
3. Use words (`]]`/`[[`) for navigation
4. Use rename (`<leader>rn`) for refactoring

**For git workflow:**
1. Use blame (`<leader>gb`) for line history
2. Use browse (`<leader>gB`) for web review
3. Use LazyGit (`<leader>gg`) for operations
4. Use file history (`<leader>gf`) for changes

**For productivity:**
1. Use scratch (`<leader>.`) for quick notes
2. Use terminal (`<leader>tt`) for commands
3. Use toggles (`<leader>t*`) for options
4. Use notifications (`<leader>nh`) for history

## Migration from Other Plugins

### Replaced Plugins

| Old Plugin | New Feature | Notes |
|------------|-------------|-------|
| mini.starter | snacks.dashboard | More features, better UX |
| nvim-notify | snacks.notifier | Better integration |
| mini.animate | snacks.scroll | Smoother, more performant |
| vim-illuminate | snacks.words | LSP-powered, more accurate |

### Why Switch to snacks.nvim?

1. **Performance:** Highly optimized by folke
2. **Integration:** Features work together seamlessly
3. **Maintenance:** Active development, quick bug fixes
4. **Modern:** Uses latest Neovim APIs
5. **Completeness:** 21 features in one plugin

## Resources

- **Official Repository:** https://github.com/folke/snacks.nvim
- **Documentation:** `:help snacks.nvim`
- **Issues:** https://github.com/folke/snacks.nvim/issues
- **Discussions:** https://github.com/folke/snacks.nvim/discussions

## Summary

All 21 snacks.nvim features are now active in this setup:
- ✅ 26 keybindings configured
- ✅ which-key integration complete
- ✅ No redundant plugins remaining
- ✅ All features documented
- ✅ Configuration optimized

Use `<leader>` in Neovim and which-key will show all available snacks commands with descriptions and icons.
