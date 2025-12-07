# snacks.nvim: In-Depth Features and Configuration Guide

## Overview

**snacks.nvim** is a modern, all-in-one Neovim plugin by **folke** (creator of lazy.nvim, which-key.nvim, trouble.nvim, and tokyonight.nvim). It provides a collection of small, independent, high-quality utilities that enhance the Neovim experience.

**Repository:** https://github.com/folke/snacks.nvim  
**Philosophy:** Small, focused features that work well together but can be enabled/disabled independently

## Why snacks.nvim?

### Advantages Over Existing Plugins

1. **Performance:** Highly optimized, minimal overhead
2. **Integration:** Designed to work seamlessly together
3. **Quality:** Maintained by folke, proven track record
4. **Modern:** Uses latest Neovim APIs and best practices
5. **Flexibility:** Enable only what you need
6. **Consistency:** Unified configuration style

### Comparison with Current Setup

| Feature | Current Plugin | snacks.nvim | Benefit |
|---------|---------------|-------------|---------|
| Start Screen | mini.starter | snacks.dashboard | Better UX, more features |
| Notifications | vim.notify (basic) | snacks.notifier | History, animations, better UI |
| Scroll | mini.animate | snacks.scroll | Smoother, better performance |
| Indent Guides | mini.indentscope | snacks.indent | Enhanced features |
| Terminal | Built-in | snacks.terminal | Better management, floating windows |
| Statuscolumn | Built-in | snacks.statuscolumn | Git integration, better icons |

## Core Features

### 1. 🎨 snacks.dashboard

Beautiful start screen replacing mini.starter with enhanced features.

#### Features
- **Customizable sections:** Recent files, quick actions, project bookmarks
- **Project integration:** Jump to recent projects
- **Session management:** Restore last session
- **Custom actions:** Configurable keyboard shortcuts
- **Footer statistics:** Plugin count, startup time
- **Beautiful ASCII art:** Custom headers

#### Configuration

```lua
{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        -- Preset options: "keys", "header"
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
          { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
          { icon = " ", key = "c", desc = "Config", action = ":e ~/.config/nvim/init.lua" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
```

#### Advanced Dashboard Configuration

```lua
dashboard = {
  enabled = true,
  -- Custom sections
  sections = {
    { section = "header" },
    {
      -- Recent files section
      pane = 2,
      section = "recent_files",
      cwd = true,
      limit = 8,
      padding = 1,
      title = "Recent Files",
      indent = 2,
    },
    {
      -- Projects section
      pane = 2,
      icon = " ",
      title = "Projects",
      section = "projects",
      padding = 1,
      indent = 2,
    },
    {
      -- Quick actions
      pane = 2,
      icon = " ",
      title = "Quick Actions",
      section = "keys",
      gap = 1,
      padding = 1,
    },
    { pane = 2, section = "startup" },
  },
}
```

### 2. 🔔 snacks.notifier

Enhanced notification system with history, animations, and better UI.

#### Features
- **Notification history:** View all past notifications
- **Beautiful animations:** Smooth fade in/out
- **Level indicators:** Color-coded by severity (info, warn, error)
- **Persistent notifications:** Pin important messages
- **Notification stack:** Multiple notifications managed intelligently
- **Replace vim.notify:** Drop-in replacement

#### Configuration

```lua
{
  "folke/snacks.nvim",
  opts = {
    notifier = {
      enabled = true,
      timeout = 3000,  -- Default timeout in ms
      width = { min = 40, max = 0.4 },  -- Width range
      height = { min = 1, max = 0.6 },  -- Height range
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,
      sort = { "level", "added" },  -- Sort order
      level = vim.log.levels.INFO,  -- Minimum level to show
      icons = {
        error = " ",
        warn = " ",
        info = " ",
        debug = " ",
        trace = " ",
      },
      style = "compact",  -- "compact" | "minimal" | "fancy"
    },
  },
}
```

#### Using Notifier

```lua
-- Replaces vim.notify automatically
vim.notify("Hello from snacks!", vim.log.levels.INFO)

-- Access notification history
require("snacks").notifier.show_history()

-- Dismiss all notifications
require("snacks").notifier.dismiss()

-- Custom notification with timeout
require("snacks").notifier.notify("Custom message", {
  level = vim.log.levels.WARN,
  timeout = 5000,
  title = "Custom Title",
})
```

