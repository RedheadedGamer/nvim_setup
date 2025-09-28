# Neovim Configuration

A modern, feature-rich Neovim configuration written in Lua with **complete mini.nvim ecosystem integration** (28 plugins), LSP support, auto-completion, and optimized performance for enhanced development experience.

## ✨ Features

- **Modern Lua Configuration**: Fully migrated from VimScript to Lua for better performance and maintainability
- **Native LSP Support**: Built-in Language Server Protocol with intelligent code completion, diagnostics, and navigation
- **🔬 Advanced C/C++ Development**: Complete development environment with enhanced clangd, CMake integration, debugging, and static analysis
- **Plugin Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, lazy-loaded plugin management
- **Auto-completion**: Powerful completion engine with [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) replacing CoC
- **Complete Mini.nvim Ecosystem**: All 28 mini.nvim plugins for comprehensive development tools
- **170+ Keybinds**: Comprehensive keybind system with which-key integration for discoverability
- **Optimized Performance**: Streamlined configuration with curated high-quality themes
- **Smart Movement**: Mini.move integration for moving lines and selections with Alt+hjkl
- **Enhanced Bracket Matching**: Improved bracket/parenthesis visibility with rainbow colors and smart matching
- **Advanced Text Objects**: Enhanced editing with mini.ai, mini.surround, and mini.operators
- **Visual Enhancements**: Smooth animations, minimap, indent guides, and status indicators
- **Tab-based Indentation**: Configured to use actual tabs (noexpandtab) for consistent formatting
- **Fuzzy Finding**: Telescope integration for file finding, searching, and more
- **Syntax Highlighting**: Enhanced syntax highlighting with Treesitter
- **Multiple Themes**: 50+ beautiful colorschemes with enhanced theme switcher (fixed infinite indenting issue)
- **LaTeX Support**: VimTeX integration for LaTeX document editing
- **Transparent Background**: Configured for transparent terminal backgrounds
- **Enhanced Transparency**: 80+ UI elements configured for full transparency support  
- **Custom .wistl Filetype**: Specialized support for .wistl files

## 🚀 Installation

### Prerequisites

- **Neovim >= 0.9.0**
- **Git**
- **Node.js** (for LSP servers)
- **Python** (for Python LSP support)
- **ripgrep** (for better grep functionality)
- **🔬 C/C++ Development** (optional but recommended):
  - **build-essential** or equivalent (gcc, make, etc.)
  - **cmake** (for CMake projects)
  - **clang** and **clang-tools** (for enhanced LSP)
  - **gdb** or **codelldb** (for debugging)
  - **cppcheck** (for static analysis)

#### Ubuntu/Debian Installation:
```bash
sudo apt update
sudo apt install neovim git nodejs npm python3 python3-pip ripgrep

# For C/C++ development (recommended)
sudo apt install build-essential cmake gdb clang clang-tools cppcheck bear ninja-build
```

#### Arch Installation:
```bash
sudo pacman -Syu neovim git nodejs npm python3 python3-pip ripgrep

# For C/C++ development (recommended)  
sudo pacman -S base-devel cmake gdb clang clang-tools cppcheck bear ninja
```

#### macOS Installation:
```bash
brew install neovim git node python ripgrep

# For C/C++ development (recommended)
brew install cmake llvm cppcheck bear ninja
```

### Setup Instructions

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/RedheadedGamer/nvim_setup.git ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```
   
   The configuration will automatically:
   - Install the lazy.nvim plugin manager
   - Download and install all plugins
   - Set up LSP servers through Mason

4. **Wait for installation to complete**, then restart Neovim.

### Legacy Fallback

If you encounter issues with the new Lua configuration, you can fallback to the original VimScript configuration:

```bash
cd ~/.config/nvim
mv init.lua init.lua.backup
mv init.vim.legacy init.vim
```

## 🔧 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main configuration entry point
├── init.vim.legacy         # Original VimScript configuration (fallback)
├── lua/
│   ├── config/
│   │   ├── options.lua     # Editor options and settings
│   │   ├── keymaps.lua     # Key mappings
│   │   └── autocmds.lua    # Autocommands
│   └── plugins/
│       └── init.lua        # Plugin specifications and configurations
```

## ⌨️ Key Mappings

### General
| Key | Mode | Action |
|-----|------|--------|
| `<Space>` | Normal | Leader key |
| `<Esc>` | Normal | Clear search highlighting |
| `<C-h/j/k/l>` | Normal | Navigate windows |

### LSP (replaces CoC functionality)
| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gy` | Normal | Go to type definition |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | Go to references |
| `K` | Normal | Show hover documentation (no duplicates) |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code actions |
| `<leader>f` | Normal | Format code |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |

### 🔬 C/C++ Development
| Key | Mode | Action |
|-----|------|--------|
| `<leader>cg` | Normal | CMake Generate |
| `<leader>cb` | Normal | CMake Build |
| `<leader>cr` | Normal | CMake Run |
| `<leader>cd` | Normal | CMake Debug |
| `<leader>cc` | Normal | CMake Clean |
| `<leader>ch` | Normal | Switch Header/Source |
| `<leader>cl` | Normal | Lint C/C++ file |
| `<leader>db` | Normal | Toggle Breakpoint |
| `<leader>dc` | Normal | Debug Continue |
| `<leader>di` | Normal | Debug Step Into |
| `<leader>do` | Normal | Debug Step Over |
| `<leader>dO` | Normal | Debug Step Out |
| `<leader>du` | Normal | Toggle Debug UI |

### ⚙️ Assembly Language Development
| Key | Mode | Action |
|-----|------|--------|
| `<leader>ac` | Normal | Comment assembly line |
| `<leader>au` | Normal | Uncomment assembly line |
| `K` | Normal | Hover documentation (assembly) |
| `gd` | Normal | Go to definition (labels/macros) |
| `gr` | Normal | Find references (assembly) |

### Telescope
| Key | Mode | Action |
|-----|------|--------|
| `<leader>ff` | Normal | Find files |
| `<leader>fg` | Normal | Live grep |
| `<leader>fb` | Normal | Find buffers |
| `<leader>fh` | Normal | Help tags |

### Trouble (Diagnostics)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>xx` | Normal | Toggle Trouble |
| `<leader>xw` | Normal | Workspace diagnostics |
| `<leader>xd` | Normal | Document diagnostics |

