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

### Themes
- **[onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim)** - One Dark theme (default)
- **[everforest](https://github.com/sainnhe/everforest)** - Everforest theme
- **[catppuccin](https://github.com/catppuccin/nvim)** - Catppuccin theme
- **[pink-panic.nvim](https://github.com/Scysta/pink-panic.nvim)** - Pink Panic theme

## 🎨 Recommended Additional Plugins

### File Management
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer
- **[oil.nvim](https://github.com/stevearc/oil.nvim)** - File manager as a buffer

### Git Integration
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git decorations
- **[lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)** - LazyGit integration
- **[diffview.nvim](https://github.com/sindrets/diffview.nvim)** - Git diff viewer

### UI Enhancements
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Beautiful statusline
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Buffer tabs
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indent guides
- **[nvim-notify](https://github.com/rcarriga/nvim-notify)** - Notification manager

### Development Tools
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal management
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** - Debug adapter protocol
- **[undotree](https://github.com/mbbill/undotree)** - Undo history visualizer
- **[vim-surround](https://github.com/tpope/vim-surround)** - Surround text objects

### Language-Specific
- **[rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim)** - Enhanced Rust support
- **[go.nvim](https://github.com/ray-x/go.nvim)** - Go development tools
- **[nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)** - Java LSP enhancements

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

Modify the colorscheme in `lua/plugins/init.lua`:

```lua
vim.cmd("colorscheme your_preferred_theme")
```

### Custom Key Mappings

Add your keymaps to `lua/config/keymaps.lua`:

```lua
keymap.set("n", "<leader>custom", "<cmd>YourCommand<cr>", { desc = "Custom action" })
```

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
