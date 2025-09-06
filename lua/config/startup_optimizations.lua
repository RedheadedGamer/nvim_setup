-- config/startup_optimizations.lua
-- Performance optimizations and startup enhancements

local M = {}

-- Performance settings
function M.setup_performance()
  -- Improve startup time
  vim.loader.enable() -- Enable faster lua module loading (Neovim 0.9+)
  
  -- Memory management
  vim.opt.maxmempattern = 5000 -- Increase memory for pattern matching
  
  -- File handling optimizations
  vim.opt.updatetime = 250 -- Faster completion and diagnostics
  vim.opt.timeoutlen = 300 -- Faster which-key popup
  vim.opt.ttimeoutlen = 10 -- Faster key sequence timeout
  
  -- Performance for large files
  vim.opt.synmaxcol = 2048 -- Don't syntax highlight extremely long lines
  vim.opt.lazyredraw = false -- Don't use lazy redraw (can cause issues with modern terminals)
  
  -- Better search performance
  vim.opt.regexpengine = 0 -- Automatically choose the best regexp engine
end

-- Enhanced error handling
function M.setup_error_handling()
  -- Global error handler
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- Notification system is already configured by nvim-notify in plugins/init.lua
      -- This autocmd ensures vim.notify is available even if nvim-notify fails to load
      if not vim.notify or vim.notify == vim.notify_once then
        vim.notify = function(msg, level)
          local levels = { "ERROR", "WARN", "INFO", "DEBUG" }
          local level_name = levels[level] or "INFO"
          print(string.format("[%s] %s", level_name, tostring(msg)))
        end
      end
    end,
  })

  -- Better plugin loading error handling
  local original_require = require
  require = function(module)
    local ok, result = pcall(original_require, module)
    if not ok then
      vim.notify("Failed to load module: " .. module .. "\nError: " .. result, vim.log.levels.ERROR)
      return {}
    end
    return result
  end
end

-- Startup validation
function M.validate_environment()
  local issues = {}
  
  -- Check Neovim version
  if vim.fn.has('nvim-0.9') == 0 then
    table.insert(issues, "Neovim 0.9+ required for optimal performance")
  end
  
  -- Check important external tools
  local tools = {
    { cmd = "git", desc = "Git version control" },
    { cmd = "rg", desc = "ripgrep for fast searching", optional = true },
    { cmd = "fd", desc = "fd for fast file finding", optional = true },
    { cmd = "node", desc = "Node.js for some LSP servers", optional = true },
  }
  
  for _, tool in ipairs(tools) do
    if vim.fn.executable(tool.cmd) == 0 then
      local msg = tool.desc .. " not found in PATH"
      if tool.optional then
        msg = msg .. " (optional but recommended)"
      end
      table.insert(issues, msg)
    end
  end
  
  -- Report issues if any
  if #issues > 0 then
    vim.defer_fn(function()
      vim.notify("🔧 Environment Check:\n" .. table.concat(issues, "\n"), vim.log.levels.WARN)
    end, 1000)
  end
end

-- Better user experience setup
function M.setup_ux_improvements()
  -- Auto-save when losing focus
  vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
    callback = function()
      if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
        vim.cmd("silent! update")
      end
    end,
  })

  -- Highlight yanked text
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
  })

  -- Remember cursor position
  vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  -- Better paste experience
  vim.keymap.set("v", "p", '"_dP', { desc = "Paste without replacing register" })
  
  -- Quick escape from terminal mode
  vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
  
  -- Better window navigation
  vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
  vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
  vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
  vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
  
  -- Improved scrolling
  vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
  vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
  vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
  vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })
end

-- Initialize all optimizations
function M.init()
  M.setup_performance()
  M.setup_error_handling()
  M.validate_environment()
  M.setup_ux_improvements()
end

return M