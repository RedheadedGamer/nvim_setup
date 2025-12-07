# 📚 Comprehensive Plugin Usage Guide

This guide provides detailed instructions on how to use all the plugins in this Neovim configuration, including how to enable/disable features and configure them to your preferences.

## 🔬 C/C++ Development Guide

### Overview
This configuration provides a complete C/C++ development environment with advanced LSP support, debugging, project management, and static analysis.

### Core Features
- **Enhanced clangd LSP** with duplicate prevention and advanced features
- **CMake integration** for project building and management
- **Advanced debugging** with DAP (Debug Adapter Protocol)
- **Static analysis** with cppcheck and clang-tidy (via clangd)
- **Header/source switching** and symbol navigation
- **Inlay hints** and AST viewing
- **Smart completion** and diagnostics

### 🛠️ C/C++ Specific Keybindings

#### Project Management (CMake)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cg` | CMakeGenerate | Generate CMake build files |
| `<leader>cb` | CMakeBuild | Build the project |
| `<leader>cr` | CMakeRun | Run the project |
| `<leader>cd` | CMakeDebug | Debug the project |
| `<leader>cc` | CMakeClean | Clean build artifacts |
| `<leader>ct` | CMakeSelectBuildTarget | Select build target |
| `<leader>cT` | CMakeSelectBuildType | Select build type (Debug/Release) |

#### Debugging (nvim-dap)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>db` | ToggleBreakpoint | Toggle breakpoint at current line |
| `<leader>dB` | ConditionalBreakpoint | Set conditional breakpoint |
| `<leader>dc` | Continue | Continue execution |
| `<leader>di` | StepInto | Step into function |
| `<leader>do` | StepOver | Step over function |
| `<leader>dO` | StepOut | Step out of function |
| `<leader>dr` | OpenREPL | Open debug REPL |
| `<leader>du` | ToggleUI | Toggle debug UI |
| `<leader>dx` | Terminate | Terminate debug session |

#### Code Navigation & Analysis
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ch` | SwitchHeaderSource | Switch between header and source |
| `<leader>cI` | ClangdSwitchSourceHeader | Clangd header/source switch |
| `<leader>cH` | ToggleInlayHints | Toggle inlay hints |
| `<leader>cA` | ShowAST | Show Abstract Syntax Tree |
| `<leader>cS` | SymbolInfo | Show symbol information |
| `<leader>cM` | MemoryUsage | Show clangd memory usage |
| `<leader>cl` | LintFile | Lint current C/C++ file |

#### LSP Features (Enhanced)
| Key | Command | Description |
|-----|---------|-------------|
| `gd` | GoToDefinition | Go to symbol definition |
| `gi` | GoToImplementation | Go to implementation |
| `gr` | GoToReferences | Show all references |
| `gy` | GoToTypeDefinition | Go to type definition |
| `K` | HoverDoc | Show hover documentation (no duplicates) |
| `<leader>rn` | Rename | Rename symbol |
| `<leader>ca` | CodeAction | Show code actions |
| `<leader>lf` | Format | Format buffer |
| `[d` / `]d` | PrevNextDiagnostic | Navigate diagnostics |

### 🔧 Configuration Details

#### Enhanced clangd Configuration
The clangd LSP is configured with advanced options:
```lua
cmd = { 
  "clangd", 
  "--background-index",
  "--clang-tidy",
  "--header-insertion=iwyu",
  "--completion-style=detailed",
  "--function-arg-placeholders",
  "--fallback-style=llvm",
  -- Force clangd to query GCC for system headers across all platforms
  "--query-driver=**/*gcc*,**/*g++*,**/*clang*,**/*clang++*",
}
```

**Cross-Platform Header Checking:**
The `--query-driver` flag forces clangd to query GCC (and Clang) compilers for their system header paths on all platforms (Windows, macOS, and Linux). This ensures consistent header detection and error checking regardless of the platform or compiler installation.

#### Project Detection
The configuration automatically detects C/C++ projects by looking for:
- `Makefile`
- `CMakeLists.txt`
- `compile_commands.json`
- `compile_flags.txt`
- Git repositories
- Common build system files

#### Debugging Support
Two debuggers are configured:
1. **CodeLLDB** (recommended) - Modern LLVM-based debugger
2. **GDB** - Traditional GNU debugger

#### Static Analysis
Automatic linting with:
- **cppcheck** - Static analysis tool (via nvim-lint)
- **clang-tidy** - Clang-based code checker (integrated in clangd LSP)

### 📦 Required Tools for C Development

#### Essential Tools
```bash
# Ubuntu/Debian
sudo apt install build-essential cmake gdb clang clangd cppcheck