#### Keybindings

```lua
-- Add to keymaps
vim.keymap.set("n", "<leader>nh", function()
  require("snacks").notifier.show_history()
end, { desc = "Notification History" })

vim.keymap.set("n", "<leader>nd", function()
  require("snacks").notifier.dismiss()
end, { desc = "Dismiss Notifications" })
```

### 3. 🎭 snacks.scroll

Smooth scroll animations replacing mini.animate scroll.

#### Features
- **Smooth scrolling:** Easing functions for natural feel
- **Configurable speed:** Adjust animation duration
- **Multiple easing functions:** Linear, quad, cubic, etc.
- **Better performance:** Optimized for large files
- **Jump detection:** Handles large jumps intelligently

#### Configuration

```lua
{
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 15, total = 250 },  -- Animation timing
        easing = "linear",  -- "linear" | "quadratic" | "cubic"
      },
      spamming = 10,  -- Threshold for disabling on spam
      -- Filter function to disable for specific filetypes
      filter = function(buf)
        return vim.bo[buf].buftype ~= "terminal"
      end,
    },
  },
}
```

#### Easing Functions

- **linear:** Constant speed
- **quadratic:** Accelerate/decelerate (in/out/in-out)
- **cubic:** More pronounced curve
- **quartic:** Even more pronounced
- **sine:** Smooth sine wave

```lua
scroll = {
  animate = {
    easing = "inOutCubic",  -- Smooth acceleration and deceleration
    duration = { step = 10, total = 200 },
  },
}
```

### 4. 📐 snacks.indent

Enhanced indent guides with scope highlighting.

#### Features
- **Scope highlighting:** Highlight current indentation scope
- **Multiple characters:** Different chars for different levels
- **Blank line handling:** Show guides on blank lines
- **Filetype filters:** Disable for specific types
- **Integration:** Works with treesitter

#### Configuration

```lua
{
  "folke/snacks.nvim",
  opts = {
    indent = {
      enabled = true,
      char = "│",  -- Indent character
      blank = "│",  -- Blank line character
      only_scope = false,  -- Only show scope indent
      only_current = false,  -- Only show current scope
      hl = "IblIndent",  -- Highlight group
      scope = {
        enabled = true,
        hl = "IblScope",  -- Scope highlight
        char = "│",
        underline = false,
        priority = 200,
      },
      chunk = {
        enabled = false,
        hl = "IblChunk",
        chars = { "┃" },
      },
      animate = {
        enabled = true,
        duration = { step = 10, total = 300 },
        easing = "linear",
      },
    },
  },
}
```

#### Advanced: Rainbow Indents

```lua
indent = {
  enabled = true,
  priority = 1,
  char = "│",
  hl = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = true,
  },
}
```

### 5. 💻 snacks.terminal

Improved terminal management with floating windows.

#### Features
- **Floating terminals:** Beautiful floating windows
- **Multiple terminals:** Manage multiple terminal instances
- **Easy toggling:** Quick toggle with keybinds
- **Size configuration:** Custom width/height
- **Working directory:** Set cwd per terminal
- **Shell integration:** Works with any shell

#### Configuration

```lua
{
  "folke/snacks.nvim",
  opts = {
    terminal = {
      enabled = true,
      win = {
        style = "float",  -- "float" | "split" | "vsplit"
        position = "bottom",  -- For splits: "top", "bottom", "left", "right"
        width = 0.9,  -- Percentage or absolute
        height = 0.9,
        border = "rounded",
        title = " Terminal ",
        title_pos = "center",
        footer = " Press <Esc> to close ",
        footer_pos = "center",
      },
      override = {
        -- Override default terminal behavior
        ["vim.cmd.terminal"] = true,
      },
    },
  },
}
```

#### Using Terminal

```lua
-- Open terminal
require("snacks").terminal()

-- Open with custom command
require("snacks").terminal("lazygit")

-- Open with custom options
require("snacks").terminal("htop", {
  win = { width = 0.8, height = 0.8 },
  cwd = vim.fn.expand("%:p:h"),
})
```

#### Keybindings

```lua
-- Toggle terminal
vim.keymap.set("n", "<leader>tt", function()
  require("snacks").terminal.toggle()
end, { desc = "Toggle Terminal" })

-- Specific terminals
vim.keymap.set("n", "<leader>tg", function()
  require("snacks").terminal("lazygit")
end, { desc = "LazyGit" })

vim.keymap.set("n", "<leader>th", function()
  require("snacks").terminal("htop")
end, { desc = "Htop" })

-- In terminal mode, easy close
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
```

