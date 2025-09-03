# 📚 Comprehensive Plugin Usage Guide

This guide provides detailed instructions on how to use all the plugins in this Neovim configuration, including how to enable/disable features and configure them to your preferences.

## 🚀 Quick Start

### Essential Commands to Know
- `:Lazy` - Open plugin manager (install, update, remove plugins)
- `:Mason` - Open LSP server manager
- `:checkhealth` - Diagnose configuration issues
- `:help <plugin-name>` - Get help for any plugin

## ⌨️ Key Binding Discovery (which-key.nvim)

### Features
- Popup showing available key bindings after pressing leader key
- Modern configuration using new API (v3.0+ compatible)
- Organized key groups for better discovery

### Key Groups
| Prefix | Description |
|--------|-------------|
| `<leader>f` | Find/Telescope operations |
| `<leader>p` | Pick/Mini.pick operations |
| `<leader>x` | Trouble/diagnostics |
| `<leader>t` | Theme/trim/toggle operations |
| `<leader>g` | Git/diff operations |
| `<leader>c` | Code/LSP operations |
| `<leader>l` | LSP specific operations |
| `<leader>w` | Window operations |
| `<leader>b` | Buffer operations |
| `<leader>v` | Visits/mini.visits operations |
| `<leader>s` | Session/mini.sessions operations |
| `<leader>m` | Map/minimap operations |
| `<leader>r` | Refactor/rename operations |
| `<leader>d` | Diagnostics (deprecated, use `<leader>l`) |
| `<leader>h` | Git hunks operations |
| `<leader>n` | Notification operations |
| `g` | Goto/operators |
| `s` | Surround operations |
| `<M-hjkl>` | Move operations (Alt+direction) |

### Enhanced Theme System
The which-key theme has been upgraded to the **"helix"** preset for a more modern appearance with:
- Double borders for better visual distinction
- Increased padding and spacing for better readability  
- Enhanced transparency (winblend = 15)
- Center-aligned layout with maximum width limits
- Improved icon and key rendering

### Usage
1. Press `<leader>` (space key) and wait
2. A popup will show available key combinations
3. Use arrow keys or continue typing to filter options
4. Press the desired key to execute the command

## 🎨 Theme Management

### Using the Theme Switcher
The configuration includes multiple colorschemes that you can switch between:

```vim
:colorscheme tokyonight-night
:colorscheme gruvbox
:colorscheme dracula
:colorscheme catppuccin-mocha
:colorscheme nord
:colorscheme rose-pine
:colorscheme kanagawa
:colorscheme onedark_dark
```

### Customizing Themes
Edit `lua/plugins/init.lua` to modify theme settings:

```lua
-- Example: Disable transparency for a theme
require("tokyonight").setup({
  style = "night",
  transparent = false,  -- Change to false
})
```

### Quick Theme Switch
Use `<leader>tt` to open the enhanced theme switcher with instant preview and curated themes.

## 🚀 Enhanced Start Screen (Mini.starter)

### Features
The start screen has been completely redesigned with:
- **Beautiful ASCII art header** with personalized greeting
- **Organized sections** for different types of actions
- **Plugin statistics** showing load time and plugin count
- **Quick access** to common tasks and recent files

### Sections Available
1. **🔍 Telescope** - Find files, live grep, buffers, themes
2. **🔧 Management** - Plugin manager, LSP manager, health check  
3. **💾 Sessions** - Load and save workspace sessions
4. **Recent Files** - Recently opened files (local and global)
5. **Builtin Actions** - Edit config, new file, quit

### Customization
The start screen automatically:
- Detects time of day for personalized greeting
- Shows plugin load statistics
- Provides bullet-pointed navigation
- Centers content for better appearance

### Navigation
- Use letter/number keys to quickly jump to items
- Press Enter to select highlighted item
- Use `q` to quit the start screen

## 🔧 Core Development Tools

### LSP (Language Server Protocol)

#### Available Commands
| Command | Description |
|---------|-------------|
| `gd` | Go to definition |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format code |
| `[d` / `]d` | Previous/Next diagnostic |
| `<leader>d` | Show diagnostics in floating window |

#### Adding New Language Servers
1. Open `:Mason`
2. Install desired language server
3. Add configuration in `lua/plugins/init.lua`:

```lua
-- Add to the servers table
local servers = {
  lua_ls = { ... },
  pyright = { ... },
  your_new_server = {
    settings = {
      -- server-specific settings
    }
  },
}
```

#### Disabling LSP for Specific File Types
```lua
-- Add to your configuration
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",  -- disable for markdown files
  callback = function()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
  end,
})
```

### Auto-completion (nvim-cmp)

#### Features
- Intelligent code completion
- Snippet support with LuaSnip
- LSP integration
- Buffer completion

#### Key Bindings in Insert Mode
| Key | Action |
|-----|--------|
| `<C-n>` / `<C-p>` | Navigate completion items |
| `<CR>` | Confirm selection |
| `<C-e>` | Close completion menu |
| `<Tab>` / `<S-Tab>` | Navigate snippets |

#### Disabling Auto-completion
```lua
-- Add to lua/plugins/init.lua in the cmp config
require("cmp").setup({
  enabled = false,  -- Disable completely
  -- OR conditionally disable
  enabled = function()
    return vim.bo.buftype ~= "prompt"
  end,
})
```

### Code Formatting (conform.nvim)

#### Features
- Automatic formatter detection and configuration
- Only configures formatters that are actually installed
- Manual formatting with `<leader>fm`
- Graceful handling of missing formatters

#### Supported Formatters
| Language | Formatter | Installation |
|----------|-----------|--------------|
| Lua | stylua | `cargo install stylua` |
| Python | black | `pip install black` |
| JavaScript/TypeScript | prettier | `npm install -g prettier` |
| HTML/CSS/JSON/YAML | prettier | `npm install -g prettier` |

#### Manual Formatting
- `<leader>fm` - Format current buffer

#### Installing Formatters
```bash
# Install formatters as needed
cargo install stylua          # Lua formatting
pip install black             # Python formatting  
npm install -g prettier       # JS/TS/HTML/CSS/JSON/YAML formatting
```

#### Formatter Health Check
The configuration automatically checks if formatters are available and only enables them if installed. This prevents the health check warnings about missing formatters.

```lua
-- Example: Check if prettier is available
if vim.fn.executable("prettier") == 1 then
  -- prettier is available, configure it
end
```

## 🔍 Navigation & Search

### Telescope (Fuzzy Finder)

#### Basic Commands
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ff` | `:Telescope find_files` | Find files |
| `<leader>fg` | `:Telescope live_grep` | Search in files |
| `<leader>fb` | `:Telescope buffers` | Switch between buffers |
| `<leader>fh` | `:Telescope help_tags` | Search help |
| `<leader>fr` | `:Telescope oldfiles` | Recent files |
| `<leader>fc` | `:Telescope commands` | Available commands |

#### Advanced Usage
```vim
" Search for a specific file type
:Telescope find_files find_command=rg,--files,--glob,*.lua

" Search with preview
:Telescope live_grep