# Arch Linux  
sudo pacman -S base-devel cmake gdb clang clang-tools cppcheck

# macOS
brew install cmake llvm cppcheck
```

#### Optional but Recommended
```bash
# CodeLLDB debugger (via Mason or system package manager)
# Bear (for compile_commands.json generation)
# Ninja build system
sudo apt install bear ninja-build  # Ubuntu
sudo pacman -S bear ninja          # Arch
brew install bear ninja            # macOS
```

### 🚀 Getting Started with C Development

#### 1. Open a C Project
```bash
cd /path/to/your/c/project
nvim .
```

#### 2. Generate Compilation Database
For better LSP support, generate `compile_commands.json`:

**With CMake:**
```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
```

**With Bear (for Makefiles):**
```bash
bear -- make
```

#### 3. Install LSP and Tools
```bash
# In Neovim
:Mason
# Install: clangd, codelldb  (cppcheck via system package manager)
```

#### 4. Build and Debug
```bash
<leader>cg  # Generate CMake files
<leader>cb  # Build project
<leader>db  # Set breakpoints
<leader>cd  # Start debugging
```

### 🔍 Troubleshooting C Development

#### LSP Duplication Prevention
This configuration prevents LSP diagnostic duplication by:
- Using clangd's built-in clang-tidy (via `--clang-tidy` flag)
- Using nvim-lint only for cppcheck static analysis
- Implementing focus_id handlers to prevent multiple hover/diagnostic windows

#### LSP Not Working
1. Check clangd installation: `:LspInfo`
2. Ensure `compile_commands.json` exists
3. Restart LSP: `<leader>lr`
4. Check Mason: `:Mason`

#### No Debugging Support
1. Install codelldb: `:Mason` → search codelldb
2. Check executable path in DAP config
3. Ensure debug symbols: compile with `-g` flag

#### Linting Issues
1. Install cppcheck via Mason or system package manager
2. clang-tidy is integrated in clangd LSP - no separate installation needed
3. Check file patterns in autocmd
4. Manual lint: `<leader>cl`

#### Header/Source Switching Not Working
1. Ensure proper project structure
2. Files should be in same or related directories
3. Common extensions: `.c/.h`, `.cpp/.hpp`, `.cc/.hh`

### 📈 Performance Tips

#### Large Projects
- Use `compile_commands.json` for faster indexing
- Enable clangd background indexing (default)
- Consider disabling semantic highlighting for very large files

#### Memory Usage
- Monitor clangd memory: `<leader>cM`
- Adjust max file size for LSP in large codebases
- Use project-specific .clangd config files

### 🎯 Advanced Features

#### Inlay Hints
Enable type hints and parameter names:
```bash
<leader>cH  # Toggle inlay hints
```

#### AST Exploration
View the Abstract Syntax Tree:
```bash
<leader>cA  # Show AST for current file/selection
```

#### Symbol Information
Get detailed symbol information:
```bash
<leader>cS  # Show symbol details
```

## 🚀 Quick Start

### Essential Commands to Know
- `:Lazy` - Open plugin manager (install, update, remove plugins)
- `:Mason` - Open LSP server manager
- `:checkhealth` - Diagnose configuration issues
- `:help <plugin-name>` - Get help for any plugin

## ⌨️ Enhanced Keymap Discovery System

### Features
- **Comprehensive keymap browser** showing ALL keymaps across all modes
- **Mode-specific viewers** for focused discovery
- **Which-key integration** with modern API (v3.0+ compatible)
- **Global keymap access** beyond just leader keys
- **Organized key groups** for better discovery

### Keymap Discovery Commands
| Command | Description | Coverage |
|---------|-------------|----------|
| `<leader>fK` | **All Keymaps Browser** | Every keymap in all modes |
| `<leader>fk` | Standard keymaps | Basic telescope keymaps |
| `<leader>fkn` | Normal mode keymaps | Normal mode only |
| `<leader>fkv` | Visual mode keymaps | Visual/select modes |
| `<leader>fki` | Insert mode keymaps | Insert mode only |
| `<leader>?` | Buffer local keymaps | Current buffer |
| `<leader><leader>?` | **Global keymaps** | All global mappings |

### Enhanced Features
- **Vertical layout** with preview for better readability
- **Mode filtering** for focused discovery  
- **Enhanced UI** with better titles and organization
- **Direct access** from start screen discovery section

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
| `<leader>n` | Notification operations/new tab |
| `g` | Goto/operators |
| `s` | Surround operations |
| `<M-hjkl>` | Move operations (Alt+direction) |

### Recent Key Conflict Resolutions
To avoid conflicts and improve organization:
- **Terminal**: `<leader>te` (was `<leader>t;`) - Avoids conflicts with toggles
- **New Tab**: `<leader>nt` (was `<leader>tn`) - Logical grouping under "new"
- **Toggles**: Preserved `<leader>tn`, `<leader>tr` for line numbers/relative numbers

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

### Enhanced Theme Switcher
The theme switcher has been **completely redesigned** to fix infinite indenting issues:

- **🔭 Telescope Integration**: Uses Telescope's built-in colorscheme picker 
- **📱 Live Preview**: See themes instantly as you browse
- **🎯 No More Infinite Indenting**: Fixed the UI scrolling bug
- **⚡ Fast Navigation**: Smooth selection with arrow keys

### Available Themes
The configuration includes **38+ high-quality themes**:

#### Core Themes
```vim
:colorscheme tokyonight-night    :colorscheme gruvbox
:colorscheme dracula             :colorscheme catppuccin-mocha  
:colorscheme nord                :colorscheme rose-pine
:colorscheme kanagawa            :colorscheme onedark_dark
```

#### New Premium Themes
```vim
:colorscheme sonokai             :colorscheme edge
:colorscheme everforest          :colorscheme gruvbox-material
:colorscheme material            :colorscheme vscode  
:colorscheme github_dark         :colorscheme onedark
:colorscheme darkplus            :colorscheme aurora
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
Use `<leader>tt` or `<leader>th` to open the enhanced Telescope theme switcher with:
- **Live preview** of all available themes
- **Fuzzy search** to quickly find themes by name
- **Instant application** - no more UI bugs!

