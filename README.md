# Neovim Configuration

A modern, feature-rich Neovim configuration written in Lua with LSP support, auto-completion, and a curated set of plugins for an enhanced development experience.

## ✨ Features

- **Modern Lua Configuration**: Fully migrated from VimScript to Lua for better performance and maintainability
- **Native LSP Support**: Built-in Language Server Protocol with intelligent code completion, diagnostics, and navigation
- **Plugin Manager**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, lazy-loaded plugin management
- **Auto-completion**: Powerful completion engine with [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) replacing CoC
- **Quality of Life Plugins**: Mini.nvim collection for enhanced editing experience (auto-pairs, surround, move, etc.)
- **Tab-based Indentation**: Configured to use actual tabs (noexpandtab) for consistent formatting
- **Fuzzy Finding**: Telescope integration for file finding, searching, and more
- **Syntax Highlighting**: Enhanced syntax highlighting with Treesitter
- **Multiple Themes**: Several beautiful colorschemes included
- **LaTeX Support**: VimTeX integration for LaTeX document editing
- **Transparent Background**: Configured for transparent terminal backgrounds
- **Custom .wistl Filetype**: Specialized support for .wistl files

## 🚀 Installation

### Prerequisites

- **Neovim >= 0.9.0**
- **Git**
- **Node.js** (for LSP servers)
- **Python** (for Python LSP support)
- **ripgrep** (for better grep functionality)

#### Ubuntu/Debian Installation:
```bash
sudo apt update
sudo apt install neovim git nodejs npm python3 python3-pip ripgrep
```

#### Arch Installation:
```bash
sudo pacman -Syu neovim git nodejs npm python3 python3-pip ripgrep
```

#### macOS Installation:
```bash
brew install neovim git node python ripgrep
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
| `K` | Normal | Show hover documentation |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code actions |
| `<leader>f` | Normal | Format code |
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |

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

## 🔌 Included Plugins

### Core Functionality
- **[lazy.nvim](https://github.com/folke/lazy.nvim)** - Modern plugin manager
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Lua utility functions

### Quality of Life (Mini.nvim Collection)
- **[mini.pairs](https://github.com/echasnovski/mini.pairs)** - Auto-close brackets, quotes, and parentheses
- **[mini.surround](https://github.com/echasnovski/mini.surround)** - Surround text with brackets, quotes, tags, etc.
- **[mini.indentscope](https://github.com/echasnovski/mini.indentscope)** - Visualize and operate on indent scope
- **[mini.move](https://github.com/echasnovski/mini.move)** - Move any selection in any direction
- **[mini.ai](https://github.com/echasnovski/mini.ai)** - Better text objects (around/inside)
- **[mini.jump](https://github.com/echasnovski/mini.jump)** - Jump to next/previous single character
- **[mini.files](https://github.com/echasnovski/mini.files)** - Navigate and manipulate file system
- **[mini.statusline](https://github.com/echasnovski/mini.statusline)** - Minimal and fast statusline

### LSP & Completion
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configurations
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP server management
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Completion engine
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine

### UI & Navigation
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[trouble.nvim](https://github.com/folke/trouble.nvim)** - Diagnostics panel
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting

### Editing & Productivity
- **[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting
- **[conform.nvim](https://github.com/stevearc/conform.nvim)** - Code formatting
- **[vimtex](https://github.com/lervag/vimtex)** - LaTeX support

### Colorschemes & Themes
- **[onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim)** - One Dark theme (default)
- **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** - Tokyo Night theme
- **[gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)** - Gruvbox theme
- **[dracula.nvim](https://github.com/Mofiqul/dracula.nvim)** - Dracula theme
- **[nord.nvim](https://github.com/shaunsingh/nord.nvim)** - Nord theme
- **[everforest](https://github.com/sainnhe/everforest)** - Everforest theme
- **[catppuccin](https://github.com/catppuccin/nvim)** - Catppuccin theme
- **[nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)** - Nightfox theme collection
- **[rose-pine](https://github.com/rose-pine/neovim)** - Rose Pine theme
- **[kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)** - Kanagawa theme
- **[material.nvim](https://github.com/marko-cerovac/material.nvim)** - Material theme
- **[monokai.nvim](https://github.com/tanvirtin/monokai.nvim)** - Monokai theme
- **[onedark.nvim](https://github.com/navarasu/onedark.nvim)** - OneDark theme
- **[github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)** - GitHub theme
- **[sonokai](https://github.com/sainnhe/sonokai)** - Sonokai theme
- **[edge](https://github.com/sainnhe/edge)** - Edge theme

## 🎨 Recommended Additional Plugins

### Navigation & File Management
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer with git integration
- **[oil.nvim](https://github.com/stevearc/oil.nvim)** - File manager as a buffer
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - Modern file explorer
- **[flash.nvim](https://github.com/folke/flash.nvim)** - Navigate code with search labels
- **[leap.nvim](https://github.com/ggandor/leap.nvim)** - Lightning-fast movement
- **[harpoon](https://github.com/ThePrimeagen/harpoon)** - Quick file navigation
- **[telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)** - Native FZF sorter for Telescope
- **[telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)** - File browser for Telescope

### Git Integration
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations and hunks
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

**Easy Theme Switcher** (New Feature!)

Use the built-in theme switcher for easy theme changing:
- Press `<leader>th` or `<leader>tt` to open the theme selector
- Choose from 70+ available themes including dracula, gruvbox, tokyonight, etc.
- Themes are applied instantly with notification feedback

**Manual Theme Change**

Alternatively, modify the colorscheme in `init.lua`:

```lua
vim.cmd("colorscheme your_preferred_theme")
```

Available themes include:
- `dracula` - Dracula theme
- `gruvbox` - Gruvbox theme  
- `tokyonight`, `tokyonight-night`, `tokyonight-storm`
- `catppuccin`, `catppuccin-mocha`, `catppuccin-latte`
- `nord` - Nord theme
- `rose-pine`, `rose-pine-moon`, `rose-pine-dawn`
- And many more!

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
- **Quick access**: `<leader>th` or `<leader>tt` opens theme selector
- **70+ themes available**: Including dracula, gruvbox, tokyonight, catppuccin, and more
- **Instant preview**: Themes apply immediately with notification feedback

### 🔍 Which-Key Integration
- **Key binding hints**: Press any leader key and wait to see available commands
- **Organized groups**: Commands are grouped by function (find, trouble, theme, etc.)
- **Visual clarity**: Clean popup interface showing all available shortcuts

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