### Mini Plugins (Quality of Life)
| Key | Mode | Action |
|-----|------|--------|
| `sa` | Normal/Visual | Add surrounding |
| `sd` | Normal | Delete surrounding |
| `sr` | Normal | Replace surrounding |
| `sf` | Normal | Find surrounding (right) |
| `sF` | Normal | Find surrounding (left) |
| `sh` | Normal | Highlight surrounding |
| `<M-h/j/k/l>` | Normal/Visual | Move lines/selection |
| `<leader>e` | Normal | Open file explorer |
| `<leader>bd` | Normal | Delete buffer (keep layout) |
| `<leader>bD` | Normal | Force delete buffer |
| `gS` | Normal | Toggle split/join function arguments |
| `g=` | Normal | Evaluate text and replace with result |
| `gx` | Normal | Exchange text regions |
| `gm` | Normal | Multiply (duplicate) text |
| `gr` | Normal | Replace text with register |
| `gs` | Normal | Sort text |
| `<leader>tw` | Normal | Trim trailing whitespace |
| `<leader>tl` | Normal | Trim trailing empty lines |
| `<leader>vv` | Normal | Add visit label |
| `<leader>vV` | Normal | Remove visit label |
| `<leader>vl` | Normal | List visits |
| `<leader>ss` | Normal | Select session |
| `<leader>sw` | Normal | Write session |
| `<leader>sd` | Normal | Delete session |
| `ga` | Normal/Visual | Start text alignment |
| `gA` | Normal/Visual | Start alignment with preview |
| `gh` | Normal | Apply diff hunk |
| `gH` | Normal | Reset diff hunk |
| `[h` / `]h` | Normal | Previous/Next diff hunk |
| `[H` / `]H` | Normal | First/Last diff hunk |
| `<leader>gc` | Normal | Git: Show at cursor |
| `<leader>gd` | Normal | Git: Show diff source |
| `]c` / `[c` | Normal | Next/Previous git hunk |
| `<leader>hs` | Normal/Visual | Stage hunk |
| `<leader>hr` | Normal/Visual | Reset hunk |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hR` | Normal | Reset buffer |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame line |
| `<leader>tb` | Normal | Toggle blame |
| `<leader>hd` | Normal | Diff this |
| `<CR>` | Normal | Start 2D jumping |
| `<leader>mm` | Normal | Toggle minimap |
| `<leader>mr` | Normal | Refresh minimap |
| `<leader>mf` | Normal | Focus minimap |
| `<leader>z` | Normal | Zoom current window |
| `<leader>pf` | Normal | Pick files |
| `<leader>pg` | Normal | Pick grep live |
| `<leader>pb` | Normal | Pick buffers |
| `<leader>ph` | Normal | Pick help |

## 📚 Comprehensive Plugin Guide

For detailed instructions on using all plugins, customizing features, and troubleshooting, see the **[Complete Plugin Usage Guide](PLUGIN_GUIDE.md)**.

**Quick links to common tasks:**
- [🔧 Enable/Disable Features](PLUGIN_GUIDE.md#-enablingdisabling-features)
- [🎯 Git & SSH Setup](PLUGIN_GUIDE.md#-git-integration)
- [🎨 Theme Customization](PLUGIN_GUIDE.md#-theme-management)
- [🚨 Troubleshooting](PLUGIN_GUIDE.md#-troubleshooting)
- [⚡ Performance Optimization](PLUGIN_GUIDE.md#-advanced-configuration)

## 🔌 Included Plugins

### Core Functionality
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Lua utility functions

### Quality of Life (Mini.nvim Collection)
- **[mini.pairs](https://github.com/echasnovski/mini.pairs)** - Enhanced auto-close brackets, quotes, and parentheses with smart pattern detection
- **[mini.surround](https://github.com/echasnovski/mini.surround)** - Surround text with brackets, quotes, tags, etc.
- **[mini.indentscope](https://github.com/echasnovski/mini.indentscope)** - Visualize and operate on indent scope
- **[mini.move](https://github.com/echasnovski/mini.move)** - Move any selection in any direction
- **[mini.ai](https://github.com/echasnovski/mini.ai)** - Better text objects (around/inside)
- **[mini.jump](https://github.com/echasnovski/mini.jump)** - Jump to next/previous single character
- **[mini.files](https://github.com/echasnovski/mini.files)** - Navigate and manipulate file system
- **[mini.statusline](https://github.com/echasnovski/mini.statusline)** - Minimal and fast statusline
- **[mini.bufremove](https://github.com/echasnovski/mini.bufremove)** - Better buffer deletion without losing layout
- **[mini.starter](https://github.com/echasnovski/mini.starter)** - Beautiful start screen with recent files
- **[mini.animate](https://github.com/echasnovski/mini.animate)** - Smooth animations for cursor, scroll, resize, and windows
- **[mini.cursorword](https://github.com/echasnovski/mini.cursorword)** - Highlight word under cursor
- **[mini.hipatterns](https://github.com/echasnovski/mini.hipatterns)** - Highlight patterns like TODO, FIXME, hex colors
- **[mini.splitjoin](https://github.com/echasnovski/mini.splitjoin)** - Split/join function arguments and arrays
- **[mini.trailspace](https://github.com/echasnovski/mini.trailspace)** - Show and remove trailing whitespace
- **[mini.operators](https://github.com/echasnovski/mini.operators)** - Additional operators (evaluate, exchange, multiply, replace, sort)
- **[mini.visits](https://github.com/echasnovski/mini.visits)** - Track and navigate recently visited files
- **[mini.sessions](https://github.com/echasnovski/mini.sessions)** - Session management for workspace persistence
- **[mini.align](https://github.com/echasnovski/mini.align)** - Text alignment with `ga` and `gA`
- **[mini.bracketed](https://github.com/echasnovski/mini.bracketed)** - Go to next/previous targets (buffers, files, diagnostics, etc.)
- **[mini.diff](https://github.com/echasnovski/mini.diff)** - Work with diff hungs and git changes
- **[mini.extra](https://github.com/echasnovski/mini.extra)** - Extra textobjects and pickers
- **[mini.fuzzy](https://github.com/echasnovski/mini.fuzzy)** - Fuzzy matching algorithms
- **[mini.icons](https://github.com/echasnovski/mini.icons)** - Icon provider for various contexts
- **[mini.jump2d](https://github.com/echasnovski/mini.jump2d)** - Jump to any position with Enter
- **[mini.map](https://github.com/echasnovski/mini.map)** - Window with buffer text overview (minimap)
- **[mini.misc](https://github.com/echasnovski/mini.misc)** - Miscellaneous functions (zoom, put, setup, etc.)
- **[mini.pick](https://github.com/echasnovski/mini.pick)** - Pick anything (alternative to telescope)
- **[mini.tabline](https://github.com/echasnovski/mini.tabline)** - Tabline with customizable appearance

### Visual Enhancements
- **[rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)** - Rainbow colored brackets and parentheses for better code readability

### LSP & Completion
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configurations
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP server management
- **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)** - Mason-LSP integration
- **[mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)** - Automatic tool installation
- **[mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim)** - Mason-DAP integration for debuggers
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Completion engine
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine

### 🔬 C/C++ Development Suite
- **[clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim)** - Enhanced clangd features with inlay hints and AST viewing
- **[cmake-tools.nvim](https://github.com/Civitasv/cmake-tools.nvim)** - Complete CMake integration for project management
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** - Debug Adapter Protocol with codelldb and gdb support
- **[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)** - Beautiful debugging interface
- **[nvim-lint](https://github.com/mfussenegger/nvim-lint)** - Static analysis with cppcheck (if installed via system package manager)
- **[vim-lsp-cxx-highlight](https://github.com/jackguo380/vim-lsp-cxx-highlight)** - Enhanced C/C++ syntax highlighting
- **[CurtineIncSw.vim](https://github.com/ericcurtin/CurtineIncSw.vim)** - Header/source file switching

### ⚙️ Assembly Language Development
- **[asm-lsp](https://github.com/bergercookie/asm-lsp)** - Assembly Language Server Protocol support
- **Enhanced NASM support** - Optimized for Intel IA32 instruction set
- **Automatic filetype detection** - `.asm`, `.s`, `.S`, `.nasm`, `.inc` files
- **Assembly-specific settings** - Proper indentation and commenting for assembly
- **Syntax highlighting** - Treesitter-based highlighting for assembly code
- **LSP features** - IntelliSense, hover documentation, and error diagnostics
- **Project integration** - Works with Makefiles and build systems

**Assembly-specific features:**
- NASM/Intel syntax configuration
- Intel IA32 instruction set support  
- Automatic tab-based indentation (assembly convention)
- Assembly comment style (`;` comments)
- Quick comment/uncomment keymaps (`<leader>ac`, `<leader>au`)
- Filetype-specific configuration for `.nasm` and `.asm` files

### UI & Navigation
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[trouble.nvim](https://github.com/folke/trouble.nvim)** - Diagnostics panel
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting

### Git Integration & Version Control
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations, hunks, and blame
- **[vim-fugitive](https://github.com/tpope/vim-fugitive)** - Comprehensive Git wrapper (replaced mini.git)
- **[mini.diff](https://github.com/echasnovski/mini.diff)** - Work with diff hunks and git changes

### Editing & Productivity
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** - Code formatting
- **[vimtex](https://github.com/lervag/vimtex)** - LaTeX support

### Colorschemes & Themes (45+ Premium Themes)
- **[onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim)** - One Dark theme (default)
- **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** - Tokyo Night theme collection
- **[gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)** - Gruvbox theme
- **[dracula.nvim](https://github.com/Mofiqul/dracula.nvim)** - Dracula theme
- **[nord.nvim](https://github.com/shaunsingh/nord.nvim)** - Nord theme
- **[catppuccin](https://github.com/catppuccin/nvim)** - Catppuccin theme collection
- **[nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)** - Nightfox theme collection
- **[rose-pine](https://github.com/rose-pine/neovim)** - Rose Pine theme collection
- **[kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)** - Kanagawa theme collection
- **[sonokai](https://github.com/sainnhe/sonokai)** - High contrast theme
- **[edge](https://github.com/sainnhe/edge)** - Clean and elegant theme
- **[everforest](https://github.com/sainnhe/everforest)** - Green forest theme
- **[gruvbox-material](https://github.com/sainnhe/gruvbox-material)** - Material Gruvbox
- **[material.nvim](https://github.com/marko-cerovac/material.nvim)** - Material Design theme
- **[vscode.nvim](https://github.com/Mofiqul/vscode.nvim)** - VS Code theme
- **[github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)** - Enhanced GitHub themes collection (11 variants with accessibility support)
- **[onedark.nvim](https://github.com/navarasu/onedark.nvim)** - Alternative One Dark
- **[darkplus.nvim](https://github.com/lunarvim/darkplus.nvim)** - Dark+ theme
- **[aurora](https://github.com/ray-x/aurora)** - Aurora theme
- **[material.nvim](https://github.com/marko-cerovac/material.nvim)** - Material theme
- **[monokai.nvim](https://github.com/tanvirtin/monokai.nvim)** - Monokai theme
- **[onedark.nvim](https://github.com/navarasu/onedark.nvim)** - OneDark theme
- **[github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)** - Enhanced GitHub themes collection (11 variants)
- **[sonokai](https://github.com/sainnhe/sonokai)** - Sonokai theme
- **[edge](https://github.com/sainnhe/edge)** - Edge theme

## 🎨 Additional Plugin Recommendations

### 🔬 C/C++ Development Enhancements

#### Essential for Large C Projects
- **[nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)** - Show current function context at top
- **[vim-swap](https://github.com/machakann/vim-swap)** - Swap function arguments and more
- **[nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)** - Better quickfix window for build errors
- **[compiler.nvim](https://github.com/Zeioth/compiler.nvim)** - Compiler integration with async builds
- **[overseer.nvim](https://github.com/stevearc/overseer.nvim)** - Task runner for builds and tests

#### Code Quality & Analysis
- **[nvim-coverage](https://github.com/andythigpen/nvim-coverage)** - Code coverage visualization
- **[ccc.nvim](https://github.com/uga-rosa/ccc.nvim)** - Color picker and highlighter
- **[clang-format.nvim](https://github.com/rhysd/vim-clang-format)** - Clang-format integration
- **[doxygen-toolkit.vim](https://github.com/vim-scripts/DoxygenToolkit.vim)** - Doxygen documentation generator

#### Advanced Debugging & Profiling
- **[nvim-gdb](https://github.com/sakhnik/nvim-gdb)** - Enhanced GDB integration
- **[one-small-step-for-vimkind](https://github.com/jbyuki/one-small-step-for-vimkind)** - Lua debugger for config debugging
- **[nvim-rip-substitute](https://github.com/chrisgrieser/nvim-rip-substitute)** - Better search and replace for refactoring

#### Project Management
- **[project.nvim](https://github.com/ahmedkhalf/project.nvim)** - Automatic project detection
- **[workspaces.nvim](https://github.com/natecraddock/workspaces.nvim)** - Workspace management
- **[neovim-session-manager](https://github.com/Shatur/neovim-session-manager)** - Session persistence
- **[persistence.nvim](https://github.com/folke/persistence.nvim)** - Session management

#### Performance for Large Codebases
- **[nvim-navic](https://github.com/SmiteshP/nvim-navic)** - LSP breadcrumbs in statusline
- **[aerial.nvim](https://github.com/stevearc/aerial.nvim)** - Symbol outline window
- **[symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)** - Tree-like symbol explorer
- **[nvim-lsp-file-operations](https://github.com/antosha417/nvim-lsp-file-operations)** - File operations via LSP

### 🚀 Recommended C Development Workflow Improvements

#### 1. Enhanced Build Integration
```lua
-- Add to your configuration for better build integration
{
  "Zeioth/compiler.nvim",
  cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
  dependencies = { "stevearc/overseer.nvim" },
  opts = {},
}