## 🚀 Enhanced Start Screen (Mini.starter)

### Features
The start screen has been completely redesigned with:
- **Beautiful ASCII art header** with personalized greeting
- **Organized sections** for different types of actions
- **Plugin statistics** showing load time and plugin count
- **Quick access** to common tasks and recent files

### Sections Available
1. **📝 Quick Actions** - New file, find files, live grep, recent files
2. **🔍 Discovery** - Browse keymaps, commands, help, global keymaps  
3. **🎨 Customize** - Theme switcher, buffers, edit config, edit keymaps
4. **🔧 Management** - Plugin manager, LSP manager, health check, sync plugins
5. **💾 Sessions** - Load and save workspace sessions
6. **Recent Files** - Recently opened files (local and global)
7. **Builtin Actions** - Edit config, new file, quit

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

#### Auto-pairing Features
Automatically closes:
- `()` parentheses
- `[]` brackets  
- `{}` braces
- `""` quotes
- `''` single quotes
- `` ` `` backticks

#### Enhanced Configuration
- Smart neighborhood pattern detection
- Escape sequence awareness
- Command and terminal mode exclusion for better UX
- Customizable bracket insertion behavior

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

### Rainbow Brackets
Enhanced bracket visibility with rainbow coloring:
- **Multi-level highlighting**: Different colors for nested brackets
- **Treesitter integration**: Smart parsing for accurate highlighting  
- **Multiple languages**: Supports Lua, Python, JavaScript, and more
- **Visual clarity**: Makes deeply nested code easier to read

#### Bracket Colors
1. Red
2. Yellow
3. Blue
4. Orange
5. Green
6. Violet
7. Cyan

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

### Built-in Diagnostics (Enhanced)

#### Auto-Hover Feature ✨
- **Automatic popup display**: Diagnostics automatically appear when hovering over problematic code (300ms delay)
- **Non-intrusive**: Popups disappear when cursor moves, keeping your workflow smooth
- **Toggle control**: Use `<leader>lh` to enable/disable auto-hover diagnostics

#### Enhanced Navigation
- `[d` / `]d` - Previous/Next diagnostic (any severity)
- `[e` / `]e` - Previous/Next **error** only
- `[w` / `]w` - Previous/Next **warning** only
- `<leader>ld` - Manually show diagnostic popup
- `<leader>ll` - Open diagnostics in location list
- `<leader>lq` - Open diagnostics in quickfix list

#### Visual Improvements
- **Enhanced icons**: ❌ Errors, ⚠️ Warnings, 💡 Hints, ℹ️ Info
- **Better borders**: Rounded corners for floating windows
- **Source display**: Always shows diagnostic source (LSP server, linter, etc.)
- **Severity sorting**: Most severe issues appear first

#### Auto-Hover Configuration
```lua
-- Auto-hover is enabled by default with these settings:
vim.opt.updatetime = 300  -- 300ms delay before hover
vim.diagnostic.config({
  float = {
    focusable = false,     -- Don't steal focus
    border = "rounded",    -- Nice rounded borders
    source = "always",     -- Show diagnostic source
  }
})
```

#### Keybindings Summary
| Key | Command | Description |
|-----|---------|-------------|
| `[d` / `]d` | Navigate diagnostics | Any severity |
| `[e` / `]e` | Navigate errors | Errors only |
| `[w` / `]w` | Navigate warnings | Warnings only |
| `<leader>ld` | Show diagnostic | Manual popup |
| `<leader>lh` | Toggle auto-hover | Enable/disable automatic popups |

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

### Enhanced Transparency System
This configuration includes **comprehensive transparency support** with 80+ UI elements configured:

#### Covered UI Elements
- **Core Neovim**: Normal, Float, Popup, Status, Tab, Line numbers
- **Telescope**: All telescope windows and borders
- **Which-key**: Popup, borders, and content areas  
- **Mini.nvim**: All mini plugins (starter, files, pick, map, notify, etc.)
- **LSP**: Floating windows, borders, and diagnostic displays
- **Plugin Managers**: Lazy.nvim, Mason.nvim with all components
- **Git Integration**: GitSigns and diff displays
- **Completion**: nvim-cmp windows and documentation
- **Notifications**: nvim-notify and all notification types

#### Persistence Across Themes
Transparency is automatically applied:
- On Neovim startup (VimEnter autocmd)
- After colorscheme changes (ColorScheme autocmd)  
- For all supported themes in the configuration

#### Disabling Transparency
To disable transparency for specific themes:
```lua
-- In lua/plugins/init.lua, modify theme setup
require("tokyonight").setup({
  style = "night",
  transparent = false,  -- Disable transparency
})
```

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

## 🚀 Advanced C/C++ Development Recommendations

### Performance Optimizations for Large C Projects

#### 1. Incremental Compilation
Configure clangd for better performance with large codebases:
```lua
-- Add to your clangd configuration
clangd = {
  cmd = { 
    "clangd", 
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
    "--pch-storage=memory",  -- Store PCH in memory for speed
    "--index",               -- Enable background indexing
    "--j=4",                 -- Use 4 threads for indexing
  },
}
```

#### 2. Optimize LSP for Large Files
```lua
-- Add to your configuration for better performance
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*.{c,cpp,h,hpp}",
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand("%"))
    if file_size > 1024 * 1024 then  -- 1MB threshold
      vim.notify("Large file detected, disabling some LSP features", vim.log.levels.WARN)
      vim.b.lsp_enabled = false
    end
  end,
})
```

#### 3. Project-Specific Configuration
Create `.clangd` files in your project root:
```yaml
# .clangd file for project-specific settings
CompileFlags:
  Add: [-std=c++17, -Wall, -Wextra]
  Remove: [-W*]
