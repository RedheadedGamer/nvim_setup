# Compatibility and Fallback Fixes

This document describes the fixes applied to make the Neovim configuration more robust and compatible with various system configurations.

## Issues Addressed

### 1. nvim-notify Compatibility Issue

**Problem**: Error "attempt to call field 'ge' (a nil value)" occurred when using nvim-notify on older Neovim versions.

**Solution**: Added version checking in nvim-notify configuration:
```lua
-- Check for Neovim version compatibility (nvim-notify requires vim.version.ge which is 0.8+)
local version_ok = vim.version and vim.version.ge and vim.version.ge(vim.version(), {0, 8, 0})

if not version_ok then
  -- Fallback for older Neovim versions
  vim.notify = function(msg, level)
    local levels = { "ERROR", "WARN", "INFO", "DEBUG" }
    local level_name = levels[level] or "INFO"
    print(string.format("[%s] %s", level_name, tostring(msg)))
  end
  return
end
```

### 4. Ripgrep Dependency Fallbacks

**Problem**: Missing ripgrep on Ubuntu systems without sudo access caused telescope and grep functionality to fail.

### 2. Completion Failsafes for LSP Dependencies

**Problem**: Autocompletion degraded or failed when LSP servers couldn't start due to missing sudo access or ripgrep dependencies.

**Solution**: Enhanced nvim-cmp configuration with dynamic source detection and comprehensive fallbacks:

#### A. Dynamic Completion Source Detection
```lua
-- Before: Hardcoded LSP sources that fail silently
sources = {
  { name = "nvim_lsp" },  -- Always included, even if unavailable
  { name = "luasnip" },
  { name = "buffer" },
  { name = "path" },
}

-- After: Dynamic detection based on availability
local function get_completion_sources()
  local sources = {}
  
  -- Check if LSP completion is available
  local lsp_available = false
  local cmp_nvim_lsp_ok = pcall(require, "cmp_nvim_lsp")
  if cmp_nvim_lsp_ok then
    lsp_available = true
    table.insert(sources, { name = "nvim_lsp", priority = 1000 })
  end
  
  -- Add other sources with safe loading...
  return sources
end
```

#### B. Runtime LSP Integration
```lua
-- Add LSP completion when servers become available
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    -- Dynamically add LSP source when servers start
    if not has_lsp_source then
      cmp.setup({ sources = new_sources })
      vim.notify("🔄 Completion sources updated: LSP now available")
    end
  end,
})
```

#### C. Multi-Level Snippet Fallbacks
```lua
snippet = {
  expand = function(args)
    if luasnip_ok then
      luasnip.lsp_expand(args.body)
    elseif vim.snippet and vim.snippet.expand then
      vim.snippet.expand(args.body)  -- Neovim 0.10+ fallback
    else
      vim.api.nvim_put({ args.body }, "c", true, true)  -- Final fallback
    end
  end,
}
```

**Solutions**:

#### A. Telescope Configuration
Added fallback vimgrep arguments:
```lua
-- Fallback to grep if ripgrep is not available
if vim.fn.executable("rg") ~= 1 then
  vimgrep_arguments = {
    "grep",
    "-r", 
    "-n",
    "-H",
    "--exclude-dir=.git",
    "--exclude-dir=node_modules",
    "--exclude=*.min.js",
    "--exclude=*.log"
  }
end
```

#### B. Grep Settings in options.lua
```lua
-- Grep settings with fallback support
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --hidden --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
elseif vim.fn.executable("grep") == 1 then
  -- Fallback to system grep with reasonable options
  opt.grepprg = "grep -r -n -H --exclude-dir=.git --exclude-dir=node_modules --exclude='*.min.js' --exclude='*.log'"
  opt.grepformat = "%f:%l:%m"
else
  -- Final fallback to internal grep
  opt.grepprg = "internal"
end
```

#### C. Safe Telescope Commands
Created wrapper functions that fallback to mini.pick:
```lua
local function safe_telescope_cmd(cmd, fallback_fn, desc)
  return function()
    local telescope_ok, telescope_builtin = pcall(require, "telescope.builtin")
    if telescope_ok and telescope_builtin[cmd] then
      telescope_builtin[cmd]()
    else
      if fallback_fn then
        fallback_fn()
      else
        vim.notify("Telescope not available, using fallback", vim.log.levels.WARN)
        vim.cmd("edit .")
      end
    end
  end
end
```

### 3. Mason and LSP Robustness

**Problem**: Mason and LSP configuration could fail silently.

**Solutions**:

#### A. Error Handling for Mason
```lua
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  vim.notify("Mason failed to load, LSP servers may need manual installation", vim.log.levels.WARN)
  return
end
```

#### B. Clangd Prioritization
Moved clangd to the top of the ensure_installed list and enhanced its configuration:
```lua
ensure_installed = {
  "clangd",     -- C/C++ LSP (prioritized as default)
  "lua_ls",
  "pyright", 
  -- ... other servers
},
```

Enhanced clangd configuration:
```lua
clangd = {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = function() 
    return vim.loop.cwd() 
  end,
  settings = {
    clangd = {
      fallbackFlags = { "-std=c++17" },
    },
  },
},
```

### 5. Global Safety Measures

**Problem**: Various plugins could fail and break the entire configuration.

**Solution**: Added global error handling in init.lua:
```lua
-- Add global error handling for better plugin compatibility
vim.schedule(function()
  -- Ensure vim.notify has a safe fallback even if nvim-notify fails
  if not vim.notify then
    vim.notify = function(msg, level)
      local levels = { "ERROR", "WARN", "INFO", "DEBUG" }
      local level_name = levels[level] or "INFO"
      print(string.format("[%s] %s", level_name, tostring(msg)))
    end
  end
end)
```

## Alternative Tools Available

The configuration now supports these fallback chains:

1. **File Finding**: Telescope find_files → mini.pick files → built-in file browser
2. **Live Grep**: Telescope live_grep (with rg) → Telescope live_grep (with grep) → mini.pick grep_live
3. **Buffer Management**: Telescope buffers → mini.pick buffers → built-in buffer list
4. **Help System**: Telescope help_tags → mini.pick help → built-in help
5. **Code Completion**: LSP completion → snippet completion → buffer/path completion → manual completion

## Validation

Run the validation script to test your configuration:
```bash
cd /path/to/nvim_setup
lua validate_config.lua
```

## System Requirements

### Minimal Requirements
- Neovim 0.7+ (basic functionality)
- Basic UNIX tools (grep, find)

### Recommended Requirements  
- Neovim 0.8+ (full nvim-notify support)
- ripgrep (enhanced search performance)
- clangd (C/C++ development)

### Installation Alternatives

If you can't install ripgrep system-wide, consider:
1. Download portable ripgrep binary to `~/.local/bin/`
2. Use the configuration as-is with grep fallbacks
3. Install ripgrep in a user environment (conda, etc.)

All core functionality (LSP, Treesitter, editing) will work without ripgrep.