{
  "stevearc/overseer.nvim",
  commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
  cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
  opts = {
    task_list = {
      direction = "bottom",
      min_height = 25,
      max_height = 25,
      default_detail = 1
    },
  },
}
```

#### 2. Better Error Navigation
```lua
{
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  config = function()
    require("bqf").setup({
      auto_enable = true,
      auto_resize_height = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = {"┃", "━", "┏", "┓", "┗", "┛", "┣", "┫", "┳", "┻"}
      },
    })
  end
}
```

#### 3. Code Coverage Visualization
```lua
{
  "andythigpen/nvim-coverage",
  dependencies = "nvim-lua/plenary.nvim",
  cmd = { "Coverage", "CoverageLoad", "CoverageShow", "CoverageHide", "CoverageToggle" },
  config = function()
    require("coverage").setup({
      commands = true,
      highlights = {
        covered = { fg = "#C3E88D" },
        uncovered = { fg = "#F07178" },
      },
    })
  end,
}
```

### Navigation & File Management
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer with git integration
- **[oil.nvim](https://github.com/stevearc/oil.nvim)** - File manager as a buffer
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - Modern file explorer
- **[flash.nvim](https://github.com/folke/flash.nvim)** - Navigate code with search labels
- **[leap.nvim](https://github.com/ggandor/leap.nvim)** - Lightning-fast movement
- **[harpoon](https://github.com/ThePrimeagen/harpoon)** - Quick file navigation
- **[telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)** - Native FZF sorter for Telescope
- **[telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)** - File browser for Telescope

### Additional Git Integration
- **[lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)** - LazyGit integration
- **[diffview.nvim](https://github.com/sindrets/diffview.nvim)** - Git diff and merge tool
- **[neogit](https://github.com/NeogitOrg/neogit)** - Magit clone for Neovim
- **[octo.nvim](https://github.com/pwntester/octo.nvim)** - GitHub integration
- **[git-blame.nvim](https://github.com/f-person/git-blame.nvim)** - Git blame annotations
- **[gitlinker.nvim](https://github.com/ruifm/gitlinker.nvim)** - Generate git permalinks
- **[git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim)** - Git conflict resolution
- **[fugitive.vim](https://github.com/tpope/vim-fugitive)** - Comprehensive Git wrapper

### UI & Interface Enhancements
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Blazing fast statusline
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Snazzy buffer tabs
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indent guides
- **[nvim-notify](https://github.com/rcarriga/nvim-notify)** - Fancy notification manager
- **[noice.nvim](https://github.com/folke/noice.nvim)** - UI replacement for messages, cmdline, and popupmenu
- **[dressing.nvim](https://github.com/stevearc/dressing.nvim)** - Better UI for vim.ui interfaces
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Key binding popup
- **[alpha-nvim](https://github.com/goolord/alpha-nvim)** - Dashboard/start screen
- **[nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)** - Color highlighting
- **[todo-comments.nvim](https://github.com/folke/todo-comments.nvim)** - Highlight TODO comments

### Development & Editing Tools
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** - Modern surround plugin
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto close brackets/quotes
- **[nvim-spectre](https://github.com/nvim-pack/nvim-spectre)** - Search and replace panel
- **[dial.nvim](https://github.com/monaqa/dial.nvim)** - Extended increment/decrement
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal management
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** - Debug adapter protocol
- **[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)** - UI for nvim-dap
- **[undotree](https://github.com/mbbill/undotree)** - Undo history visualizer
- **[neotest](https://github.com/nvim-neotest/neotest)** - Testing framework
- **[refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)** - Refactoring toolkit

### Session & Project Management
- **[persistence.nvim](https://github.com/folke/persistence.nvim)** - Session management
- **[possession.nvim](https://github.com/jedrzejboczar/possession.nvim)** - Session management
- **[project.nvim](https://github.com/ahmedkhalf/project.nvim)** - Project management
- **[workspaces.nvim](https://github.com/natecraddock/workspaces.nvim)** - Workspace management
- **[neovim-session-manager](https://github.com/Shatur/neovim-session-manager)** - Session manager



### Language-Specific Enhancements
- **[rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim)** - Enhanced Rust support
- **[go.nvim](https://github.com/ray-x/go.nvim)** - Go development tools
- **[typescript.nvim](https://github.com/jose-elias-alvarez/typescript.nvim)** - TypeScript utilities
- **[nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)** - Java LSP enhancements
- **[emmet-vim](https://github.com/mattn/emmet-vim)** - Web development Emmet expansion

### Writing & Documentation
- **[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)** - Markdown preview
- **[obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)** - Obsidian integration
- **[vim-table-mode](https://github.com/dhruvasagar/vim-table-mode)** - Table creation and editing

### Utilities & Extensions
- **[nvim-lastplace](https://github.com/ethanholz/nvim-lastplace)** - Remember cursor position
- **[vim-sleuth](https://github.com/tpope/vim-sleuth)** - Auto-detect indentation
- **[startuptime.vim](https://github.com/dstein64/vim-startuptime)** - Startup time profiler
- **[vim-dadbod](https://github.com/tpope/vim-dadbod)** - Database interface
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal management

## 🔧 Enhanced Mason LSP Configuration

This configuration includes a comprehensive Mason setup that automatically installs and manages:

### 📦 Automatically Installed Tools

**LSP Servers:**
- `lua_ls` - Lua language server
- `pyright` - Python language server  
- `ts_ls` - TypeScript/JavaScript server
- `html`, `cssls`, `jsonls` - Web development servers
- `clangd` - C/C++ language server
- `jdtls` - Java language server
- `cmake` - CMake language server
- `bashls` - Bash/shell script server
- `marksman` - Markdown language server
- `asm_lsp` - Assembly language server (NASM/GAS/MASM/TASM)

**Formatters:**
- `stylua` - Lua code formatter
- `black`, `isort` - Python formatting and import sorting
- `prettier` - Universal web formatter (JS/TS/HTML/CSS/JSON/YAML)
- `clang-format` - C/C++ code formatter
- `shfmt` - Shell script formatter
- `asmfmt` - Assembly code formatter (if available)

**Linters:**
- `pylint` - Python code analysis
- `eslint_d` - Fast JavaScript/TypeScript linting
- `cpplint` - C++ style checker
- `markdownlint` - Markdown linting
- `shellcheck` - Shell script analysis

**Debuggers:**
- `codelldb` - C/C++/Rust debugger
- `debugpy` - Python debugger
- `js-debug-adapter` - JavaScript/TypeScript debugger

### ⚡ Enhanced Features

- **Smart Tool Detection**: Automatically detects tools in both system PATH and Mason installation directory
- **Auto-formatting**: Configurable format-on-save with toggle (`<leader>tf`)
- **Enhanced Linting**: Multi-language linting with Mason integration
- **DAP Integration**: Automatic debugger setup through mason-nvim-dap
- **Tool Information**: View available formatters and linters (`<leader>fi`, `<leader>li`)

### 🎯 Key Mappings for Mason Tools

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>fm` | Format Buffer | Manual formatting |
| `<leader>tf` | Toggle Auto-format | Enable/disable format-on-save |
| `<leader>fi` | Formatter Info | Show available formatters |
| `<leader>ll` | Lint File | Manual linting |
| `<leader>li` | Linter Info | Show available linters |