Diagnostics:
  ClangTidy:
    Add: [performance-*, readability-*]
    Remove: [misc-*]
Index:
  Background: Build
  StandardLibrary: Yes
```

### Essential Additional Plugins for C Development

#### 1. Advanced Project Management
```lua
-- Better project detection and management
{
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "Makefile", "CMakeLists.txt", "compile_commands.json" },
      silent_chdir = true,
      scope_chdir = 'global',
    })
  end
}
```

#### 2. Enhanced Build Integration
```lua
-- Asynchronous build system
{
  "skywind3000/asyncrun.vim",
  cmd = {"AsyncRun", "AsyncStop"},
  config = function()
    vim.g.asyncrun_open = 6  -- Open quickfix window with height 6
    vim.keymap.set("n", "<leader>bb", ":AsyncRun make<CR>", { desc = "Async Build" })
    vim.keymap.set("n", "<leader>bc", ":AsyncRun make clean<CR>", { desc = "Async Clean" })
    vim.keymap.set("n", "<leader>bt", ":AsyncRun make test<CR>", { desc = "Async Test" })
  end
}
```

#### 3. Code Quality Tools
```lua
-- Better formatting for C/C++
{
  "rhysd/vim-clang-format",
  ft = {"c", "cpp"},
  config = function()
    vim.g["clang_format#style_options"] = {
      BasedOnStyle = "LLVM",
      IndentWidth = 4,
      TabWidth = 4,
      UseTab = "Always",
      ColumnLimit = 120,
    }
    vim.keymap.set("n", "<leader>cf", ":ClangFormat<CR>", { desc = "Clang Format" })
  end
}
```

#### 4. Enhanced Documentation
```lua
-- Doxygen integration
{
  "vim-scripts/DoxygenToolkit.vim",
  ft = {"c", "cpp"},
  config = function()
    vim.g.DoxygenToolkit_briefTag_pre = "@brief  "
    vim.g.DoxygenToolkit_paramTag_pre = "@param "
    vim.g.DoxygenToolkit_returnTag = "@return   "
    vim.keymap.set("n", "<leader>dx", ":Dox<CR>", { desc = "Generate Doxygen" })
  end
}
```

### Workflow Enhancements

#### 1. Smart Error Navigation
```lua
-- Navigate through compile errors efficiently
vim.keymap.set("n", "<leader>en", ":cnext<CR>", { desc = "Next Error" })
vim.keymap.set("n", "<leader>ep", ":cprev<CR>", { desc = "Previous Error" })
vim.keymap.set("n", "<leader>eo", ":copen<CR>", { desc = "Open Error List" })
vim.keymap.set("n", "<leader>ec", ":cclose<CR>", { desc = "Close Error List" })
```

#### 2. Quick Header Guards
```lua
-- Auto-generate header guards
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.{h,hpp}",
  callback = function()
    local filename = vim.fn.expand("%:t:r"):upper() .. "_H"
    local guard = string.gsub(filename, "[^%w_]", "_")
    local lines = {
      "#ifndef " .. guard,
      "#define " .. guard,
      "",
      "",
      "",
      "#endif /* " .. guard .. " */"
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, {4, 0})
  end,
})
```

#### 3. Smart Include Management
```lua
-- Auto-sort includes
vim.api.nvim_create_user_command("SortIncludes", function()
  vim.cmd([[%s/^\s*#include.*$/\=submatch(0)/]])
  vim.cmd([[sort /\(["<]\)/]])
end, {})

vim.keymap.set("n", "<leader>si", ":SortIncludes<CR>", { desc = "Sort Includes" })
```

### Testing and Debugging Enhancements

#### 1. Unit Testing Integration
```lua
-- Google Test integration
{
  "vim-test/vim-test",
  dependencies = {"preservim/vimux"},
  ft = {"c", "cpp"},
  config = function()
    vim.g["test#strategy"] = "vimux"
    vim.g["test#cpp#gtest#executable"] = "./build/tests"
    vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Test Nearest" })
    vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Test File" })
    vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", { desc = "Test Suite" })
  end
}
```

#### 2. Memory Debugging
```lua
-- Valgrind integration
vim.api.nvim_create_user_command("Valgrind", function(opts)
  local cmd = "AsyncRun valgrind --tool=memcheck --leak-check=full " .. opts.args
  vim.cmd(cmd)
end, { nargs = 1, complete = "file" })

vim.keymap.set("n", "<leader>vm", function()
  local executable = vim.fn.input("Executable: ", "./", "file")
  vim.cmd("Valgrind " .. executable)
end, { desc = "Run Valgrind" })
```

### Recommended Workflow

1. **Project Setup**:
   ```bash
   cd your_project
   cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -Bbuild
   ln -s build/compile_commands.json .
   ```

2. **Development Cycle**:
   - `<leader>cg` → Generate build files
   - `<leader>cb` → Build project
   - `<leader>db` → Set breakpoints
   - `<leader>cd` → Debug session
   - `<leader>ct` → Run tests

3. **Code Quality**:
   - `<leader>cl` → Lint code
   - `<leader>cf` → Format code
   - `<leader>vm` → Memory check
   - `<leader>si` → Sort includes

This comprehensive setup provides a professional C/C++ development environment with all the tools needed for modern development practices.