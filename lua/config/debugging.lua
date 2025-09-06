-- config/debugging.lua
-- Advanced debugging configuration with GDB GEF and Valgrind integration

local M = {}

-- Check if debugging tools are available
M.check_debug_tools = function()
  local tools = {
    gdb = vim.fn.executable("gdb") == 1,
    valgrind = vim.fn.executable("valgrind") == 1,
  }
  
  -- Check for Python debugpy module
  local python_debugpy = false
  if vim.fn.executable("python3") == 1 then
    local handle = io.popen("python3 -c 'import debugpy; print(\"available\")' 2>/dev/null")
    if handle then
      local result = handle:read("*a")
      handle:close()
      python_debugpy = result and result:match("available") ~= nil
    end
  end
  tools.python_debugpy = python_debugpy
  
  -- Check for GEF
  local gef_available = false
  local gef_paths = {
    vim.fn.expand("~/.gef.py"),
    "/usr/share/gef/gef.py",
    "/opt/gef/gef.py",
  }
  
  for _, path in ipairs(gef_paths) do
    if vim.fn.filereadable(path) == 1 then
      gef_available = true
      tools.gef_path = path
      break
    end
  end
  tools.gef = gef_available
  
  return tools
end

-- Enhanced Valgrind wrapper functions
M.run_valgrind = function(tool, extra_args)
  tool = tool or "memcheck"
  extra_args = extra_args or ""
  
  local file_path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  if file_path == "" then
    vim.notify("❌ No executable specified", vim.log.levels.ERROR)
    return
  end
  
  local args = vim.fn.input('Program arguments (optional): ')
  
  local valgrind_configs = {
    memcheck = "--tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose",
    helgrind = "--tool=helgrind --track-origins=yes",
    cachegrind = "--tool=cachegrind",
    callgrind = "--tool=callgrind --collect-jumps=yes --collect-systime=yes",
    massif = "--tool=massif --time-unit=ms --threshold=0.1",
    drd = "--tool=drd --check-stack-var=yes",
  }
  
  local config = valgrind_configs[tool]
  if not config then
    vim.notify("❌ Unknown Valgrind tool: " .. tool, vim.log.levels.ERROR)
    return
  end
  
  local valgrind_cmd = string.format(
    "valgrind %s %s %s %s",
    config, extra_args, file_path, args
  )
  
  vim.notify("🔍 Running Valgrind with " .. tool .. " tool", vim.log.levels.INFO)
  vim.cmd("vsplit | terminal " .. valgrind_cmd)
end

-- GEF command integration
M.gef_commands = function()
  local tools = M.check_debug_tools()
  if not tools.gef then
    vim.notify("❌ GEF not found. Install GEF for enhanced debugging features.", vim.log.levels.WARN)
    return
  end
  
  local gef_scripts = {
    "checksec",           -- Check binary security features
    "vmmap",             -- Display virtual memory mapping
    "heap bins",         -- Display heap bins
    "heap chunks",       -- Display heap chunks
    "got",               -- Display GOT entries
    "plt",               -- Display PLT entries
    "elf-info",          -- Display ELF information
    "ropper",            -- ROP gadgets search
    "pattern create",    -- Create cyclic pattern
    "pattern search",    -- Search for pattern
  }
  
  vim.ui.select(gef_scripts, {
    prompt = "🦊 Select GEF command:",
    format_item = function(item)
      return "  " .. item
    end,
  }, function(choice)
    if choice then
      local additional_args = vim.fn.input('Additional arguments (optional): ')
      local full_cmd = choice .. " " .. additional_args
      
      -- This would be executed in a GDB session with GEF loaded
      vim.notify("🦊 GEF command: " .. full_cmd, vim.log.levels.INFO)
      vim.notify("💡 Run this in a GEF debugging session", vim.log.levels.INFO)
    end
  end)
end

-- Memory analysis tools
M.memory_analysis = function()
  local tools = {
    { name = "Valgrind Memcheck", cmd = "memcheck", desc = "Memory error detection" },
    { name = "Valgrind Helgrind", cmd = "helgrind", desc = "Race condition detection" },
    { name = "Valgrind DRD", cmd = "drd", desc = "Thread error detection" },
    { name = "Valgrind Massif", cmd = "massif", desc = "Heap profiling" },
    { name = "Valgrind Cachegrind", cmd = "cachegrind", desc = "Cache profiling" },
    { name = "Valgrind Callgrind", cmd = "callgrind", desc = "Call graph profiling" },
  }
  
  vim.ui.select(tools, {
    prompt = "🔍 Select memory analysis tool:",
    format_item = function(item)
      return string.format("  %s - %s", item.name, item.desc)
    end,
  }, function(choice)
    if choice then
      M.run_valgrind(choice.cmd)
    end
  end)
