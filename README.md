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

### File Management & Navigation
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer with git integration
- **[oil.nvim](https://github.com/stevearc/oil.nvim)** - File manager as a buffer
- **[ranger.nvim](https://github.com/kelly-lin/ranger.nvim)** - Ranger integration for file management
- **[yazi.nvim](https://github.com/mikavilpas/yazi.nvim)** - Yazi file manager integration
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - Modern file explorer
- **[lf.nvim](https://github.com/lmburns/lf.nvim)** - LF file manager integration
- **[fm-nvim](https://github.com/is0n/fm-nvim)** - File manager launcher

### Search & Navigation Enhancement
- **[flash.nvim](https://github.com/folke/flash.nvim)** - Navigate code with search labels
- **[leap.nvim](https://github.com/ggandor/leap.nvim)** - Lightning-fast movement
- **[lightspeed.nvim](https://github.com/ggandor/lightspeed.nvim)** - Enhanced f/t motions
- **[hop.nvim](https://github.com/phaazon/hop.nvim)** - EasyMotion-like navigation
- **[telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)** - Native FZF sorter for Telescope
- **[telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)** - File browser for Telescope
- **[harpoon](https://github.com/ThePrimeagen/harpoon)** - Quick file navigation
- **[marks.nvim](https://github.com/chentoast/marks.nvim)** - Enhanced mark visualization

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

### UI Enhancements & Themes
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Blazing fast statusline
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim)** - Snazzy buffer tabs
- **[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indent guides
- **[nvim-notify](https://github.com/rcarriga/nvim-notify)** - Fancy notification manager
- **[noice.nvim](https://github.com/folke/noice.nvim)** - UI replacement for messages, cmdline, and popupmenu
- **[dressing.nvim](https://github.com/stevearc/dressing.nvim)** - Better UI for vim.ui interfaces
- **[nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)** - File type icons
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Key binding popup
- **[alpha-nvim](https://github.com/goolord/alpha-nvim)** - Dashboard/start screen
- **[dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)** - Fancy start screen
- **[barbecue.nvim](https://github.com/utilyre/barbecue.nvim)** - Winbar with LSP context

### Text Editing & Manipulation
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** - Modern surround plugin
- **[vim-surround](https://github.com/tpope/vim-surround)** - Classic surround operations
- **[vim-repeat](https://github.com/tpope/vim-repeat)** - Repeat plugin commands with dot
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto close brackets/quotes
- **[vim-abolish](https://github.com/tpope/vim-abolish)** - Smart search/replace
- **[substitute.nvim](https://github.com/gbprod/substitute.nvim)** - Modern substitute operations
- **[nvim-spectre](https://github.com/nvim-pack/nvim-spectre)** - Search and replace panel
- **[dial.nvim](https://github.com/monaqa/dial.nvim)** - Extended increment/decrement
- **[vim-visual-multi](https://github.com/mg979/vim-visual-multi)** - Multiple cursors
- **[nvim-gomove](https://github.com/booperlv/nvim-gomove)** - Move lines and blocks

### Development Tools & Debugging
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal management
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)** - Debug adapter protocol
- **[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)** - UI for nvim-dap
- **[undotree](https://github.com/mbbill/undotree)** - Undo history visualizer
- **[neotest](https://github.com/nvim-neotest/neotest)** - Testing framework
- **[coverage.nvim](https://github.com/andythigpen/nvim-coverage)** - Code coverage display
- **[refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)** - Refactoring toolkit
- **[code_runner.nvim](https://github.com/CRAG666/code_runner.nvim)** - Code runner
- **[sniprun](https://github.com/michaelb/sniprun)** - Run code snippets
- **[overseer.nvim](https://github.com/stevearc/overseer.nvim)** - Task runner

### Session & Project Management
- **[persistence.nvim](https://github.com/folke/persistence.nvim)** - Session management
- **[possession.nvim](https://github.com/jedrzejboczar/possession.nvim)** - Session management
- **[project.nvim](https://github.com/ahmedkhalf/project.nvim)** - Project management
- **[workspaces.nvim](https://github.com/natecraddock/workspaces.nvim)** - Workspace management
- **[neovim-session-manager](https://github.com/Shatur/neovim-session-manager)** - Session manager

### AI & Productivity
- **[copilot.vim](https://github.com/github/copilot.vim)** - GitHub Copilot
- **[copilot.lua](https://github.com/zbirenbaum/copilot.lua)** - Lua rewrite of Copilot
- **[codeium.nvim](https://github.com/Exafunction/codeium.nvim)** - Free AI assistant
- **[tabnine-nvim](https://github.com/codota/tabnine-nvim)** - TabNine AI completion
- **[ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim)** - ChatGPT integration
- **[neural](https://github.com/dense-analysis/neural)** - AI code generation
- **[gen.nvim](https://github.com/David-Kunz/gen.nvim)** - Generate text with Ollama

### Language-Specific Enhancements
#### Rust
- **[rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim)** - Enhanced Rust support
- **[crates.nvim](https://github.com/saecki/crates.nvim)** - Rust crate management

#### Go
- **[go.nvim](https://github.com/ray-x/go.nvim)** - Go development tools
- **[gopher.nvim](https://github.com/olexsmir/gopher.nvim)** - Go utilities

#### Python
- **[python-syntax](https://github.com/vim-python/python-syntax)** - Enhanced Python syntax
- **[swenv.nvim](https://github.com/AckslD/swenv.nvim)** - Python environment switcher

#### JavaScript/TypeScript
- **[typescript.nvim](https://github.com/jose-elias-alvarez/typescript.nvim)** - TypeScript utilities
- **[package-info.nvim](https://github.com/vuki656/package-info.nvim)** - NPM package information

#### Java
- **[nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)** - Java LSP enhancements

#### Web Development
- **[emmet-vim](https://github.com/mattn/emmet-vim)** - Emmet expansion
- **[nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)** - Color highlighter
- **[tailwindcss-colorizer-cmp.nvim](https://github.com/roobert/tailwindcss-colorizer-cmp.nvim)** - Tailwind CSS colors

### Markdown & Writing
- **[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)** - Markdown preview
- **[glow.nvim](https://github.com/ellisonleao/glow.nvim)** - Markdown preview in terminal
- **[obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)** - Obsidian integration
- **[telekasten.nvim](https://github.com/renerocksai/telekasten.nvim)** - Zettelkasten note-taking
- **[vim-table-mode](https://github.com/dhruvasagar/vim-table-mode)** - Table creation and editing
- **[bullets.vim](https://github.com/dkarter/bullets.vim)** - Automated bullet lists
- **[vim-pencil](https://github.com/preservim/vim-pencil)** - Writing mode

### Color & Highlighting
- **[nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)** - Color highlighting
- **[nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors)** - Color preview
- **[rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)** - Rainbow brackets
- **[todo-comments.nvim](https://github.com/folke/todo-comments.nvim)** - Highlight TODO comments
- **[paint.nvim](https://github.com/folke/paint.nvim)** - Custom highlighting rules

### Terminal & Shell Integration
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal management
- **[nvim-terminal.lua](https://github.com/norcalli/nvim-terminal.lua)** - Terminal utilities
- **[floaterm](https://github.com/voldikss/vim-floaterm)** - Floating terminal
- **[tmux.nvim](https://github.com/aserowy/tmux.nvim)** - Tmux integration

### Database Tools
- **[vim-dadbod](https://github.com/tpope/vim-dadbod)** - Database interface
- **[vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)** - Database UI
- **[vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion)** - Database completion

### Performance & Profiling
- **[startuptime.vim](https://github.com/dstein64/vim-startuptime)** - Startup time profiler
- **[impatient.nvim](https://github.com/lewis6991/impatient.nvim)** - Faster Lua module loading
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Lua utility functions

### Utility & Quality of Life
- **[nvim-lastplace](https://github.com/ethanholz/nvim-lastplace)** - Remember cursor position
- **[vim-sleuth](https://github.com/tpope/vim-sleuth)** - Auto-detect indentation
- **[stabilize.nvim](https://github.com/luukvbaal/stabilize.nvim)** - Stabilize window splits
- **[focus.nvim](https://github.com/nvim-focus/focus.nvim)** - Auto-resize windows
- **[modes.nvim](https://github.com/mvllow/modes.nvim)** - Highlight current mode
- **[deadcolumn.nvim](https://github.com/Bekaboo/deadcolumn.nvim)** - Colorcolumn when needed
- **[smartcolumn.nvim](https://github.com/m4xshen/smartcolumn.nvim)** - Dynamic colorcolumn

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
