-- config/lsp/diagnostics.lua
-- LSP diagnostics configuration

local M = {}

-- State for tracking auto-hover diagnostic popup
local auto_hover_active = true
local last_diagnostic_line = -1

-- Create the performance-optimized auto-hover autocommand
local function create_auto_hover_autocmd()
  vim.api.nvim_create_autocmd("CursorHold", {
    group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true }),
    callback = function()
      local current_line = vim.fn.line(".")
      
      if current_line == last_diagnostic_line then
        return
      end
      last_diagnostic_line = current_line
      
      local opts = {
        focusable = false,
        close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
        border = "rounded",
        source = "always",
        prefix = "",
        scope = "cursor",
      }
      
      local line_diagnostics = vim.diagnostic.get(0, { lnum = current_line - 1 })
      if #line_diagnostics > 0 then
        vim.diagnostic.open_float(nil, opts)
      end
    end
  })
end

-- Public API to toggle auto-hover popups
function M.toggle_auto_hover()
  if auto_hover_active then
    pcall(vim.api.nvim_del_augroup_by_name, "DiagnosticFloat")
    auto_hover_active = false
    last_diagnostic_line = -1
    vim.notify("Auto-hover diagnostics disabled", vim.log.levels.INFO)
  else
    create_auto_hover_autocmd()
    auto_hover_active = true
    vim.notify("Auto-hover diagnostics enabled", vim.log.levels.INFO)
  end
end

function M.setup()
  -- Configure LSP handlers for clean, bordered floats
  vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    config = config or {}
    config.border = "rounded"
    config.max_width = 120
    config.max_height = 30
    config.focus_id = "hover_handler"
    return vim.lsp.handlers.hover(err, result, ctx, config)
  end
  
  vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
    config = config or {}
    config.border = "rounded"
    config.focus_id = "signature_help_handler"
    return vim.lsp.handlers.signature_help(err, result, ctx, config)
  end

  -- Enhanced diagnostic configuration
  vim.diagnostic.config({
    virtual_text = {
      source = "always",
      prefix = "●",
      spacing = 4,
      severity = {
        min = vim.diagnostic.severity.ERROR,
      },
    },
    signs = {
      severity = {
        min = vim.diagnostic.severity.ERROR,
      },
      text = {
        [vim.diagnostic.severity.ERROR] = "✘",
        [vim.diagnostic.severity.WARN]  = "▲",
        [vim.diagnostic.severity.HINT]  = "⚑",
        [vim.diagnostic.severity.INFO]  = "●",
      },
    },
    underline = {
      severity = {
        min = vim.diagnostic.severity.ERROR,
      },
    },
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      focusable = false,
      focus_id = "diagnostic_float",
      style = "minimal",
      close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
    },
  })

  -- Initialize auto-hover on startup
  create_auto_hover_autocmd()
  
  -- Modern update time for snappy auto-command response
  vim.opt.updatetime = 300
end

return M