end

-- Security analysis helpers
M.security_analysis = function()
  local file_path = vim.fn.input('Path to binary: ', vim.fn.getcwd() .. '/', 'file')
  if file_path == "" then
    vim.notify("❌ No binary specified", vim.log.levels.ERROR)
    return
  end
  
  local security_checks = {
    { name = "File info", cmd = "file " .. file_path },
    { name = "Checksec", cmd = "checksec --file=" .. file_path },
    { name = "Strings", cmd = "strings " .. file_path .. " | head -50" },
    { name = "Readelf headers", cmd = "readelf -h " .. file_path },
    { name = "Readelf sections", cmd = "readelf -S " .. file_path },
    { name = "Objdump disassembly (main)", cmd = "objdump -d " .. file_path .. " | grep -A 20 '<main>:'" },
    { name = "Nm symbols", cmd = "nm " .. file_path },
  }
  
  vim.ui.select(security_checks, {
    prompt = "🔒 Select security analysis:",
    format_item = function(item)
      return "  " .. item.name
    end,
  }, function(choice)
    if choice then
      vim.notify("🔒 Running: " .. choice.cmd, vim.log.levels.INFO)
      vim.cmd("vsplit | terminal " .. choice.cmd)
    end
  end)
end

-- Debug configuration templates
M.debug_templates = function()
  local templates = {
    {
      name = "C/C++ with GDB",
      config = {
        name = "Debug C/C++ (GDB)",
        type = "gdb",
        request = "launch",
        program = "${workspaceFolder}/a.out",
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      }
    },
    {
      name = "C/C++ with GEF",
      config = {
        name = "Debug C/C++ (GEF Enhanced)",
        type = "gef",
        request = "launch",
        program = "${workspaceFolder}/a.out",
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      }
    },
    {
      name = "Python Script",
      config = {
        name = "Debug Python",
        type = "python",
        request = "launch",
        program = "${file}",
        pythonPath = "/usr/bin/python3",
      }
    },
    {
      name = "Node.js Application",
      config = {
        name = "Debug Node.js",
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
      }
    },
  }
  
  vim.ui.select(templates, {
    prompt = "🐛 Select debug template:",
    format_item = function(item)
      return "  " .. item.name
    end,
  }, function(choice)
    if choice then
      local dap = require("dap")
      dap.run(choice.config)
    end
  end)
end

-- Setup debugging status line
M.setup_debug_statusline = function()
  vim.api.nvim_create_autocmd({"User"}, {
    pattern = "DapUIOpen",
    callback = function()
      vim.opt.statusline = vim.opt.statusline:get() .. " [🐛 DEBUG]"
    end,
  })
  
  vim.api.nvim_create_autocmd({"User"}, {
    pattern = "DapUIClose", 
    callback = function()
      local current_statusline = vim.opt.statusline:get()
      vim.opt.statusline = current_statusline:gsub(" %[🐛 DEBUG%]", "")
    end,
  })
end

-- Initialize debugging environment
M.setup = function()
  local tools = M.check_debug_tools()
  
  -- Report available tools
  local available = {}
  local missing = {}
  
  for tool, available_status in pairs(tools) do
    if tool ~= "gef_path" then
      if available_status then
        table.insert(available, tool)
      else
        table.insert(missing, tool)
      end
    end
  end
  
  if #available > 0 then
    vim.notify("🔧 Debug tools available: " .. table.concat(available, ", "), vim.log.levels.DEBUG)
  end
  
  if #missing > 0 then
    vim.notify("⚠️ Missing debug tools: " .. table.concat(missing, ", "), vim.log.levels.WARN)
    vim.notify("💡 Install missing tools for full debugging capabilities", vim.log.levels.DEBUG)
  end
  
  -- Setup debug keymaps with which-key integration
  local wk_ok, wk = pcall(require, "which-key")
  if wk_ok then
    wk.add({
      { "<leader>d", group = "debug", icon = "🐛" },
      { "<leader>dv", group = "valgrind", icon = "🔍" },
      { "<leader>dg", group = "gef", icon = "🦊" },
      { "<leader>da", group = "analysis", icon = "🔬" },
    })
  end
  
  M.setup_debug_statusline()
  
  vim.notify("🚀 Advanced debugging environment initialized", vim.log.levels.DEBUG)
end

return M