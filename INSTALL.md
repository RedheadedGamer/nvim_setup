# Installation Guide

This guide provides detailed instructions for installing the Neovim configuration with either Full or Minimal setup.

## Table of Contents

- [Quick Start](#quick-start)
- [Installation Modes](#installation-modes)
- [Automated Installation](#automated-installation)
- [Manual Installation](#manual-installation)
- [Prerequisites](#prerequisites)
- [Switching Between Setups](#switching-between-setups)
- [Troubleshooting](#troubleshooting)

## Quick Start

The fastest way to get started:

```bash
# Download and run the installer
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash
```

The installer will guide you through choosing Full or Minimal setup.

## Installation Modes

### Full Setup (Complete IDE Experience)

**Includes:**
- ✅ LSP (Language Server Protocol) support
- ✅ Mason for automatic LSP server management
- ✅ nvim-cmp for intelligent auto-completion
- ✅ Linters and formatters (conform.nvim)
- ✅ C/C++ development suite
  - clangd LSP with enhanced features
  - CMake integration
  - DAP (Debug Adapter Protocol) support
  - Static analysis with cppcheck
  - Header/source switching
- ✅ All 28 mini.nvim plugins
- ✅ 50+ premium color themes
- ✅ Telescope with extended features
- ✅ Trouble.nvim for diagnostics
- ✅ Git integration (gitsigns, fugitive)
- ✅ Treesitter for syntax highlighting
- ✅ Which-key for keybinding discovery
- ✅ Rainbow brackets
- ✅ VimTeX for LaTeX support

**Recommended for:**
- Software development
- C/C++ programming
- Projects requiring LSP features
- Users who want the complete IDE experience

**System requirements:**
- ~500MB disk space for plugins
- Node.js (for LSP servers)
- Python (for Python LSP)
- Optional: ripgrep, C/C++ toolchain

### Minimal Setup (Lightweight Configuration)

**Includes:**
- ✅ Essential editing features
- ✅ Treesitter for syntax highlighting
- ✅ Core mini.nvim plugins (15 essential plugins)
  - mini.pairs (auto-close brackets)
  - mini.surround (surround text)
  - mini.move (move lines)
  - mini.files (file explorer)
  - mini.bufremove (better buffer management)
  - mini.statusline (statusline)
  - mini.starter (start screen)
  - mini.comment (commenting)
  - And more...
- ✅ Telescope for file finding
- ✅ 5 popular color themes (onedark, tokyonight, gruvbox, dracula, catppuccin)
- ✅ Git integration (gitsigns)
- ✅ Which-key for keybinding discovery
- ✅ VimTeX for LaTeX support

**Excludes:**
- ❌ LSP servers and Mason
- ❌ nvim-cmp completion engine
- ❌ C/C++ development tools
- ❌ Linters and formatters
- ❌ Trouble.nvim
- ❌ DAP debugging
- ❌ Additional themes (keeps only 5 most popular)

**Recommended for:**
- Quick text editing
- Systems with limited resources
- Users who prefer manual language tooling
- Learning Vim/Neovim basics
- Writing scripts, configs, or markdown

**System requirements:**
- ~100MB disk space for plugins
- No additional dependencies required
- 🚀 Faster startup time (~50-100ms)

## Automated Installation

### Using the Install Script

1. **Download and make executable:**

```bash
# Clone the repository temporarily
git clone https://github.com/RedheadedGamer/nvim_setup.git /tmp/nvim_install
cd /tmp/nvim_install

# Make the script executable
chmod +x install.sh
```

2. **Run with desired option:**

```bash
# Interactive mode (prompts for choice)
./install.sh

# Full setup (all features)
./install.sh --full

# Minimal setup (lightweight)
./install.sh --minimal

# Show help
./install.sh --help
```

3. **Follow the prompts:**
   - The script will backup any existing configuration
   - It will clone the repository to `~/.config/nvim`
   - It will configure the chosen setup
   - It will display next steps

4. **Start Neovim:**

```bash
nvim
```

Wait for plugins to install, then restart Neovim.

### One-Liner Installation

```bash
# Full setup
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash -s -- --full

# Minimal setup
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash -s -- --minimal

# Interactive
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash
```

## Manual Installation

### Full Setup (Manual)

1. **Backup existing configuration:**

```bash
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
```

2. **Clone the repository:**

```bash
git clone https://github.com/RedheadedGamer/nvim_setup.git ~/.config/nvim
```

3. **Ensure the `.minimal_setup` file does NOT exist:**

```bash
rm -f ~/.config/nvim/.minimal_setup
```

4. **Start Neovim:**

```bash
nvim
```

5. **Wait for plugin installation** and restart Neovim.

### Minimal Setup (Manual)

1. **Backup existing configuration:**

```bash
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
```

2. **Clone the repository:**

```bash
git clone https://github.com/RedheadedGamer/nvim_setup.git ~/.config/nvim
```

3. **Create the minimal setup marker:**

```bash
touch ~/.config/nvim/.minimal_setup
```

4. **Start Neovim:**

```bash
nvim
```

5. **Wait for plugin installation** and restart Neovim.

## Prerequisites

### Basic Requirements (Both Setups)

- **Neovim >= 0.9.0**
  ```bash
  # Check version
  nvim --version
  ```

- **Git**
  ```bash
  # Check if installed
  git --version
  ```

### Additional for Full Setup

#### Essential:
- **Node.js** (for LSP servers)
  ```bash
  node --version  # Should be >= 16.x
  ```

- **Python 3** (for Python LSP)
  ```bash
  python3 --version
  ```

- **ripgrep** (for better search in Telescope)
  ```bash
  rg --version
  ```

#### Optional (for C/C++ Development):
- **clang/clangd** (C/C++ LSP)
- **cmake** (build system)
- **gdb** or **codelldb** (debugging)
- **cppcheck** (static analysis)
- **ninja** (faster builds)

### Installing Prerequisites

#### Ubuntu/Debian

```bash
# Basic (required for both setups)
sudo apt update
sudo apt install neovim git

# Full setup requirements
sudo apt install nodejs npm python3 python3-pip ripgrep

# Optional C/C++ tools
sudo apt install build-essential cmake gdb clang clang-tools cppcheck ninja-build
```

#### Arch Linux

```bash
# Basic (required for both setups)
sudo pacman -Syu neovim git

# Full setup requirements
sudo pacman -S nodejs npm python python-pip ripgrep

# Optional C/C++ tools
sudo pacman -S base-devel cmake gdb clang cppcheck ninja
```

#### macOS

```bash
# Basic (required for both setups)
brew install neovim git

# Full setup requirements
brew install node python ripgrep

# Optional C/C++ tools
brew install cmake llvm cppcheck ninja
```

#### Fedora/RHEL

```bash
# Basic (required for both setups)
sudo dnf install neovim git

# Full setup requirements
sudo dnf install nodejs npm python3 python3-pip ripgrep

# Optional C/C++ tools
sudo dnf install gcc gcc-c++ cmake gdb clang clang-tools-extra cppcheck ninja-build
```

## Switching Between Setups

You can easily switch between Full and Minimal setups at any time.

### Switch to Minimal Setup

```bash
# Create the minimal marker file
touch ~/.config/nvim/.minimal_setup

# Restart Neovim and sync plugins
nvim +Lazy\ sync
```

This will:
- Load only minimal plugins on next start
- Remove unused plugins (Full-only plugins)
- Keep your configuration files intact

### Switch to Full Setup

```bash
# Remove the minimal marker file
rm ~/.config/nvim/.minimal_setup

# Restart Neovim and sync plugins
nvim +Lazy\ sync
```

This will:
- Load all plugins on next start
- Install additional plugins (LSP, Mason, etc.)
- Enable all features

### Verify Current Setup

Check which setup is active:

```bash
# Check if minimal setup is active
if [ -f ~/.config/nvim/.minimal_setup ]; then
    echo "Current setup: MINIMAL"
else
    echo "Current setup: FULL"
fi
```

Or within Neovim:
```vim
:lua print(vim.fn.filereadable(vim.fn.stdpath("config") .. "/.minimal_setup") == 1 and "MINIMAL" or "FULL")
```

## Troubleshooting

### Issue: Plugins not installing

**Solution:**
```bash
# Open Neovim and manually trigger plugin installation
nvim
:Lazy sync
```

### Issue: LSP servers not working (Full setup)

**Solution:**
```bash
# Open Mason to check installed servers
nvim
:Mason

# Install missing servers manually
:MasonInstall lua_ls pyright clangd
```

### Issue: Slow startup time

**Solutions:**

1. **Switch to minimal setup:**
```bash
touch ~/.config/nvim/.minimal_setup
```

2. **Profile startup (to identify slow plugins):**
```bash
nvim --startuptime startup.log
cat startup.log
```

3. **Lazy-load more plugins** by editing `lua/plugins/init.lua`

### Issue: Git clone fails

**Solutions:**

1. **Check internet connection**
2. **Try HTTPS instead of SSH:**
```bash
git clone https://github.com/RedheadedGamer/nvim_setup.git ~/.config/nvim
```

3. **Check if Git is installed:**
```bash
git --version
```

### Issue: Neovim version too old

**Solution:**

Install a newer version of Neovim:

```bash
# Ubuntu/Debian (PPA for latest version)
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

# Arch Linux
sudo pacman -S neovim

# macOS
brew upgrade neovim

# Or install from GitHub releases
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
```

### Issue: Permission denied when running install script

**Solution:**
```bash
chmod +x install.sh
./install.sh
```

### Issue: Configuration conflicts with existing setup

**Solution:**

The install script automatically backs up existing configurations, but you can also manually backup:

```bash
# Backup your old config
mv ~/.config/nvim ~/.config/nvim.old
mv ~/.local/share/nvim ~/.local/share/nvim.old
mv ~/.local/state/nvim ~/.local/state/nvim.old
mv ~/.cache/nvim ~/.cache/nvim.old

# Then install
./install.sh
```

### Issue: Missing colorscheme

**Solution:**

The colorscheme might not be installed yet. Wait for plugins to install:

```bash
nvim
:Lazy sync
# Wait for completion, then restart
```

Or set a fallback colorscheme in `init.lua`:
```lua
vim.cmd("colorscheme default")
```

### Getting Help

If you encounter issues not covered here:

1. **Check Neovim health:**
```bash
nvim
:checkhealth
```

2. **Check plugin status:**
```bash
nvim
:Lazy
```

3. **Check logs:**
```bash
# View Neovim log
cat ~/.local/state/nvim/log

# View lazy.nvim log
nvim
:Lazy log
```

4. **Open an issue:**
   Visit: https://github.com/RedheadedGamer/nvim_setup/issues

## Next Steps

After installation:

1. **Learn the keybindings:**
   - Press `<Space>` (leader key) and wait to see available commands
   - See [README.md](README.md) for complete keybinding reference

2. **Customize:**
   - Edit `lua/config/options.lua` for editor options
   - Edit `lua/config/keymaps.lua` for custom keymaps
   - Edit `lua/plugins/init.lua` to add/remove plugins

3. **Install language servers (Full setup):**
   ```bash
   nvim
   :Mason
   # Install servers for your languages
   ```

4. **Set your preferred theme:**
   ```bash
   nvim
   # Press <Space>th to open theme switcher
   ```

5. **Read the documentation:**
   - [README.md](README.md) - Main documentation
   - [PLUGIN_GUIDE.md](PLUGIN_GUIDE.md) - Detailed plugin usage

Enjoy your new Neovim configuration! 🚀