Access Mason manager with `:Mason` to install/update tools manually.

## 🛠️ Customization

### Adding New Plugins

Edit `lua/plugins/init.lua` and add your plugin specification:

```lua
{
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({
      -- your configuration
    })
  end,
}
```

### Changing Theme

**Enhanced Theme Switcher** (Completely Redesigned!)

Use the enhanced Telescope-based theme switcher:
- Press `<leader>th` or `<leader>tt` to open the **live preview** theme selector
- **🔭 Telescope Integration**: No more infinite indenting issues!
- **📱 Live Preview**: See themes instantly as you browse
- Choose from **45+ premium themes** including material, sonokai, edge, everforest, enhanced GitHub collection, and more
- **⚡ Fuzzy Search**: Quickly find themes by typing part of their name
- Themes are applied instantly with smooth transitions

**Manual Theme Change**

Alternatively, modify the colorscheme in `init.lua`:

```lua
vim.cmd("colorscheme your_preferred_theme")
```

Available themes include:
- `dracula` - Dark vampire theme
- `gruvbox` - Retro groove theme  
- `tokyonight`, `tokyonight-night`, `tokyonight-storm`, `tokyonight-day`
- `catppuccin`, `catppuccin-mocha`, `catppuccin-latte`, `catppuccin-frappe`, `catppuccin-macchiato`
- `nord` - Arctic blue theme
- `rose-pine`, `rose-pine-moon`, `rose-pine-dawn`, `rose-pine-main`
- `kanagawa`, `kanagawa-wave`, `kanagawa-dragon`, `kanagawa-lotus`
- `sonokai` - High contrast elegant theme
- `edge` - Clean and sophisticated theme
- `everforest` - Comfortable green theme
- `gruvbox-material` - Material Design Gruvbox
- `material` - Material Design theme variants
- `vscode` - VS Code theme
- **Enhanced GitHub Themes Collection**:
  - `github_dark` - GitHub's dark theme
  - `github_light` - GitHub's light theme  
  - `github_dark_dimmed` - Dimmed dark variant
  - `github_dark_high_contrast` - High contrast dark
  - `github_light_high_contrast` - High contrast light
  - `github_dark_colorblind` - Colorblind-friendly dark
  - `github_light_colorblind` - Colorblind-friendly light
  - `github_dark_tritanopia` - Tritanopia-optimized dark
  - `github_light_tritanopia` - Tritanopia-optimized light
  - `github_dark_default` - GitHub default dark
  - `github_light_default` - GitHub default light