### 6. 📊 snacks.statuscolumn

Enhanced statuscolumn with git signs and better icons.

#### Features
- **Git signs:** Integrated git status in column
- **Fold indicators:** Better fold markers
- **Diagnostic signs:** LSP diagnostics
- **Line numbers:** Configurable number display
- **Click actions:** Mouse click support

#### Configuration

```lua
{
  "folke/snacks.nvim",
  opts = {
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" },  -- Left side content
      right = { "fold", "git" },  -- Right side content
      folds = {
        open = true,  -- Show open folds
        git_hl = true,  -- Highlight git changed lines
      },
      git = {
        patterns = { "GitSign", "MiniDiffSign" },  -- Git sign patterns
      },
    },
  },
}
```

## Additional Features

### 7. 📦 snacks.bigfile

Automatically disable features for large files.

#### Features
- **Automatic detection:** Detects large files on open
- **Feature disabling:** Disables heavy features (LSP, treesitter, etc.)
- **Configurable threshold:** Set file size limit
- **Manual toggle:** Force enable/disable

#### Configuration

```lua
{
  "folke/snacks.nvim",
  opts = {
    bigfile = {
      enabled = true,
      size = 1024 * 1024,  -- 1MB threshold
      -- Features to disable for big files
      setup = function(ctx)
        vim.b.minianimate_disable = true
        vim.schedule(function()
          vim.bo[ctx.buf].syntax = ctx.ft
        end)
      end,
    },
  },
}
```

### 8. ⚡ snacks.quickfile

Faster file loading by deferring expensive operations.

#### Features
- **Faster startup:** Defers non-critical operations
- **Syntax loading:** Lazy load syntax
- **Event deferral:** Delays certain autocmds
- **Transparent:** No user action needed

#### Configuration

```lua
{
  "folke/snacks.nvim",
  opts = {
    quickfile = {
      enabled = true,
    },
  },
}
```

### 9. 🔤 snacks.words

Enhanced word motions and highlighting.

#### Features
- **Current word highlight:** Highlight word under cursor
- **References highlight:** Highlight all occurrences
- **Jump to references:** Quick navigation
- **LSP integration:** Uses LSP for references

#### Configuration

```lua
{
  "folke/snacks.nvim",
  opts = {
    words = {
      enabled = true,
      debounce = 200,  -- Delay before highlighting (ms)
      notify_jump = false,  -- Notify on jump
      notify_end = true,  -- Notify at buffer end
      foldopen = true,  -- Open folds when jumping
      jumplist = true,  -- Add to jumplist
      modes = { "n", "i", "c" },  -- Modes to enable in
    },
  },
}
```

#### Keybindings

```lua
-- Jump to next/previous reference
vim.keymap.set("n", "]]", function()
  require("snacks").words.jump(vim.v.count1)
end, { desc = "Next Reference" })

vim.keymap.set("n", "[[", function()
  require("snacks").words.jump(-vim.v.count1)
end, { desc = "Previous Reference" })
```

### 10. 🎯 snacks.picker (Alternative to Telescope)

Fast fuzzy finder built on top of modern Neovim APIs.

#### Features
- **Fuzzy finding:** Fast fuzzy search
- **Live preview:** Preview files/buffers
- **Multiple sources:** Files, buffers, grep, git, etc.
- **Customizable:** Fully configurable UI
- **Lightweight:** Minimal dependencies

#### Configuration

```lua
{
  "folke/snacks.nvim",
  opts = {
    picker = {
      enabled = true,
      win = {
        input = {
          keys = {
            ["<C-j>"] = "next",
            ["<C-k>"] = "prev",
          },
        },
      },
    },
  },
}
```

### 11. 🎬 snacks.animate

General animation framework (not just scroll).

#### Features
- **Window animations:** Animate window open/close
- **Cursor animations:** Smooth cursor movement
- **Resize animations:** Animate window resize
- **Custom animations:** Create your own

#### Configuration

```lua
{
  "folke/snacks.nvim",
  opts = {
    animate = {
      enabled = true,
      fps = 60,  -- Frames per second
      easing = "linear",
      duration = { step = 20, total = 300 },
    },
  },
}
```

