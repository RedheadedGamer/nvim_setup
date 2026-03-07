-- config/lsp/diagnostics.lua
-- LSP diagnostics configuration

local M = {}

function M.setup()
  -- Configure LSP handlers to prevent duplicates
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    max_width = 120,
    max_height = 30,
    focus_id = "hover_handler",
  })
  
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    focus_id = "signature_help_handler",
  })

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

  -- Track cursor position to avoid redundant diagnostic queries
  local last_diagnostic_line = -1
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

  vim.opt.updatetime = 300
end

return M