- `onedark` - Alternative One Dark theme
- And many more premium themes!

**New Quick Theme Selector**: Use `<leader>ts` for instant theme switching!

**GitHub Theme Cycler**: Use `<leader>tg` to cycle through all 11 GitHub theme variants!

For detailed information about all GitHub theme variants, see **[GitHub Themes Guide](GITHUB_THEMES.md)**.

### Custom Key Mappings

Add your keymaps to `lua/config/keymaps.lua`:

```lua
keymap.set("n", "<leader>custom", "<cmd>YourCommand<cr>", { desc = "Custom action" })
```

## ✨ New Features & Quality of Life Improvements

### 🔧 Autoformatting Control
Autoformatting on save has been **disabled by default** to accommodate custom coding standards:
- **Manual formatting**: Use `<leader>fm` to format the current buffer manually
- **Re-enable auto-format**: Uncomment the `format_on_save` section in `lua/plugins/init.lua`

### 🎨 Enhanced Theme Switcher
- **Telescope Integration**: `<leader>th` or `<leader>tt` opens **live preview** theme selector
- **38+ premium themes**: Including material, sonokai, edge, everforest, gruvbox-material, and more
- **Fixed UI Issues**: No more infinite indenting! Smooth navigation with fuzzy search
- **Live Preview**: See themes instantly as you browse with real-time preview