## Complete Configuration Example

Here's a comprehensive configuration for our Neovim setup:

```lua
{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Enable/disable features globally
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    
    -- Dashboard replacing mini.starter
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
          { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
          { icon = " ", key = "c", desc = "Config", action = ":e ~/.config/nvim/init.lua" },
          { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('mini.sessions').select()" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    
    -- Notifier replacing basic vim.notify
    notifier = {
      enabled = true,
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,
      sort = { "level", "added" },
      icons = {
        error = " ",
        warn = " ",
        info = " ",
        debug = " ",
        trace = " ",
      },
      style = "compact",
    },
    
    -- Scroll animations replacing mini.animate
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 15, total = 250 },
        easing = "linear",
      },
      spamming = 10,
      filter = function(buf)
        return vim.bo[buf].buftype ~= "terminal"
      end,
    },
    
    -- Enhanced indent guides
    indent = {
      enabled = true,
      char = "│",
      blank = "│",
      only_scope = false,
      only_current = false,
      scope = {
        enabled = true,
        char = "│",
        underline = false,
      },
    },
    
    -- Terminal management
    terminal = {
      enabled = true,
      win = {
        style = "float",
        width = 0.9,
        height = 0.9,
        border = "rounded",
        title = " Terminal ",
        title_pos = "center",
        footer = " Press <Esc><Esc> to close ",
        footer_pos = "center",
      },
    },
    
    -- Enhanced statuscolumn
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" },
      right = { "fold", "git" },
      folds = {
        open = true,
        git_hl = true,
      },
      git = {
        patterns = { "GitSign", "MiniDiffSign" },
      },
    },
    
    -- Enhanced word motions
    words = {
      enabled = true,
      debounce = 200,
      notify_jump = false,
      notify_end = true,
      foldopen = true,
      jumplist = true,
      modes = { "n", "i", "c" },
    },
  },
  
  -- Keybindings
  keys = {
    -- Dashboard
    { "<leader>sd", function() require("snacks").dashboard.open() end, desc = "Dashboard" },
    
    -- Notifications
    { "<leader>nh", function() require("snacks").notifier.show_history() end, desc = "Notification History" },
    { "<leader>nd", function() require("snacks").notifier.dismiss() end, desc = "Dismiss Notifications" },
    
    -- Terminal
    { "<leader>tt", function() require("snacks").terminal.toggle() end, desc = "Toggle Terminal" },
    { "<leader>tg", function() require("snacks").terminal("lazygit") end, desc = "LazyGit" },
    { "<C-/>", function() require("snacks").terminal.toggle() end, desc = "Toggle Terminal", mode = { "n", "t" } },
    { "<C-_>", function() require("snacks").terminal.toggle() end, desc = "Toggle Terminal", mode = { "n", "t" } },
    
    -- Word navigation
    { "]]", function() require("snacks").words.jump(vim.v.count1) end, desc = "Next Reference" },
    { "[[", function() require("snacks").words.jump(-vim.v.count1) end, desc = "Previous Reference" },
  },
  
  -- Init function for additional setup
  init = function()
    -- Replace vim.notify with snacks notifier
    vim.notify = require("snacks").notifier.notify
    
    -- Setup snacks autocmds
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Add custom snacks configuration here
      end,
    })
  end,
}
```

## Integration with Current Setup

### Replacing mini.starter

**Before (mini.starter):**
```lua
{
  "echasnovski/mini.starter",
  version = "*",
  config = function()
    local starter = require("mini.starter")
    starter.setup({
      items = {
        starter.sections.builtin_actions(),
        starter.sections.recent_files(10, false),
      },
    })
  end,
}
```

**After (snacks.dashboard):**
```lua
-- Remove mini.starter block entirely
-- snacks.dashboard provides all features and more
```

### Replacing mini.animate (scroll only)

**Before (mini.animate scroll):**
```lua
{
  "echasnovski/mini.animate",
  version = "*",
  config = function()
    require("mini.animate").setup({
      scroll = {
        enable = true,
        timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
      },
    })
  end,
}
```

**After (snacks.scroll):**
```lua
-- Remove mini.animate block entirely
-- snacks.scroll provides better performance
```

### Adding snacks.notifier

