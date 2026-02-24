-- config/lsp/keymaps.lua
-- LSP keybindings configuration

local M = {}

function M.on_attach(client, bufnr)
  local keymap = vim.keymap
  local opts = { buffer = bufnr, silent = true }
  
  -- LSP keymaps
  keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
  keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
  keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
  keymap.set("n", "<leader>lf", vim.lsp.buf.format, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
  keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
  keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  keymap.set("n", "<leader>ld", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
  keymap.set("n", "<leader>ll", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostic loclist" }))
  keymap.set("n", "<leader>lq", vim.diagnostic.setqflist, vim.tbl_extend("force", opts, { desc = "Diagnostic quickfix" }))
  
  -- Enhanced diagnostic navigation with severity filtering
  keymap.set("n", "[e", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, vim.tbl_extend("force", opts, { desc = "Previous error" }))
  
  keymap.set("n", "]e", function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, vim.tbl_extend("force", opts, { desc = "Next error" }))
  
  keymap.set("n", "[w", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
  end, vim.tbl_extend("force", opts, { desc = "Previous warning" }))
  
  keymap.set("n", "]w", function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
  end, vim.tbl_extend("force", opts, { desc = "Next warning" }))
  
  -- Toggle auto-hover diagnostics
  keymap.set("n", "<leader>lh", function()
    local augroup = vim.api.nvim_get_autocmds({ group = "DiagnosticFloat" })
    if #augroup > 0 then
      vim.api.nvim_del_augroup_by_name("DiagnosticFloat")
      vim.notify("Auto-hover diagnostics disabled", vim.log.levels.INFO)
    else
      vim.api.nvim_create_autocmd("CursorHold", {
        group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true }),
        callback = function()
          local opts_float = {
            focusable = false,
            close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
            border = "rounded",
            source = "always",
            prefix = "",
            scope = "cursor",
          }
          local line_diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
          if #line_diagnostics > 0 then
            vim.diagnostic.open_float(nil, opts_float)
          end
        end
      })
      vim.notify("Auto-hover diagnostics enabled", vim.log.levels.INFO)
    end
  end, vim.tbl_extend("force", opts, { desc = "Toggle auto-hover diagnostics" }))
  
  keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))
  keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", vim.tbl_extend("force", opts, { desc = "LSP info" }))
  
  -- Toggle native inlay hints (Neovim 0.10+)
  if vim.lsp.inlay_hint then
    keymap.set("n", "<leader>ti", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
  end
end

return M