### 🔍 Which-Key Integration
- **Key binding hints**: Press any leader key and wait to see available commands
- **Organized groups**: Commands are grouped by function (find, trouble, theme, etc.)
- **Visual clarity**: Clean popup interface showing all available shortcuts

## ⌨️ Key Bindings Reference

### 🔍 Finding & Navigation (Telescope)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | Find Files | Find files in current project |
| `<leader>fg` | Live Grep | Search text across all files |
| `<leader>fb` | Find Buffers | Switch between open buffers |
| `<leader>fh` | Help Tags | Search through help documentation |
| `<leader>fc` | Commands | Search and execute commands |
| `<leader>fk` | Keymaps | Search through all keymaps |
| `<leader>fr` | Recent Files | Open recently used files |
| `<leader>fs` | Grep String | Search for string under cursor |
| `<leader>fm` | Marks | Navigate to bookmarks |
| `<leader>fj` | Jumplist | Navigate jump history |
| `<leader>fd` | Diagnostics | Find LSP diagnostics |
| `<leader>fq` | Quickfix | Open quickfix list |

### 📁 File & Buffer Management
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | File Explorer | Open mini.files explorer |
| `<leader>bd` | Delete Buffer | Close buffer safely |
| `<leader>bD` | Force Delete | Force close buffer |
| `<leader>bn` | Next Buffer | Switch to next buffer |
| `<leader>bp` | Previous Buffer | Switch to previous buffer |
| `<leader>bl` | Last Buffer | Switch to last buffer |
| `<leader>bf` | First Buffer | Switch to first buffer |