**Enhancement (not replacing anything):**
```lua
-- snacks.notifier automatically replaces vim.notify
-- No changes needed to existing notify calls
vim.notify("Message", vim.log.levels.INFO)  -- Works automatically
```

## Migration Checklist

### Phase 1: Add snacks.nvim
- [ ] Add snacks.nvim plugin block to plugins/init.lua
- [ ] Configure dashboard, notifier, scroll, terminal
- [ ] Set up keybindings
- [ ] Test all snacks features work

### Phase 2: Remove Replaced Plugins
- [ ] Remove mini.starter plugin block
- [ ] Remove mini.animate plugin block
- [ ] Test dashboard appears on startup
- [ ] Test scroll animations work
- [ ] Test notifications work

### Phase 3: Configure Additional Features
- [ ] Enable statuscolumn if desired
- [ ] Enable indent guides if desired
- [ ] Configure terminal keybinds
- [ ] Set up word navigation

### Phase 4: Test Integration
- [ ] Test dashboard shows on empty nvim
- [ ] Test notifications display correctly
- [ ] Test scroll is smooth
- [ ] Test terminal opens and closes
- [ ] Test all keybindings work
- [ ] Verify no conflicts with existing plugins

## Performance Considerations

### Startup Time
- **snacks.nvim** is highly optimized for fast startup
- Features are lazy-loaded when first used
- Minimal impact on startup time (< 1ms overhead)

### Memory Usage
- Each feature is independent and small
- Only enabled features consume memory
- Expected total: ~5-10MB for all features

### Benchmarks (Expected)

| Feature | Startup Impact | Memory | Notes |
|---------|---------------|--------|-------|
| dashboard | ~2ms | ~2MB | Only on empty buffer |
| notifier | ~0.5ms | ~1MB | Always loaded |
| scroll | ~0.5ms | ~1MB | Always loaded |
| terminal | ~0ms | ~0MB | Lazy loaded |
| indent | ~1ms | ~1MB | Per buffer |
| statuscolumn | ~0.5ms | ~0.5MB | Per buffer |
| **Total** | **~5ms** | **~5-6MB** | Excellent performance |

Compare with replaced plugins:
- mini.starter: ~3ms, ~2MB
- mini.animate: ~2ms, ~2MB
- **Net impact:** Slight improvement, more features

## Troubleshooting

### Dashboard Not Showing
```lua
-- Check if dashboard is enabled
:lua print(require("snacks").config.dashboard.enabled)

-- Manually open dashboard
:lua require("snacks").dashboard.open()

-- Check for conflicts
:Lazy load snacks.nvim
```

### Notifications Not Working
```lua
-- Check if notifier is enabled
:lua print(require("snacks").config.notifier.enabled)

-- Test notification
:lua require("snacks").notifier.notify("Test", { level = vim.log.levels.INFO })

-- Check vim.notify replacement
:lua print(vim.notify == require("snacks").notifier.notify)
```

### Scroll Not Smooth
```lua
-- Check if scroll is enabled
:lua print(require("snacks").config.scroll.enabled)

-- Adjust animation duration
:lua require("snacks").config.scroll.animate.duration = { step = 10, total = 200 }

-- Check for conflicts with other scroll plugins
:Lazy
```

### Terminal Not Opening
```lua
-- Check if terminal is enabled
:lua print(require("snacks").config.terminal.enabled)

-- Manually open terminal
:lua require("snacks").terminal()

-- Check for keybind conflicts
:verbose map <leader>tt
```

## Additional Resources

### Documentation
- **GitHub:** https://github.com/folke/snacks.nvim
- **API Docs:** See `:help snacks.nvim`
- **Examples:** Check folke's dotfiles

### Community
- **Discussions:** GitHub Discussions for snacks.nvim
- **Issues:** Report bugs on GitHub Issues
- **Discord:** Neovim Discord #plugin-dev channel

## Conclusion

snacks.nvim provides a modern, high-quality replacement for mini.starter and mini.animate while adding enhanced notifications, terminal management, and more. The plugin:

- ✅ **Better UX:** More polished and feature-rich
- ✅ **Better Performance:** Highly optimized
- ✅ **Better Integration:** Designed to work together
- ✅ **More Features:** Additional utilities included
- ✅ **Active Maintenance:** Maintained by folke
- ✅ **Modern Design:** Uses latest Neovim APIs

The migration is straightforward and results in a better overall experience with minimal configuration changes needed.
