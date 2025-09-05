# C/C++ LSP Priority Configuration

This document explains how the Neovim configuration prioritizes C/C++ Language Server Protocol (LSP) support to ensure it works "from boot" with comprehensive fallbacks and safety measures.

## 🎯 Priority System

### 1. Early Detection (Boot Time)
- **File Detection**: Automatically detects C/C++ projects on startup
- **Pre-check**: Verifies clangd availability before plugin loading
- **User Notification**: Provides immediate feedback about C/C++ development readiness

### 2. Bootstrap Process
The configuration implements a multi-stage bootstrap process for clangd:

```lua
-- 1. System PATH check
if vim.fn.executable("clangd") == 1 then
  -- Use system clangd immediately
end

-- 2. Mason registry check
if mason_registry.get_package("clangd"):is_installed() then
  -- Use Mason-installed clangd
end

-- 3. Automatic installation
clangd_pkg:install() -- Install via Mason if needed

-- 4. Fallback notification
-- Provide manual installation instructions
```

### 3. Command Variations
Multiple clangd command configurations for maximum compatibility:

1. **Full Featured**: `clangd --background-index --clang-tidy --header-insertion=iwyu --completion-style=detailed`
2. **Standard**: `clangd --background-index --header-insertion=iwyu`
3. **Minimal**: `clangd --background-index`
4. **Basic**: `clangd`

## 🔧 Automatic Setup Features

### File Type Detection
- Monitors for: `*.c`, `*.cpp`, `*.h`, `*.hpp`, `*.cc`, `*.cxx`
- Auto-restarts LSP if clangd becomes available after file opening
- Provides context-aware notifications

### Mason Integration
- **Priority Installation**: clangd is first in the `ensure_installed` list
- **Immediate Bootstrap**: Attempts installation right after Mason setup
- **Auto-restart**: Restarts LSP for open C/C++ files after successful installation

### Error Handling
- Graceful degradation if Mason fails to load
- Fallback to system package manager instructions
- Non-blocking operation (doesn't prevent other plugins from loading)

## 🚀 User Experience

### Startup Messages
- `🔍 C/C++ project detected - prioritizing clangd setup`
- `✅ clangd ready for C/C++ development`
- `🔧 Installing clangd via Mason...`
- `⚠️ clangd not found - will attempt installation via Mason`

### Installation Status
- Real-time feedback during clangd installation
- Automatic LSP restart after successful installation
- Clear instructions for manual installation if needed

## 📋 Installation Methods (Priority Order)

### 1. System Package Manager (Recommended)
```bash
# Ubuntu/Debian
sudo apt install clangd

# macOS
brew install llvm

# Arch Linux
sudo pacman -S clang
```

### 2. Mason (Automatic)
- Automatically installed when Mason is available
- No user intervention required
- Managed within Neovim environment

### 3. Manual Installation
- Fallback instructions provided in notifications
- Links to official LLVM releases
- Platform-specific guidance

## 🔍 Verification

Use the included test script to verify the configuration:

```bash
nvim --headless -c "lua dofile('test_clangd_priority.lua')" -c "qa"
```

This will test:
- ✅ Clangd bootstrap logic
- ✅ C/C++ file detection
- ✅ Mason registry integration
- ✅ Command variation handling

## 🎮 Usage

### Immediate LSP Features (when clangd is available)
- **Go to Definition**: `gd`
- **Hover Documentation**: `K`
- **Find References**: `gr`
- **Code Actions**: `<leader>ca`
- **Rename Symbol**: `<leader>rn`
- **Format Code**: `<leader>fm`

### Diagnostics and Completion
- Real-time error checking with clang-tidy integration
- Intelligent code completion with detailed suggestions
- Header insertion and include management

## 🛡️ Fallbacks and Safety

### If clangd is not available
1. **Syntax Highlighting**: Still works via Treesitter
2. **Basic Navigation**: File-based navigation remains functional
3. **Installation Guidance**: Clear instructions provided
4. **Non-blocking**: Other LSP servers continue to work normally

### Compatibility
- **Minimum**: Works with any Neovim 0.7+
- **Recommended**: Neovim 0.8+ with Mason support
- **Optimal**: System clangd + Neovim 0.9+

## 🔄 Auto-Recovery

The configuration includes automatic recovery mechanisms:

1. **File Open Trigger**: Attempts clangd setup when opening C/C++ files
2. **Mason Ready**: Re-attempts setup when Mason becomes available
3. **Installation Complete**: Auto-restarts LSP after successful clangd installation

This ensures C/C++ LSP support is always prioritized and becomes available as soon as possible, even if initial setup fails.