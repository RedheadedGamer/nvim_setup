# Neovim Configuration — Full Setup & Minimal Mode

A modern, feature-rich Neovim configuration written in Lua with **complete mini.nvim ecosystem integration** (27 plugins), **snacks.nvim** (32 modules), LSP support, auto-completion, and optimized performance.

📁 [`lua/`](lua/) — Core configuration and plugin modules  
💬 [`DISCUSSIONS.md`](DISCUSSIONS.md) — Design decisions, tips, and troubleshooting

---

## ✨ Features

- **Modern Lua Configuration** — Fully written in Lua for better performance and maintainability.
- **Native LSP Support** — Built-in Language Server Protocol with intelligent completion, diagnostics, and navigation.
- **Two Setup Modes** — Toggle between a full-featured IDE or a lightweight Minimal configuration.
- **snacks.nvim Integration** — All 32 modules including dashboard, terminal, git, and zen mode.
- **Complete Mini.nvim Ecosystem** — 27 mini.nvim plugins covering UI, editing, and navigation.
- **C/C++ & Java Development** — Pre-configured environments with CMake, debugging, and refactoring tools.
- **Assembly & LaTeX Support** — Specialized tooling for NASM/x86 and VimTeX.
- **Transparent Background** — 80+ UI elements pre-configured for consistent transparency.
- **210+ Keybinds** — Comprehensive keybind system with `which-key` discovery.

---

## 🚀 Quick Start

```bash
# Automated install (Linux/macOS)
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash

# Automated install (Windows PowerShell)
git clone https://github.com/RedheadedGamer/nvim_setup.git $env:TEMP\nvim_install
cd $env:TEMP\nvim_install
.\install.ps1

# Then start Neovim
nvim
```

Wait for `lazy.nvim` to finish installing plugins, restart, and you're ready.

---

## 📦 Installation Modes

This configuration supports two modes. You can switch at any time by creating/removing the `.minimal_setup` marker file in your nvim config directory.

| Feature | Full Setup | Minimal Setup |
|---------|------------|---------------|
| **LSP & Mason** | ✅ | ❌ |
| **Auto-completion** | ✅ | ❌ |
| **Linters & Formatters** | ✅ | ❌ |
| **Mini.nvim plugins** | 27 | Core subset |
| **Themes** | 15 | 5 |
| **Startup time** | Standard | 🚀 Blazing fast |

### Manual Installation

**Linux/macOS:**
```bash
git clone https://github.com/RedheadedGamer/nvim_setup.git ~/.config/nvim
nvim
```

**Windows:**
```powershell
git clone https://github.com/RedheadedGamer/nvim_setup.git $env:LOCALAPPDATA\nvim
nvim
```

---

## 🌍 Platform Support & Prerequisites

| Platform | Package Manager | Recommended Install Command |
|----------|-----------------|-----------------------------|
| **Arch Linux** | `pacman` | `sudo pacman -S neovim git nodejs npm python python-pip ripgrep` |
| **Ubuntu/Debian**| `apt` | `sudo apt install neovim git nodejs npm python3 python3-pip ripgrep` |
| **macOS** | `brew` | `brew install neovim git node python ripgrep` |
| **Windows** | `scoop` | `scoop install neovim git nodejs python ripgrep mingw` |

### Core Requirements
- **Neovim >= 0.11.0** (Required for the latest LSP APIs)
- **Git** (For plugin management)
- **Node.js & Python 3** (Required for many LSP servers in Full Setup)
- **Nerd Font** (Recommended for icons, e.g., JetBrains Mono Nerd Font)

---

## 🗂️ Repository Structure

| Path | Contents |
|------|----------|
| `init.lua` | Entry point & lazy.nvim bootstrap |
| `lua/config/` | Core editor options, keymaps, and autocommands |
| `lua/plugins/` | Modular plugin definitions |
| `lua/plugins/lsp/` | LSP, Mason, and completion config |
| `lua/plugins/ui/` | Themes, snacks.nvim, and UI utilities |
| `ftplugin/` | Filetype-specific settings (e.g., Java) |
| `install.sh` / `install.ps1` | Automated platform installers |
| `DISCUSSIONS.md` | Deep-dives and troubleshooting |
| `PLUGIN_GUIDE.md` | Usage instructions for individual plugins |
| `SNACKS_GUIDE.md` | Documentation for all 32 snacks modules |

---

## 🔌 Core Plugin Stack

| Category | Plugins |
|----------|---------|
| **LSP & Mason** | `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig`, `mason-tool-installer` |
| **Completion** | `nvim-cmp`, `LuaSnip`, `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path` |
| **UI Framework** | `snacks.nvim` (32 modules), `mini.nvim` (27 plugins), `which-key.nvim` |
| **Navigation** | `telescope.nvim`, `mini.pick`, `harpoon`, `flash.nvim` |
| **Syntax** | `nvim-treesitter`, `rainbow-delimiters`, `Comment.nvim` |
| **Development** | `conform.nvim` (formatting), `nvim-lint`, `nvim-dap` (debugging) |
| **Git** | `gitsigns.nvim`, `vim-fugitive`, `mini.diff` |

---

## ⌨️ Essential Key Bindings

Press `<Space>` and wait to see all available keybinds via `which-key`.

### General & Navigation
| Key | Action |
|-----|--------|
| `<Space>` | Leader Key |
| `<leader>ff` | Find Files (Telescope) |
| `<leader>fg` | Live Grep (Global Search) |
| `<leader>e` | File Explorer (mini.files) |
| `<leader>w` | Save File |
| `<leader>q` | Quit Neovim |
| `<C-h/j/k/l>` | Navigate between windows |

### LSP & Code (Full Setup)
| Key | Action |
|-----|--------|
| `gd` | Go to Definition |
| `gr` | Go to References |
| `K` | Hover Documentation |
| `<leader>rn` | Rename Symbol |
| `<leader>ca` | Code Actions |
| `<leader>fm` | Format Buffer |

### Theme & UI
| Key | Action |
|-----|--------|
| `<leader>th` | Theme Switcher (Live Preview) |
| `<leader>z` | Zen Mode |
| `<leader>tt` | Toggle Terminal |
| `<leader>mm` | Toggle Minimap |

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 📄 License

This configuration is provided as-is for educational and personal use under the MIT License.
