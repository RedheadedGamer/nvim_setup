# 🐛 Debugging Guide - GDB GEF & Valgrind Integration

This guide covers the comprehensive debugging capabilities integrated into the Neovim configuration, including GDB, GEF (GDB Enhanced Features), and Valgrind support.

## 🚀 Quick Start

### Basic Debug Session
1. Open a C/C++ file
2. Set breakpoints with `<leader>b` or `<F9>`
3. Start debugging with `<F5>`
4. Use `<F10>` (step over), `<F11>` (step into), `<F12>` (step out)

### Memory Analysis
1. Press `<leader>dM` to open memory analysis tools
2. Select Valgrind tool (memcheck, helgrind, etc.)
3. Specify executable and arguments
4. Review results in terminal window

## 🔧 Available Tools

### Core Debugging
- **nvim-dap**: Debug Adapter Protocol support
- **nvim-dap-ui**: Rich debugging interface
- **nvim-dap-virtual-text**: Inline variable values

### Memory Analysis
- **Valgrind Memcheck**: Memory leak detection
- **Valgrind Helgrind**: Race condition detection
- **Valgrind DRD**: Thread error detection
- **Valgrind Massif**: Heap profiling
- **Valgrind Cachegrind**: Cache performance analysis
- **Valgrind Callgrind**: Call graph profiling

### Enhanced Debugging
- **GEF**: Modern GDB enhancements
- **Binary Analysis**: Security and structure analysis

## ⌨️ Keybindings

### Function Keys (Standard Debug Controls)
```
<F5>     - Continue/Start debugging
<F10>    - Step over
<F11>    - Step into  
<F12>    - Step out
```

### Leader Key Combinations
```
<leader>b     - Toggle breakpoint
<leader>db    - Toggle breakpoint (alternative)
<leader>dB    - Conditional breakpoint
<leader>dc    - Continue
<leader>dt    - Terminate debug session
<leader>dr    - Toggle REPL
<leader>du    - Toggle debug UI
<leader>de    - Evaluate expression
```

### Advanced Debug Features
```
<leader>dM    - Memory analysis tools menu
<leader>dS    - Security analysis tools
<leader>dT    - Debug templates
<leader>dI    - Debug tools information
```

### GEF Integration
```
<leader>dgf   - Launch with GEF
<leader>dgc   - GEF commands menu
```

### Valgrind Shortcuts
```
<leader>dv    - Valgrind (generic)
<leader>dvm   - Valgrind Memcheck
<leader>dvh   - Valgrind Helgrind (race conditions)
<leader>dvd   - Valgrind DRD (thread errors)
<leader>dvs   - Valgrind Massif (heap profiling)
<leader>dvo   - Valgrind Cachegrind (cache analysis)
<leader>dvp   - Valgrind Callgrind (call profiling)
```

### Quick Session Management
```
<leader>dqs   - Quick stop debug session
<leader>dqr   - Quick restart debug session
```

## 🛠️ Configuration Examples

### C/C++ Debugging with GDB
```lua
{
  name = "Launch (GDB)",
  type = "gdb", 
  request = "launch",
  program = function()
    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  end,
  cwd = "${workspaceFolder}",
}
```

### C/C++ Debugging with GEF
```lua
{
  name = "Launch with GEF",
  type = "gef",
  request = "launch", 
  program = function()
    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  end,
  cwd = "${workspaceFolder}",
}
```

### Python Debugging
```lua
{
  type = "python",
  request = "launch",
  name = "Launch file",
  program = "${file}",
  pythonPath = "/usr/bin/python3",
}
```

## 🔍 Memory Analysis Workflows

### 1. Memory Leak Detection
```bash
# Using Valgrind Memcheck
<leader>dvm
# Select executable and arguments
# Review leak summary and detailed reports
```

### 2. Race Condition Detection
```bash
# Using Valgrind Helgrind
<leader>dvh
# Analyze threading issues
# Review race condition reports
```