### 🪟 Window Management
| Key | Action | Description |
|-----|--------|-------------|
| `<C-h/j/k/l>` | Navigate Windows | Move between windows |
| `<C-Arrow>` | Resize Windows | Resize current window |
| `<leader>wv` | Vertical Split | Create vertical split |
| `<leader>wh` | Horizontal Split | Create horizontal split |
| `<leader>wc` | Close Window | Close current window |
| `<leader>wo` | Close Others | Close all other windows |

### 🔧 LSP & Code Actions
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to Definition | Jump to symbol definition |
| `gi` | Go to Implementation | Jump to implementation |
| `gr` | Go to References | Show all references |
| `gy` | Go to Type Definition | Jump to type definition |
| `K` | Hover Documentation | Show hover information |
| `<leader>rn` | Rename Symbol | Rename symbol under cursor |
| `<leader>ca` | Code Action | Show available code actions |
| `<leader>lf` | Format Buffer | Format current buffer |
| `<leader>ld` | Show Diagnostic | Show diagnostic for current line |
| `<leader>lr` | Restart LSP | Restart LSP server |
| `<leader>li` | LSP Info | Show LSP information |
| `[d` / `]d` | Navigate Diagnostics | Jump to prev/next diagnostic |

### 📦 Git Integration
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>hs` | Stage Hunk | Stage current hunk |
| `<leader>hr` | Reset Hunk | Reset current hunk |
| `<leader>hS` | Stage Buffer | Stage entire buffer |
| `<leader>hu` | Undo Stage | Undo last stage |
| `<leader>hR` | Reset Buffer | Reset entire buffer |
| `<leader>hp` | Preview Hunk | Preview hunk changes |
| `<leader>hb` | Blame Line | Show git blame |
| `<leader>hd` | Diff This | Show diff for current file |
| `<leader>tb` | Toggle Blame | Toggle git blame display |
| `<leader>td` | Toggle Deleted | Toggle deleted line display |

### 🎨 Theme & Toggles
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tt` | Theme Switcher | Open theme selector |
| `<leader>tw` | Trim Whitespace | Remove trailing whitespace |
| `<leader>tl` | Trim Lines | Remove empty lines at EOF |
| `<leader>tn` | Toggle Line Numbers | Toggle line numbers |
| `<leader>tr` | Toggle Relative Numbers | Toggle relative line numbers |

### 💾 Session Management
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ss` | Select Session | Load existing session |
| `<leader>sw` | Write Session | Save current session |
| `<leader>sd` | Delete Session | Delete saved session |

### 🗺️ Minimap & Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>mm` | Toggle Minimap | Show/hide code minimap |
| `<leader>mr` | Refresh Minimap | Refresh minimap display |
| `<leader>mf` | Focus Minimap | Focus on minimap window |
| `<leader>z` | Zoom Window | Zoom current window |

### 🔔 Notifications
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>nd` | Dismiss Notifications | Clear all notifications |
| `<leader>nh` | Notification History | Show notification history |
| `<leader>nc` | Clear Notifications | Clear notification display |

### 🎯 Text Objects & Operators
| Key | Action | Description |
|-----|--------|-------------|
| `sa` | Add Surrounding | Add surrounding characters |
| `sd` | Delete Surrounding | Remove surrounding characters |
| `sr` | Replace Surrounding | Replace surrounding characters |
| `ga` | Align Text | Align text selections |
| `gS` | Split/Join | Toggle function arguments split |
| `gs` | Sort | Sort text selections |
| `gr` | Replace | Replace with register content |
| `gm` | Multiply | Duplicate text |
| `gx` | Exchange | Exchange text regions |
| `g=` | Evaluate | Evaluate and replace expression |
| `<M-h/j/k/l>` | Move Lines | Move lines/selections |

### 📍 Mini Visits & Picks
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>vv` | Add Visit | Mark current location |
| `<leader>vr` | Remove Visit | Remove visit mark |
| `<leader>vl` | List Visits | Show all visit marks |
| `<leader>pf` | Pick Files | Alternative file picker |
| `<leader>pg` | Pick Grep | Alternative grep picker |
| `<leader>pb` | Pick Buffers | Alternative buffer picker |

### 💾 Basic File Operations
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>w` | Save File | Write current file |
| `<leader>q` | Quit | Quit current window |
| `<leader>wq` | Save & Quit | Write and quit |
| `<leader>qa` | Quit All | Quit all windows |
| `<Esc>` | Clear Search | Clear search highlighting |

### 🔧 Configuration & Utilities
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>cc` | Edit Config | Open init.lua |
| `<leader>cp` | Edit Plugins | Open plugins config |
| `<leader>ck` | Edit Keymaps | Open keymaps config |
| `<leader>so` | Source Config | Reload configuration |
| `<leader><leader>` | Source File | Source current file |
| `<leader>sr` | Search Replace | Search and replace text |
| `<leader>cd` | Change Directory | Change to file directory |
| `<leader>pwd` | Print Directory | Show current directory |

