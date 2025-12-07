# Windows Troubleshooting Guide

This guide addresses common issues when setting up the Neovim configuration on Windows.

## Table of Contents

- [Mason Installation Errors](#mason-installation-errors)
- [C/C++ Compilation Issues](#cc-compilation-issues)
- [LSP Server Issues](#lsp-server-issues)
- [General Windows Issues](#general-windows-issues)

---

## Mason Installation Errors

### Issue: "codelldb.cmd is already linked" Error

**Error Message:**
```
[ERROR] ...zy/mason.nvim/lua/mason-core/installer/InstallRunner.lua:93: 
Installation failed for Package(name=codelldb) error='"C:/Users/username/AppData/Local/nvim-data/mason/bin/codelldb.cmd" is already linked.'
```

**Cause:** 
Mason attempted to install `codelldb` but found an existing symlink or file at the installation location, possibly from a previous incomplete installation or manual installation.

**Solutions:**

#### Option 1: Clean Mason Installation (Recommended)

1. **Exit Neovim completely**

2. **Remove Mason data directory** (PowerShell):
   ```powershell
   Remove-Item -Recurse -Force $env:LOCALAPPDATA\nvim-data\mason
   ```

3. **Restart Neovim:**
   ```powershell
   nvim
   ```

4. **Wait for Mason to reinstall all tools automatically**, or manually trigger:
   ```vim
   :MasonInstall codelldb
   ```

#### Option 2: Remove Specific Tool Link

1. **Check if the file exists** (PowerShell):
   ```powershell
   Test-Path $env:LOCALAPPDATA\nvim-data\mason\bin\codelldb.cmd
   ```

2. **Remove the problematic file**:
   ```powershell
   Remove-Item $env:LOCALAPPDATA\nvim-data\mason\bin\codelldb.cmd -Force
   ```

3. **Reinstall in Neovim:**
   ```vim
   :MasonUninstall codelldb
   :MasonInstall codelldb
   ```

#### Option 3: Use Alternative Debugger

If `codelldb` continues to have issues, you can use the native Windows debugger:

1. **Install Visual Studio Build Tools** with C++ support (includes debuggers)

2. **Or install via Scoop:**
   ```powershell
   scoop install gdb
   ```

3. **Update Mason config** to use `gdb` instead (optional):
   Edit `lua/plugins/init.lua` and modify the debugger list if needed.

---

## C/C++ Compilation Issues

### Issue: Clang Cannot Find stdio.h

**Error Message:**
```
fatal error: 'stdio.h' file not found
```

**Cause:**
Clang on Windows needs proper system headers. The issue occurs when:
- LLVM/Clang from Scoop doesn't have Windows SDK headers
- MinGW is not properly configured
- System include paths are not set correctly

**Solutions:**

#### Solution 1: Use MinGW Instead of LLVM (Recommended for Windows)

MinGW provides a complete GCC toolchain with all necessary headers:

1. **Uninstall LLVM and install MinGW** (PowerShell):
   ```powershell
   scoop uninstall llvm
   scoop install mingw
   ```

2. **Verify GCC installation:**
   ```powershell
   gcc --version
   g++ --version
   ```

3. **Configure Mason to use GCC:**
   Mason's `clangd` will automatically detect MinGW's GCC headers.

4. **Restart Neovim:**
   ```powershell
   nvim
   ```

#### Solution 2: Install Visual Studio Build Tools

For best Windows C++ support, install Microsoft's official tools:

1. **Download Visual Studio Build Tools:**
   - Visit: https://visualstudio.microsoft.com/downloads/
   - Download "Build Tools for Visual Studio"

2. **During installation, select:**
   - ✅ Desktop development with C++
   - ✅ Windows 10/11 SDK
   - ✅ MSVC v143 - VS 2022 C++ build tools

3. **After installation, restart your terminal and Neovim**

4. **Clangd will automatically detect MSVC headers**

#### Solution 3: Configure Clang to Use MinGW Headers

If you want to keep LLVM/Clang:

1. **Install MinGW alongside LLVM:**
   ```powershell
   scoop install mingw llvm
   ```

2. **Create or edit** `.clangd` file in your project root:
   ```yaml
   CompileFlags:
     Add:
       - -IC:/Users/YourUsername/scoop/apps/mingw/current/include
       - -IC:/Users/YourUsername/scoop/apps/mingw/current/lib/gcc/x86_64-w64-mingw32/*/include
   ```
   Replace `YourUsername` with your actual username.

3. **Alternative:** Set environment variable (PowerShell - add to profile):
   ```powershell
   $env:CPATH = "C:\Users\YourUsername\scoop\apps\mingw\current\include"
   ```

#### Solution 4: Use WSL for C/C++ Development

For a Linux-like experience:

1. **Install WSL2:**
   ```powershell
   wsl --install
   ```

2. **Install Neovim inside WSL:**
   ```bash
   sudo apt update
   sudo apt install neovim build-essential
   ```

3. **Use the Linux installation method** from the main README

---

## LSP Server Issues

### Issue: LSP Servers Not Starting on Windows

**Symptoms:**
- No code completion
- No hover documentation
- `:LspInfo` shows no attached clients

**Solutions:**

1. **Check Mason installation:**
   ```vim
   :Mason
   ```
   Verify all LSP servers are installed (green checkmark).

2. **Check LSP logs:**
   ```vim
   :LspLog
   ```
   Look for error messages indicating missing dependencies.

3. **For clangd specifically:**
   - Ensure either MinGW or Visual Studio Build Tools are installed
   - Check that `clangd` can find system headers:
     ```powershell
     clangd --version
     ```

4. **Restart LSP:**
   ```vim
   :LspRestart
   ```

### Issue: Node.js-based LSP Servers Fail

**Cause:** Node.js not in PATH or wrong version.

**Solution:**

1. **Verify Node.js installation:**
   ```powershell
   node --version
   npm --version
   ```

2. **Reinstall if needed:**
   ```powershell
   scoop install nodejs
   ```

3. **Ensure it's in PATH:** Close and reopen PowerShell/Neovim after installing.

---

## General Windows Issues

### Issue: PowerShell Execution Policy Blocks Scripts

**Error:**
```
install.ps1 cannot be loaded because running scripts is disabled on this system
```

**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Issue: Git Clone Fails

**Cause:** Git not installed or not in PATH.

**Solution:**
```powershell
scoop install git
```

### Issue: Terminal Colors Not Displaying Correctly

**Solution:**
1. Install Windows Terminal from Microsoft Store
2. Or update to Windows 11 which has better terminal support
3. Or use a different color scheme in Neovim: `<leader>th`

### Issue: Paths with Spaces Cause Problems

**Cause:** Windows paths often contain spaces (e.g., "Program Files").

**Solution:**
- The config handles this automatically using `vim.fn.stdpath()`
- If you manually specify paths, use quotes: `"C:/Program Files/tool"`
- Or use 8.3 format: `C:/PROGRA~1/tool`

### Issue: Mason Tools Install to Wrong Location

**Expected Location:** `$env:LOCALAPPDATA\nvim-data\mason`

**If installing elsewhere:**

1. **Check Neovim data path:**
   ```vim
   :echo stdpath('data')
   ```

2. **If incorrect, set explicitly** in your PowerShell profile:
   ```powershell
   $env:XDG_DATA_HOME = "$env:LOCALAPPDATA"
   ```

---

## Quick Fixes Summary

### For "codelldb is already linked" error:
```powershell
Remove-Item -Recurse -Force $env:LOCALAPPDATA\nvim-data\mason
```
Then restart Neovim.

### For "stdio.h not found" error:
```powershell
scoop uninstall llvm
scoop install mingw
```
Then restart Neovim.

### For LSP not working:
```vim
:Mason          " Check installation
:LspInfo        " Check status
:LspRestart     " Restart LSP
:checkhealth    " Run health check
```

---

## Getting More Help

If these solutions don't work:

1. **Run health check in Neovim:**
   ```vim
   :checkhealth
   ```

2. **Check Mason logs:**
   ```vim
   :MasonLog
   ```

3. **Check LSP logs:**
   ```vim
   :LspLog
   ```

4. **Verify prerequisites with verification script:**
   ```powershell
   .\verify_setup.ps1
   ```

5. **Report the issue** with:
   - Windows version
   - PowerShell version: `$PSVersionTable.PSVersion`
   - Neovim version: `nvim --version`
   - Scoop packages: `scoop list`
   - Full error message from `:messages` or `:LspLog`

---

## Recommended Windows Setup

For the best experience on Windows:

1. **Use Windows Terminal** (from Microsoft Store)
2. **Install MinGW for C/C++** (not just LLVM)
3. **Keep Scoop updated:** `scoop update *`
4. **Use PowerShell 7+** (not Windows PowerShell 5.1)
5. **Consider WSL2** for heavy development work

### Ideal Scoop Installation:

```powershell
# Core tools
scoop install neovim git nodejs python ripgrep

# C/C++ with MinGW (includes GCC, G++, GDB, and all headers)
scoop install mingw cmake

# Optional: Better terminal
scoop install windows-terminal

# Optional: Modern PowerShell
scoop install pwsh
```

This setup provides the most compatible and hassle-free experience on Windows.