" Search in git files only
:Telescope git_files
```

#### Customizing Telescope
```lua
-- In lua/plugins/init.lua
require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/" },
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.8,
      height = 0.8,
    },
  },
})
```

### Mini.pick (Alternative Picker)

#### Commands
| Key | Description |
|-----|-------------|
| `<leader>pf` | Pick files |
| `<leader>pg` | Pick grep live |
| `<leader>pb` | Pick buffers |
| `<leader>ph` | Pick help |

## 📁 File Management

### Mini.files (File Explorer)

#### Usage
- `<leader>e` - Open file explorer
- `h/j/k/l` - Navigate
- `<CR>` - Open file/enter directory
- `<BS>` - Go to parent directory
- `g.` - Toggle hidden files

#### Advanced Features
```lua
-- Customize mini.files
require("mini.files").setup({
  windows = {
    preview = true,
    width_focus = 30,
    width_preview = 30,
  },
  options = {
    permanent_delete = true,  -- Enable permanent delete
    use_as_default_explorer = true,  -- Replace netrw
  },
})
```

### Buffer Management

#### Mini.bufremove
| Key | Action |
|-----|--------|
| `<leader>bd` | Delete buffer (keep layout) |
| `<leader>bD` | Force delete buffer |

#### Buffer Navigation
- `:bnext` or `:bn` - Next buffer
- `:bprev` or `:bp` - Previous buffer
- `:buffer <name>` - Switch to specific buffer

## 🎯 Git Integration

### Gitsigns

#### Hunk Navigation
| Key | Action |
|-----|--------|
| `]c` | Next hunk |
| `[c` | Previous hunk |

#### Hunk Operations
| Key | Action |
|-----|--------|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |

#### Visual Mode Operations
- Select lines in visual mode
- `<leader>hs` - Stage selected lines
- `<leader>hr` - Reset selected lines

### Mini.git

#### Commands
| Key | Action |
|-----|--------|
| `<leader>gc` | Show git info at cursor |
| `<leader>gd` | Show diff source |

#### SSH Configuration for Mini.git

Mini.git respects your global git configuration. To set up SSH:

1. **Generate SSH key** (if you haven't already):
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

2. **Add SSH key to ssh-agent**:
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

3. **Add SSH key to GitHub/GitLab**:
```bash
cat ~/.ssh/id_ed25519.pub
# Copy and add to your Git provider
```

4. **Test SSH connection**:
```bash
ssh -T git@github.com
# or
ssh -T git@gitlab.com
```

5. **Configure git to use SSH**:
```bash
git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"
# For GitLab:
git config --global url."ssh://git@gitlab.com/".insteadOf "https://gitlab.com/"
```

6. **For repository-specific SSH key**:
```bash
# Create ~/.ssh/config
Host github-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/work_key

# Then clone with:
git clone git@github-work:username/repo.git
```

### Mini.diff

#### Commands
| Key | Action |
|-----|--------|
| `gh` | Apply diff hunk |
| `gH` | Reset diff hunk |
| `[h` / `]h` | Previous/Next hunk |
| `[H` / `]H` | First/Last hunk |

## ✨ Quality of Life Features

### Mini.surround

#### Adding Surroundings
- `sa{motion}{char}` - Add surrounding
- Examples:
  - `saiw"` - Surround inner word with quotes
  - `sa2w)` - Surround 2 words with parentheses
  - `sa$]` - Surround to end of line with brackets

#### Deleting Surroundings
- `sd{char}` - Delete surrounding
- Examples:
  - `sd"` - Delete quotes
  - `sd)` - Delete parentheses
  - `sd]` - Delete brackets

#### Replacing Surroundings
- `sr{old}{new}` - Replace surrounding
- Examples:
  - `sr"'` - Replace quotes with single quotes
  - `sr)]` - Replace parentheses with brackets

### Mini.move

#### Moving Lines/Selections
| Key | Action |
|-----|--------|
| `<M-h>` | Move left |
| `<M-j>` | Move down |
| `<M-k>` | Move up |
| `<M-l>` | Move right |

Works in both normal and visual mode!

### Mini.pairs

#### Auto-pairing
Automatically closes:
- `()` parentheses
- `[]` brackets
- `{}` braces
- `""` quotes
- `''` single quotes

#### Disabling Auto-pairs
```lua
-- Disable for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.b.minipairs_disable = true
  end,
})
```

### Mini.splitjoin

#### Usage
- `gS` - Toggle between split and joined form
- Works with function arguments, arrays, objects, etc.

Example:
```lua
-- Before gS:
func(arg1, arg2, arg3)

-- After gS:
func(
  arg1,
  arg2,
  arg3
)
```

### Mini.operators

#### Text Operators
| Key | Action |
|-----|--------|
| `g=` | Evaluate and replace |
| `gx` | Exchange text regions |
| `gm` | Multiply (duplicate) |
| `gr` | Replace with register |
| `gs` | Sort text |

#### Examples
```lua
-- g= examples:
2 + 2  -- cursor here, g=iw -> 4
math.pi  -- g=iw -> 3.1415926535898

-- gx example:
word1 word2  -- gxiw on word1, then gxiw on word2 to exchange
```

### Mini.align

#### Text Alignment
- `ga{motion}{char}` - Align text
- `gA{motion}{char}` - Align with preview

Examples:
```lua
-- Before alignment:
local a = 1
local long_variable = 2
local x = 3

-- After ga2j= (align next 2 lines on =):
local a             = 1
local long_variable = 2
local x             = 3
```

### Mini.sessions

#### Session Management
| Key | Action |
|-----|--------|
| `<leader>ss` | Select session |
| `<leader>sw` | Write session |
| `<leader>sd` | Delete session |

#### Automatic Sessions
Sessions are automatically saved on exit if `autowrite = true` is set.

### Mini.visits

#### Tracking Visits
| Key | Action |
|-----|--------|
| `<leader>vv` | Add visit label |
| `<leader>vV` | Remove visit label |
| `<leader>vl` | List visits |

### Mini.map (Minimap)

#### Minimap Controls
| Key | Action |
|-----|--------|
| `<leader>mm` | Toggle minimap |
| `<leader>mr` | Refresh minimap |
| `<leader>mf` | Focus minimap |

### Mini.trailspace

#### Whitespace Management
| Key | Action |
|-----|--------|
| `<leader>tw` | Trim trailing whitespace |
| `<leader>tl` | Trim trailing empty lines |

## 🐛 Diagnostics & Debugging

### Trouble.nvim

#### Commands
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>xx` | `:Trouble diagnostics toggle` | Toggle diagnostics |
| `<leader>xX` | `:Trouble diagnostics toggle filter.buf=0` | Buffer diagnostics |
| `<leader>cs` | `:Trouble symbols toggle focus=false` | Symbols |
| `<leader>cl` | `:Trouble lsp toggle focus=false win.position=right` | LSP definitions |
| `<leader>xL` | `:Trouble loclist toggle` | Location list |
| `<leader>xQ` | `:Trouble qflist toggle` | Quickfix list |

### Built-in Diagnostics

#### Navigation
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<leader>d` - Show diagnostic in floating window

#### Configuration
```lua
-- Customize diagnostic display
vim.diagnostic.config({
  virtual_text = false,  -- Disable inline diagnostics
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
```

## 🎨 Visual Enhancements

### Mini.animate

#### Features
- Smooth cursor movements
- Window resize animations
- Scroll animations

#### Disabling Animations
```lua
-- Disable specific animations
require("mini.animate").setup({
  cursor = { enable = false },
  scroll = { enable = false },
  resize = { enable = false },
  open = { enable = false },
  close = { enable = false },
})
```

### Mini.cursorword

#### Features
- Highlights word under cursor
- Customizable delay

#### Configuration
```lua
require("mini.cursorword").setup({
  delay = 500,  -- Increase delay to 500ms
})

-- Disable for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.b.minicursorword_disable = true
  end,
})
```

### Mini.hipatterns

#### Pattern Highlighting
- `TODO` - Highlighted in yellow
- `FIXME` - Highlighted in red
- `HACK` - Highlighted in orange
- `NOTE` - Highlighted in blue
- Hex colors (`#ff0000`) - Show actual color

#### Adding Custom Patterns
```lua
require("mini.hipatterns").setup({
  highlighters = {
    -- Custom pattern
    urgent = { pattern = 'URGENT', group = 'ErrorMsg' },
    -- Date pattern
    date = { pattern = '%d%d%d%d%-%d%d%-%d%d', group = 'Comment' },
  },
})
```

### Mini.indentscope

#### Features
- Visual indent guides
- Current scope highlighting
- Customizable symbols

#### Configuration
```lua
require("mini.indentscope").setup({
  symbol = "▏",  -- Change indent symbol
  options = { try_as_border = true },
  draw = {
    delay = 100,
    animation = require("mini.indentscope").gen_animation.none(),  -- Disable animation
  },
})
```

## 🔧 Enabling/Disabling Features

### Completely Disable a Plugin

1. **Method 1: Set enabled = false**
```lua
{
  "plugin-name",
  enabled = false,  -- Plugin won't load
}
```

2. **Method 2: Comment out the plugin**
```lua
-- {
--   "plugin-name",
--   config = function() ... end,
-- }
```

3. **Method 3: Conditional loading**
```lua
{
  "plugin-name",
  enabled = vim.fn.hostname() == "work-laptop",  -- Only on specific machine
}
```

### Disable Plugin for Specific File Types

```lua
-- Example: Disable mini.pairs for markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.b.minipairs_disable = true
  end,
})
```

### Disable LSP for Large Files

```lua
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand("%"))
    if file_size > 1024 * 1024 then  -- 1MB
      vim.cmd("LspStop")
    end
  end,
})
```

### Disable Treesitter for Performance

```lua
-- In treesitter config
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    disable = { "latex", "markdown" },  -- Disable for these filetypes
    -- OR conditionally disable for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
})
```

## 🏥 Health Check and Troubleshooting

### Running Health Checks
Use `:checkhealth` to diagnose configuration issues:
```vim
:checkhealth           " Check all components
:checkhealth conform   " Check specific plugin
:checkhealth which-key " Check which-key configuration
```

### Common Health Check Issues and Solutions

#### Conform.nvim Formatter Warnings
**Issue**: `WARNING black unavailable: Command 'black' not found`

**Solution**: The configuration now automatically detects available formatters and only configures them if installed:
```bash
# Install missing formatters as needed
pip install black             # Python
npm install -g prettier       # JavaScript/TypeScript/HTML/CSS
cargo install stylua          # Lua
```

#### Which-key Deprecation Warnings
**Issue**: `opts.popup_mappings` and `opts.window` are deprecated

**Solution**: ✅ **Fixed** - Configuration updated to use new which-key v3 API:
- `popup_mappings` → `keys`
- `window` → `win` 
- `register()` → `add()` with new spec format

#### Missing System Tools
**Issue**: Various warnings about missing tools (cargo, ruby, java, etc.)

**Solution**: These are optional dependencies. Install only what you need:
```bash
# For Rust development
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# For Node.js/npm dependencies
npm install -g neovim

# For Python integration
pip install neovim
```

#### LSP and Mason Issues
**Issue**: Language servers not working

**Solution**:
1. Open `:Mason`
2. Install required language servers
3. Restart Neovim
4. Run `:checkhealth lspconfig`

### Performance Issues
If Neovim feels slow, try:
1. `:checkhealth` to identify problematic plugins
2. Use `:Lazy profile` to see plugin load times
3. Consider disabling unused features (see performance optimization section below)

## 🎛️ Advanced Configuration

### Creating Custom Commands

```lua
-- Add to lua/config/autocmds.lua
vim.api.nvim_create_user_command("FormatDisable", function()
  vim.g.disable_autoformat = true
end, { desc = "Disable autoformat" })

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.g.disable_autoformat = false
end, { desc = "Enable autoformat" })
```

### Performance Optimization

#### Lazy Loading
```lua
{
  "expensive-plugin",
  lazy = true,
  event = "VeryLazy",  -- Load after startup
  cmd = "PluginCommand",  -- Load on command
  ft = "python",  -- Load for specific filetype
  keys = "<leader>x",  -- Load on keypress
}
```

#### Disable Heavy Features
```lua
-- Disable expensive features for better performance
vim.g.loaded_matchparen = 1  -- Disable matching parentheses
vim.opt.cursorline = false   -- Disable cursor line
vim.opt.relativenumber = false  -- Disable relative numbers
```

### Backup and Restore Settings

#### Save Current Configuration
```bash
cp -r ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d)
```

#### Quick Configuration Switching
```lua
-- Add to init.lua
if vim.fn.exists("$NVIM_MINIMAL") == 1 then
  -- Minimal configuration
  require("config.minimal")
else
  -- Full configuration
  require("config.options")
  require("config.keymaps")
  require("config.autocmds")
  require("lazy").setup("plugins")
end
```

## 🚨 Troubleshooting

### Common Issues and Solutions

#### Plugin Not Working
1. Check if it's installed: `:Lazy`
2. Update plugins: `:Lazy sync`
3. Check for errors: `:messages`
4. Restart Neovim

#### LSP Not Starting
1. Check Mason: `:Mason`
2. Check LSP status: `:LspInfo`
3. Check if server is in PATH
4. Restart LSP: `:LspRestart`

#### Slow Startup
1. Profile startup: `:Lazy profile`
2. Disable heavy plugins temporarily
3. Use lazy loading
4. Check for conflicting plugins

#### Keybinding Conflicts
1. Check current mappings: `:map <key>`
2. Use `:verbose map <key>` to see where it's defined
3. Check for plugin conflicts

### Getting Help

- `:help <topic>` - Built-in help
- `:Telescope help_tags` - Search help
- `:checkhealth` - Health check
- `:messages` - Recent messages
- `:LspLog` - LSP logs

## 📖 Further Reading

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [Mini.nvim Documentation](https://github.com/echasnovski/mini.nvim)
- [LSP Configuration Guide](https://github.com/neovim/nvim-lspconfig)

---

This guide covers the most common use cases and configurations. For plugin-specific advanced features, refer to their individual documentation using `:help <plugin-name>` or visiting their GitHub repositories.