### 3. Performance Analysis
```bash
# Using Valgrind Cachegrind
<leader>dvo
# Analyze cache performance
# Use kcachegrind for visualization
```

## 🦊 GEF Enhanced Features

### Available GEF Commands
- `checksec` - Binary security analysis
- `vmmap` - Virtual memory mapping
- `heap bins/chunks` - Heap analysis
- `got/plt` - GOT/PLT table analysis
- `elf-info` - ELF binary information
- `ropper` - ROP gadget search
- `pattern create/search` - Exploit development

### Usage
1. Start debugging with GEF: `<leader>dgf`
2. Access GEF commands: `<leader>dgc`
3. Select command from menu
4. Commands execute in GEF-enabled GDB session

## 🔒 Security Analysis

### Binary Analysis Tools
```
<leader>dS - Security analysis menu
```

Available analyses:
- File type and architecture detection
- Security feature detection (checksec)
- String analysis
- ELF header examination
- Section analysis
- Symbol table inspection
- Disassembly preview

## 📊 Tool Status Check

Use `<leader>dI` to check availability of debugging tools:
- ✅ GDB installation status
- ✅ Valgrind availability  
- ✅ GEF installation and path
- ✅ Python debugpy status
- ✅ Debug adapter installations

## 🚀 Installation Requirements

### Required Tools
```bash
# Ubuntu/Debian
sudo apt install gdb valgrind

# Arch Linux
sudo pacman -S gdb valgrind

# macOS
brew install gdb valgrind
```

### GEF Installation
```bash
# Install GEF (GDB Enhanced Features)
wget -O ~/.gef.py https://github.com/hugsy/gef/raw/main/gef.py
echo 'source ~/.gef.py' >> ~/.gdbinit
```

### Python Debug Support
```bash
# Install debugpy for Python debugging
pip install debugpy
```

## 🎯 Debug Templates

Use `<leader>dT` to access predefined debug configurations:
- C/C++ with GDB
- C/C++ with GEF enhancement
- Python script debugging
- Node.js application debugging

## 💡 Tips and Best Practices

### 1. Efficient Breakpoint Management
- Use conditional breakpoints for complex scenarios
- Set breakpoints before starting debug session
- Use virtual text to see variable values inline

### 2. Memory Analysis Workflow
- Start with memcheck for general memory issues
- Use helgrind for threading problems
- Profile with massif for heap analysis
- Analyze performance with cachegrind

### 3. GEF Integration
- Use GEF for modern debugging features
- Leverage pattern creation for exploit development
- Analyze binary security with checksec

### 4. Performance Considerations
- Debug in release builds for performance analysis
- Use callgrind for detailed profiling
- Combine with external visualization tools

## 🔧 Troubleshooting

### Common Issues

1. **GDB not found**
   - Install GDB package for your system
   - Check PATH includes GDB location

2. **GEF not loading**
   - Verify GEF installation path
   - Check ~/.gdbinit configuration
   - Ensure Python 3 support in GDB

3. **Valgrind errors**
   - Compile with debug symbols (-g flag)
   - Disable optimizations for debugging
   - Check file permissions

4. **Debug adapter issues**
   - Use `:Mason` to install/update adapters
   - Check Mason log for installation errors
   - Verify language runtime availability

### Debug Information
Use `:lua require('config.debugging').check_debug_tools()` for detailed tool status.

## 📚 Additional Resources

- [GDB Documentation](https://www.gnu.org/software/gdb/documentation/)
- [GEF Documentation](https://gef.readthedocs.io/)
- [Valgrind User Manual](https://valgrind.org/docs/manual/manual.html)
- [nvim-dap Wiki](https://github.com/mfussenegger/nvim-dap/wiki)

---

This debugging setup provides a comprehensive development environment for C/C++, Python, and JavaScript/TypeScript debugging with advanced memory analysis and security features.