### 📋 Clipboard & Terminal
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>y` | Copy to Clipboard | Copy to system clipboard |
| `<leader>p` | Paste from Clipboard | Paste from system clipboard |
| `<leader>t;` | Open Terminal | Open terminal window |
| `<Esc>` (in terminal) | Exit Terminal | Return to normal mode |

> **Tip**: Press `<leader>` (space) and wait to see all available keybinds in a popup menu!

### 📢 Better Notifications
- **nvim-notify**: Enhanced notification system with animations
- **Visual feedback**: Theme changes, errors, and info messages display beautifully
- **Non-intrusive**: Notifications fade out automatically

### 🎯 Improved Trouble.nvim
- **Updated keybinds**: Fixed deprecated commands that were causing errors
- **New shortcuts**: 
  - `<leader>xx` - Toggle diagnostics
  - `<leader>xw` - Buffer diagnostics  
  - `<leader>xl` - Location list
  - `<leader>xq` - Quickfix list
  - `<leader>xs` - LSP symbols
  - `<leader>xr` - LSP references

### 🎨 Enhanced UI
- **dressing.nvim**: Better UI for vim.ui select and input
- **Improved statusline**: More consistent colors and better configuration
- **Better borders**: Rounded borders throughout the UI

### 🚀 Complete Mini.nvim Suite (28 plugins)
A comprehensive collection of all the best mini plugins for maximum productivity:

#### 📁 File & Buffer Management
- **mini.bufremove**: Delete buffers without losing window layout (`<leader>bd`, `<leader>bD`)
- **mini.files**: Fast file explorer with preview (`<leader>e`)
- **mini.visits**: Track and navigate recently visited files (`<leader>vv`, `<leader>vl`)
- **mini.sessions**: Session management for workspace persistence (`<leader>ss`, `<leader>sw`, `<leader>sd`)
- **mini.pick**: Alternative picker to telescope (`<leader>pf`, `<leader>pg`, `<leader>pb`, `<leader>ph`)

#### ✨ Visual Enhancements
- **mini.starter**: Beautiful start screen with recent files and quick actions
- **mini.animate**: Smooth animations for cursor movement, scrolling, and window operations
- **mini.cursorword**: Automatically highlights the word under cursor
- **mini.hipatterns**: Highlights TODO, FIXME, HACK, NOTE comments and hex colors
- **mini.indentscope**: Visual indent guides with scope indicators
- **mini.trailspace**: Shows trailing whitespace and provides cleanup commands (`<leader>tw`, `<leader>tl`)
- **mini.map**: Window with buffer text overview (minimap) (`<leader>mm`, `<leader>mr`, `<leader>mf`)
- **mini.icons**: Icon provider for various contexts throughout Neovim
- **mini.statusline**: Minimal and fast statusline
- **mini.tabline**: Tabline with customizable appearance

#### 🛠️ Text Manipulation & Navigation
- **mini.surround**: Add, delete, replace surroundings like brackets, quotes (`sa`, `sd`, `sr`)
- **mini.move**: Move lines and selections with Alt+hjkl (`<M-h/j/k/l>`)
- **mini.splitjoin**: Toggle between split/joined function arguments with `gS`
- **mini.align**: Text alignment with `ga` and `gA`
- **mini.operators**: Additional text operators:
  - `g=`: Evaluate and replace text
  - `gx`: Exchange text regions
  - `gm`: Multiply (duplicate) text
  - `gr`: Replace text with register content
  - `gs`: Sort text selections
- **mini.ai**: Enhanced text objects for better around/inside operations
- **mini.jump**: Quick jump to any single character
- **mini.jump2d**: Jump to any position with Enter
- **mini.pairs**: Auto-close brackets, quotes, and parentheses
- **mini.bracketed**: Go to next/previous targets (buffers, files, diagnostics, etc.)

#### 🔧 Development Tools
- **mini.diff**: Work with diff hunks and git changes (`gh`, `gH`, `[h`, `]h`)
- **fugitive.vim**: Git integration and commands (`<leader>gs`, `<leader>gc`, `<leader>gd`)
- **mini.extra**: Extra textobjects and pickers for enhanced functionality
- **mini.fuzzy**: Fuzzy matching algorithms for better search
- **mini.misc**: Miscellaneous functions including zoom (`<leader>z`)

## 🔧 Troubleshooting

### Common Issues

1. **LSP servers not working**: Run `:Mason` and ensure servers are installed
2. **Plugins not loading**: Run `:Lazy sync` to update plugins
3. **Telescope not finding files**: Ensure `ripgrep` is installed
4. **Formatting not working**: Install formatters via Mason or your system package manager

### Health Check

Run `:checkhealth` in Neovim to diagnose configuration issues.

### Reset Configuration

To start fresh:
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Guide for Neovim](https://github.com/nanotee/nvim-lua-guide)
- [LSP Configuration Examples](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

## 🤝 Contributing

Feel free to submit issues and pull requests to improve this configuration!

## 📄 License

This configuration is provided as-is for educational and personal use.
