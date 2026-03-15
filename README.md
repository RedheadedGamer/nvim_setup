# Neovim Configuration

A modern, feature-rich Neovim configuration written in Lua with **complete mini.nvim ecosystem integration** (27 plugins), **snacks.nvim** (32 modules), LSP support, auto-completion, and optimized performance.

**🌍 Cross-Platform:** Works on Linux (Arch, Ubuntu, Debian, Fedora), macOS, and Windows with Scoop.

---

## Table of Contents

- [Features](#-features)
- [Quick Start](#-quick-start)
- [Installation](#-installation)
  - [Automated Installation](#automated-installation)
  - [Manual Installation](#manual-installation)
  - [Prerequisites](#prerequisites)
  - [Switching Between Setups](#switching-between-setups)
- [Configuration Structure](#-configuration-structure)
  - [Plugin Organization](#plugin-organization)
- [Included Plugins](#-included-plugins)
  - [Core & UI](#core--ui)
  - [Mini.nvim Collection (27 plugins)](#mininvim-collection-27-plugins)
  - [snacks.nvim (32 modules)](#snacksnvim-32-modules)
  - [LSP & Completion](#lsp--completion)
  - [Git Integration](#git-integration)
  - [Development Tools](#development-tools)
  - [Language Support](#language-support)
  - [Themes (15 colorschemes)](#themes-15-colorschemes)
- [Key Bindings](#-key-bindings)
- [Customization](#-customization)
- [Troubleshooting](#-troubleshooting)
- [Possible Improvements](#-possible-improvements)
- [Additional Documentation](#-additional-documentation)
- [Resources](#-resources)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

- **Modern Lua Configuration** — Fully written in Lua for better performance and maintainability
- **Native LSP Support** — Built-in Language Server Protocol with intelligent completion, diagnostics, and navigation
- **Plugin Manager** — [lazy.nvim](https://github.com/folke/lazy.nvim) for fast, lazy-loaded plugin management
- **Auto-completion** — [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with snippet support via LuaSnip
- **Complete Mini.nvim Ecosystem** — 27 mini.nvim plugins for comprehensive editing tools
- **snacks.nvim Integration** — All 32 modules (dashboard, notifications, terminal, git, zen mode, profiler, and more) — [See complete guide](SNACKS_GUIDE.md)
- **210+ Keybinds** — Comprehensive keybind system with which-key integration for discoverability
- **15 Curated Themes** — Optimized colorschemes with transparency support and live preview switching
- **C/C++ Development** — Complete environment with clangd, CMake integration, debugging, and static analysis
- **Java Development** — Full-featured Java LSP with nvim-jdtls, refactoring, testing, and Maven/Gradle support
- **Assembly Language** — NASM/x86 support with asm-lsp, syntax highlighting, and `.asm-lsp.toml` config
- **LaTeX Support** — VimTeX integration for document editing
- **Fuzzy Finding** — Telescope and mini.pick for file finding, searching, and more
- **Syntax Highlighting** — Treesitter with rainbow brackets
- **Transparent Background** — 80+ UI elements configured for full transparency support
- **Two Setup Modes** — Full IDE or lightweight Minimal configuration

## 🚀 Quick Start

```bash
# One command to install (interactive — will ask Full or Minimal)
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash

# Then start Neovim
nvim
```

Wait for plugins to install, restart Neovim, and you're ready to go!

> For a step-by-step walkthrough, see the **[Quick Start Guide](QUICKSTART.md)**.

## 📦 Installation

This configuration offers **two setup modes**:

| | Full Setup | Minimal Setup |
|---|---|---|
| **LSP & Mason** | ✅ | ❌ |
| **Auto-completion** | ✅ | ❌ |
| **Linters & Formatters** | ✅ | ❌ |
| **C/C++ & Java tools** | ✅ | ❌ |
| **Mini.nvim plugins** | 27 | Core subset |
| **Themes** | 15 | 5 |
| **Startup time** | Standard | Faster |

### Automated Installation

**Linux/macOS:**
```bash
# Interactive
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash

# Direct
./install.sh --full    # or --minimal
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/RedheadedGamer/nvim_setup.git $env:TEMP\nvim_install
cd $env:TEMP\nvim_install
.\install.ps1          # -Full or -Minimal
```

### Manual Installation

**Linux/macOS:**
```bash
mv ~/.config/nvim ~/.config/nvim.backup
git clone git@github.com:RedheadedGamer/nvim_setup.git ~/.config/nvim
nvim
```

**Windows:**
```powershell
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.backup -ErrorAction SilentlyContinue
git clone https://github.com/RedheadedGamer/nvim_setup.git $env:LOCALAPPDATA\nvim
nvim
```

For Minimal setup, create the marker file after cloning:
```bash
touch ~/.config/nvim/.minimal_setup   # Linux/macOS
```

### Prerequisites

| Requirement | Full Setup | Minimal Setup |
|---|---|---|
| Neovim >= 0.11.0 | Required | Required |
| Git | Required | Required |
| Node.js | Required | — |
| Python | Required | — |
| ripgrep | Recommended | — |
| C/C++ toolchain | Optional | — |

> For platform-specific installation commands, see **[INSTALL.md](INSTALL.md)** and **[PLATFORM_SUPPORT.md](PLATFORM_SUPPORT.md)**.
>
> **Windows users:** See **[WINDOWS_TROUBLESHOOTING.md](WINDOWS_TROUBLESHOOTING.md)** for common issues.

### Switching Between Setups

```bash
# Switch to Minimal
touch ~/.config/nvim/.minimal_setup && nvim  # then :Lazy sync

# Switch to Full
rm ~/.config/nvim/.minimal_setup && nvim     # then :Lazy sync
```

## 🗂️ Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point (OS detection, lazy.nvim bootstrap)
├── lua/
│   ├── config/
│   │   ├── options.lua         # Editor options and settings
│   │   ├── keymaps.lua         # Key mappings
│   │   ├── autocmds.lua        # Autocommands
│   │   ├── theme.lua           # Theme persistence
│   │   └── lsp/
│   │       ├── servers.lua     # LSP server configurations
│   │       ├── keymaps.lua     # LSP keybindings
│   │       └── diagnostics.lua # Diagnostic configuration
│   └── plugins/
│       ├── init.lua            # Plugin loader (imports all modules)
│       ├── minimal.lua         # Minimal setup plugins
│       ├── ui/                 # Themes, snacks.nvim, utilities
│       ├── editor/             # Treesitter, mini-text, mini-ui, mini-navigation, extras
│       ├── lsp/                # LSP configuration
│       ├── git/                # Gitsigns, diffview
│       ├── dev/                # Formatting, linting, debugging
│       └── lang/               # C/C++, Java, LaTeX, Lua
├── ftplugin/
│   └── java.lua                # Java-specific settings
├── .asm-lsp.toml               # Assembly LSP configuration
├── install.sh                  # Linux/macOS installer
├── install.ps1                 # Windows installer
├── verify_setup.sh             # Linux/macOS verification
└── verify_setup.ps1            # Windows verification
```

### Plugin Organization

Plugins are organized into modular categories under `lua/plugins/`:

| Directory | Contents |
|---|---|
| `ui/` | `themes.lua`, `snacks.lua`, `utilities.lua` (which-key, telescope, dressing) |
| `editor/` | `treesitter.lua`, `mini-text.lua`, `mini-ui.lua`, `mini-navigation.lua`, `extras.lua` |
| `lsp/` | `lspconfig.lua` (Mason, nvim-lspconfig, nvim-cmp, Trouble) |
| `git/` | `gitsigns.lua`, `diffview.lua` |
| `dev/` | `formatting.lua` (conform.nvim), `linting.lua` (nvim-lint), `debugging.lua` (nvim-dap) |
| `lang/` | `c-cpp.lua`, `java.lua`, `latex.lua`, `lua.lua` |

## 🔌 Included Plugins

### Core & UI

| Plugin | Description |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Modern plugin manager |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility functions |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Key binding popup |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim) | Better UI for vim.ui |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics panel |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | Rainbow brackets |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Smart commenting |

### Mini.nvim Collection (27 plugins)

**File & Buffer Management:**
mini.files, mini.bufremove, mini.visits, mini.sessions, mini.pick

**Visual Enhancements:**
mini.starter, mini.animate, mini.cursorword, mini.hipatterns, mini.indentscope, mini.trailspace, mini.map, mini.icons, mini.statusline, mini.tabline

**Text Manipulation & Navigation:**
mini.surround, mini.move, mini.splitjoin, mini.align, mini.operators, mini.ai, mini.jump, mini.jump2d, mini.pairs, mini.bracketed

**Development Tools:**
mini.diff, mini.extra, mini.fuzzy, mini.misc

### snacks.nvim (32 modules)

All 32 modules from folke's modern plugin collection:

- **Core:** Dashboard, Notifications, Smooth Scrolling, Indent Guides, Terminal, Status Column, Word Navigation, Large File Optimization, Quick File Loading, Animations
- **Git & Dev:** Git Utilities, Git Browse, LazyGit Integration, LSP Rename Preview, Smart Buffer Delete
- **Productivity:** Toggle Utilities, Zen Mode, Dim Inactive Windows, Scratch Buffers, Window Management, Fuzzy Picker
- **Advanced:** Enhanced Input UI, Scope Navigation, Performance Profiler, Debug Utilities, UI Styling, Backdrop Dimming, File Explorer
- **Infrastructure:** Utilities, Configuration, Health Checks, Internal APIs

> For a detailed guide with all keybindings, see **[SNACKS_GUIDE.md](SNACKS_GUIDE.md)**.

### LSP & Completion

| Plugin | Description |
|---|---|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configurations (vim.lsp.config API for Neovim 0.11+) |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP server management |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Mason-LSP integration |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Automatic tool installation |
| [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim) | Mason-DAP integration |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |

**Automatically installed via Mason:** `lua_ls`, `pyright`, `ts_ls`, `html`, `cssls`, `jsonls`, `clangd`, `jdtls`, `cmake`, `bashls`, `marksman`, `asm_lsp` — plus formatters (`stylua`, `black`, `prettier`, `clang-format`, `shfmt`), linters (`pylint`, `eslint_d`, `markdownlint`, `shellcheck`), and debuggers (`codelldb`, `debugpy`, `js-debug-adapter`).

### Git Integration

| Plugin | Description |
|---|---|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git decorations, hunks, and blame |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Comprehensive Git wrapper |
| [mini.diff](https://github.com/echasnovski/mini.diff) | Diff hunks and git changes |

### Development Tools

| Plugin | Description |
|---|---|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Code formatting (manual — auto-format disabled) |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Code linting |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | Debugging interface |

### Language Support

| Plugin | Description |
|---|---|
| [clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim) | Enhanced clangd with inlay hints and AST viewing |
| [cmake-tools.nvim](https://github.com/Civitasv/cmake-tools.nvim) | CMake project integration |
| [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) | Java LSP |
| [vimtex](https://github.com/lervag/vimtex) | LaTeX support |
| [CurtineIncSw.vim](https://github.com/ericcurtin/CurtineIncSw.vim) | Header/source switching |
| [asm-lsp](https://github.com/bergercookie/asm-lsp) | Assembly language server (NASM/x86) |

### Themes (15 colorschemes)

onedarkpro (default), tokyonight, gruvbox, dracula, nord, catppuccin, nightfox, rose-pine, kanagawa, sonokai, edge, everforest, gruvbox-material, material, vscode

Use `<leader>th` for the live-preview theme selector or `<leader>ts` for quick switching.

## ⌨️ Key Bindings

> **Tip:** Press `<Space>` (leader) and wait to see all available keybinds via which-key!

### General

| Key | Mode | Action |
|---|---|---|
| `<Space>` | Normal | Leader key |
| `<Esc>` | Normal | Clear search highlighting |
| `<C-h/j/k/l>` | Normal | Navigate windows |
| `<C-Arrow>` | Normal | Resize windows |
| `<leader>w` | Normal | Save file |
| `<leader>q` | Normal | Quit |

### Finding & Navigation (Telescope)

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fc` | Commands |
| `<leader>fk` | Keymaps |
| `<leader>fr` | Recent files |
| `<leader>fs` | Grep string under cursor |
| `<leader>fd` | Diagnostics |

### LSP & Code

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `gy` | Go to type definition |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>fm` | Format buffer |
| `[d` / `]d` | Previous/next diagnostic |

### File & Buffer Management

| Key | Action |
|---|---|
| `<leader>e` | File explorer (mini.files) |
| `<leader>bd` | Delete buffer (keep layout) |
| `<leader>bD` | Force delete buffer |

### Git

| Key | Action |
|---|---|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |
| `<leader>tb` | Toggle blame |

### C/C++ Development

| Key | Action |
|---|---|
| `<leader>cg` | CMake Generate |
| `<leader>cb` | CMake Build |
| `<leader>cr` | CMake Run |
| `<leader>cd` | CMake Debug |
| `<leader>ch` | Switch Header/Source |
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Debug continue |
| `<leader>di` | Debug step into |
| `<leader>do` | Debug step over |
| `<leader>du` | Toggle debug UI |

### Text Objects & Operators (Mini)

| Key | Action |
|---|---|
| `sa` / `sd` / `sr` | Add/delete/replace surrounding |
| `<M-h/j/k/l>` | Move lines/selections |
| `ga` | Align text |
| `gS` | Split/join arguments |
| `gs` | Sort |
| `gm` | Multiply (duplicate) |
| `gx` | Exchange text |
| `g=` | Evaluate and replace |

### Minimap & Navigation

| Key | Action |
|---|---|
| `<leader>mm` | Toggle minimap |
| `<leader>mz` | Zoom window |
| `<CR>` | Start 2D jumping |
| `<leader>vv` | Add visit label |
| `<leader>vl` | List visits |
| `<leader>ss` | Select session |
| `<leader>sw` | Write session |

### Theme & Toggles

| Key | Action |
|---|---|
| `<leader>th` | Theme switcher (live preview) |
| `<leader>ts` | Quick theme selector |
| `<leader>t;` | Toggle terminal |
| `<leader>tw` | Trim trailing whitespace |
| `<leader>tn` | Toggle line numbers |

### Trouble (Diagnostics)

| Key | Action |
|---|---|
| `<leader>xx` | Toggle diagnostics |
| `<leader>xw` | Buffer diagnostics |
| `<leader>xl` | Location list |
| `<leader>xq` | Quickfix list |
| `<leader>xs` | LSP symbols |
| `<leader>xr` | LSP references |

## 🛠️ Customization

### Adding Plugins

Add plugins to the appropriate file under `lua/plugins/`:

```lua
-- Example: lua/plugins/ui/themes.lua
return {
  -- ... existing plugins ...
  {
    "author/plugin-name",
    lazy = true,
    config = function()
      require("plugin-name").setup({})
    end,
  },
}
```

To create a new category, add a directory under `lua/plugins/` and import it in `lua/plugins/init.lua`.

### Changing Theme

- **Live preview:** `<leader>th` opens the Telescope-based theme selector
- **Manual:** Edit `init.lua` and set `vim.cmd("colorscheme your_theme")`

### Custom Key Mappings

Add keymaps to `lua/config/keymaps.lua`:

```lua
keymap.set("n", "<leader>custom", "<cmd>YourCommand<cr>", { desc = "Custom action" })
```

## 🔧 Troubleshooting

| Issue | Solution |
|---|---|
| LSP servers not working | Run `:Mason` and ensure servers are installed |
| Plugins not loading | Run `:Lazy sync` to update plugins |
| Telescope not finding files | Ensure `ripgrep` is installed |
| Formatting not working | Install formatters via Mason or system package manager |

**Health check:** Run `:checkhealth` in Neovim to diagnose issues.

**Reset configuration:**
```bash
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

> **Windows users:** See **[WINDOWS_TROUBLESHOOTING.md](WINDOWS_TROUBLESHOOTING.md)** for platform-specific issues.

## 💡 Possible Improvements

Here are some ideas for future enhancements to this setup:

### Performance
- **Lazy-load more plugins** — Some plugins could be loaded on specific events or filetypes rather than at startup to reduce launch time
- **Profile startup time** — Use the snacks.nvim profiler or `vim-startuptime` to identify and optimize slow-loading plugins
- **Reduce theme count** — Fewer themes means less disk space and faster initial install

### Features
- **Add [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)** — Show the current function/class context at the top of the screen
- **Add [flash.nvim](https://github.com/folke/flash.nvim) or [leap.nvim](https://github.com/ggandor/leap.nvim)** — Faster navigation with search labels
- **Add [harpoon](https://github.com/ThePrimeagen/harpoon)** — Quick file navigation for frequently used files
- **Add [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)** — Better quickfix window for build errors and search results
- **Add [neotest](https://github.com/nvim-neotest/neotest)** — Integrated test runner framework
- **Add [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)** — Code refactoring toolkit
- **Add [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)** — Live markdown preview in browser

### Code Quality
- **Enable auto-formatting** — Currently disabled; could be opt-in per filetype
- **Add EditorConfig support** — Ensure consistent formatting across different editors in shared projects
- **Add [nvim-coverage](https://github.com/andythigpen/nvim-coverage)** — Code coverage visualization for test-driven development

### Language Support
- **Rust** — Add [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim) or [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) for Rust development
- **Go** — Add [go.nvim](https://github.com/ray-x/go.nvim) for Go development
- **TypeScript** — Add enhanced TypeScript support with dedicated tools
- **Python** — Add [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) for better Python debugging

### Project Management
- **Add [project.nvim](https://github.com/ahmedkhalf/project.nvim)** — Automatic project root detection
- **Add [persistence.nvim](https://github.com/folke/persistence.nvim)** — Automated session management (complement to mini.sessions)
- **Add [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)** — Highlight and search TODO/FIXME/HACK comments across the project

### User Experience
- **Create a `:Setup` command** — Interactive wizard for first-time configuration
- **Add per-project configuration** — Support `.nvim.lua` or `.exrc` files for project-specific settings
- **Add [noice.nvim](https://github.com/folke/noice.nvim)** — Replace the command line and message UI with a modern interface
- **Improve the dashboard** — Add project-specific shortcuts and recent project tracking

## 📚 Additional Documentation

| Document | Description |
|---|---|
| [QUICKSTART.md](QUICKSTART.md) | 5-minute getting started guide |
| [INSTALL.md](INSTALL.md) | Detailed installation instructions and prerequisites |
| [PLATFORM_SUPPORT.md](PLATFORM_SUPPORT.md) | Platform-specific guides (Arch, Ubuntu, macOS, Windows, Fedora) |
| [PLUGIN_GUIDE.md](PLUGIN_GUIDE.md) | Comprehensive plugin usage guide |
| [SNACKS_GUIDE.md](SNACKS_GUIDE.md) | Complete snacks.nvim documentation for all 32 modules |
| [WINDOWS_TROUBLESHOOTING.md](WINDOWS_TROUBLESHOOTING.md) | Windows-specific troubleshooting |

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Guide for Neovim](https://github.com/nanotee/nvim-lua-guide)
- [LSP Configuration Examples](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

## 🤝 Contributing

Feel free to submit issues and pull requests to improve this configuration!

## 📄 License

This configuration is provided as-is for educational and personal use.
