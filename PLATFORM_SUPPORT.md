# Platform Support Guide

This Neovim configuration is designed to work seamlessly across multiple platforms with proper package manager support.

## Supported Platforms

### ✅ Fully Supported

- **Arch Linux** (pacman)
- **Ubuntu/Debian** (apt)
- **Fedora/RHEL** (dnf)
- **macOS** (Homebrew)
- **Windows 10/11** (Scoop)

### 🔧 Other Linux Distributions

Most Linux distributions should work with manual package installation. See the [Manual Installation](#manual-installation) section.

## Platform-Specific Information

### Arch Linux

**Package Manager:** `pacman`

**Installation Script:** `install.sh`

**Config Location:** `~/.config/nvim`

**Prerequisites:**
```bash
# Basic requirements
sudo pacman -Syu neovim git

# Full setup requirements
sudo pacman -S nodejs npm python python-pip ripgrep

# C/C++ development (optional)
sudo pacman -S base-devel cmake gdb clang cppcheck bear ninja
```

**Verified LSP Servers:**
- All Mason LSP servers work natively on Arch Linux
- `asm_lsp` requires manual installation: `cargo install asm-lsp` or AUR
- Native clangd available via `clang` package

**Known Issues:**
- None currently reported

---

### Ubuntu/Debian

**Package Manager:** `apt`

**Installation Script:** `install.sh`

**Config Location:** `~/.config/nvim`

**Prerequisites:**
```bash
# Basic requirements
sudo apt update
sudo apt install neovim git

# Full setup requirements
sudo apt install nodejs npm python3 python3-pip ripgrep

# C/C++ development (optional)
sudo apt install build-essential cmake gdb clang clang-tools cppcheck bear ninja-build
```

**Verified LSP Servers:**
- All Mason LSP servers work with proper Node.js installation
- Recommend installing Node.js via NodeSource if apt version is too old

**Known Issues:**
- Default Neovim version in Ubuntu 20.04 may be outdated. Consider using [Neovim PPA](https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable)

---

### macOS

**Package Manager:** `brew` (Homebrew)

**Installation Script:** `install.sh`

**Config Location:** `~/.config/nvim`

**Prerequisites:**
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Basic requirements
brew install neovim git

# Full setup requirements
brew install node python ripgrep

# C/C++ development (optional)
brew install cmake llvm cppcheck bear ninja
```

**Verified LSP Servers:**
- All Mason LSP servers work on macOS
- XCode Command Line Tools recommended for C/C++ development: `xcode-select --install`

**Known Issues:**
- None currently reported

---

### Windows 10/11

**Package Manager:** `scoop`

**Installation Script:** `install.ps1` (PowerShell)

**Config Location:** `$env:LOCALAPPDATA\nvim` (typically `C:\Users\YourUsername\AppData\Local\nvim`)

**Prerequisites:**

First, install Scoop:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

Then install packages:
```powershell
# Basic requirements
scoop install neovim git

# Full setup requirements
scoop install nodejs python ripgrep

# C/C++ development (optional)
scoop install mingw cmake llvm

# Additional buckets for more packages
scoop bucket add extras
scoop bucket add versions
```

**Verified LSP Servers:**
- ✅ `lua_ls` - Works natively
- ✅ `pyright` - Works with Python from Scoop
- ✅ `ts_ls` - Works with Node.js from Scoop
- ✅ `html`, `cssls`, `jsonls` - Work natively
- ✅ `clangd` - Works with LLVM from Scoop or mingw
- ✅ `bashls` - Works (for Git Bash/WSL scripts)
- ✅ `jdtls` - Works with Java JDK
- ✅ `cmake` - Works with CMake from Scoop
- ✅ `marksman` - Works natively
- ⚠️ `asm_lsp` - May require manual Rust/Cargo installation

**Windows-Specific Notes:**
- Use PowerShell (not Command Prompt) for installation
- Git from Scoop includes Git Bash for Unix-like commands
- Mason installs LSP servers to `$env:LOCALAPPDATA\nvim-data\mason`
- **Recommended:** Use MinGW instead of standalone LLVM for C/C++ development (includes all system headers)
- For best C/C++ support, install Visual Studio Build Tools with C++ workload
- Path separators are automatically handled by Neovim's Lua API

**Known Issues:**
- **codelldb linking error:** Mason may report "already linked" error. Solution: Remove Mason data directory and reinstall
- **stdio.h not found:** Clang from LLVM package lacks Windows headers. Solution: Use MinGW or Visual Studio Build Tools
- Terminal colors may not display correctly in older Windows Terminal versions (use Windows Terminal from Microsoft Store)
- Some Unix-specific shell integrations may not work (e.g., bash-specific autocomplete)

**See [WINDOWS_TROUBLESHOOTING.md](WINDOWS_TROUBLESHOOTING.md) for detailed solutions to common Windows issues.**

---

## LSP Server Compatibility Matrix

| LSP Server | Arch | Ubuntu | macOS | Windows | Notes |
|------------|------|--------|-------|---------|-------|
| lua_ls | ✅ | ✅ | ✅ | ✅ | Works everywhere |
| pyright | ✅ | ✅ | ✅ | ✅ | Requires Python |
| ts_ls | ✅ | ✅ | ✅ | ✅ | Requires Node.js |
| html | ✅ | ✅ | ✅ | ✅ | Works everywhere |
| cssls | ✅ | ✅ | ✅ | ✅ | Works everywhere |
| jsonls | ✅ | ✅ | ✅ | ✅ | Works everywhere |
| clangd | ✅ | ✅ | ✅ | ✅ | Best with native clang |
| jdtls | ✅ | ✅ | ✅ | ✅ | Requires Java JDK |
| cmake | ✅ | ✅ | ✅ | ✅ | Works everywhere |
| bashls | ✅ | ✅ | ✅ | ⚠️ | Limited on Windows |
| marksman | ✅ | ✅ | ✅ | ✅ | Works everywhere |
| asm_lsp | ⚠️ | ⚠️ | ✅ | ⚠️ | May need manual install |

Legend:
- ✅ Fully supported and tested
- ⚠️ Works with additional setup
- ❌ Not supported

---

## Cross-Platform Features

### Working Everywhere

- ✅ Plugin management via lazy.nvim
- ✅ LSP with Mason auto-installation
- ✅ Auto-completion with nvim-cmp
- ✅ Syntax highlighting with Treesitter
- ✅ Telescope fuzzy finding
- ✅ Git integration (gitsigns, fugitive)
- ✅ All mini.nvim plugins
- ✅ Theme switching
- ✅ File navigation
- ✅ Code formatting and linting

### Platform-Specific Considerations

**File Paths:**
- The configuration automatically detects OS and uses appropriate path separators
- `vim.fn.stdpath()` used for cross-platform paths
- Home directory detection: `~` (Unix) vs `%USERPROFILE%` (Windows)

**Shell Commands:**
- Most commands work across platforms
- Windows uses PowerShell by default in newer Neovim versions
- Git Bash provides Unix-like environment on Windows

**Terminal Integration:**
- Built-in terminal works on all platforms
- Toggle terminal: `<leader>t;`
- Windows users should use Windows Terminal for best experience

---

## Installation Methods

### Quick Install (Recommended)

**Linux/macOS:**
```bash
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/RedheadedGamer/nvim_setup.git $env:TEMP\nvim_install
cd $env:TEMP\nvim_install
.\install.ps1
```

### Manual Install

See [INSTALL.md](INSTALL.md) for detailed manual installation instructions for each platform.

---

## Testing Checklist

Use this checklist to verify the configuration works on your platform:

### Basic Functionality
- [ ] Neovim starts without errors
- [ ] Lazy.nvim installs plugins successfully
- [ ] Config files load without errors (check `:messages`)
- [ ] Colorscheme applies correctly
- [ ] File explorer opens (`<leader>e`)

### LSP Features (Full Setup Only)
- [ ] Mason opens (`:Mason`)
- [ ] LSP servers install automatically
- [ ] Hover documentation works (`K`)
- [ ] Go to definition works (`gd`)
- [ ] Code completion appears
- [ ] Diagnostics show errors/warnings

### File Operations
- [ ] Can open files with Telescope (`<leader>ff`)
- [ ] Can search in files (`<leader>fg`)
- [ ] Can save files (`:w`)
- [ ] Git integration shows changes (if in git repo)

### Cross-Platform Paths
- [ ] Config file opens correctly (`<leader>cc`)
- [ ] Help tags work (`:help`)
- [ ] Mason installs to correct data directory

---

## Troubleshooting

### All Platforms

**Issue:** Plugins not installing
```
Solution: Run :Lazy sync in Neovim
```

**Issue:** LSP servers not working
```
Solution: 
1. Check Mason: :Mason
2. Install missing servers manually
3. Restart Neovim: :LspRestart
```

### Windows-Specific

**Issue:** PowerShell execution policy blocks script
```powershell
Solution: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Issue:** Git clone fails
```powershell
Solution: Install Git via Scoop: scoop install git
```

**Issue:** Mason fails to install tools
```
Solution: Ensure Node.js and Python are in PATH
Check with: node --version, python --version
```

### Linux-Specific

**Issue:** Neovim version too old
```bash
# Arch
sudo pacman -Syu neovim

# Ubuntu (add PPA)
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update && sudo apt install neovim
```

---

## Contributing

Found a platform-specific issue? Please report it with:
1. Operating system and version
2. Package manager and versions of key tools (neovim, node, python)
3. Error messages from `:messages` or `:checkhealth`
4. Steps to reproduce

---

## Version Requirements

| Tool | Minimum Version | Recommended |
|------|----------------|-------------|
| Neovim | 0.9.0 | 0.11.0+ |
| Node.js | 16.x | 20.x LTS |
| Python | 3.8 | 3.11+ |
| Git | 2.0 | Latest |

---

## Additional Resources

- [Main README](README.md) - Feature overview and key bindings
- [Installation Guide](INSTALL.md) - Detailed installation instructions
- [Plugin Guide](PLUGIN_GUIDE.md) - Comprehensive plugin usage
- [Scoop Documentation](https://scoop.sh/) - Windows package manager
- [Homebrew Documentation](https://brew.sh/) - macOS package manager
