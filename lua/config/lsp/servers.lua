-- config/lsp/servers.lua
-- LSP server configurations

local M = {}

-- Server configurations
M.servers = {
  clangd = {
    -- Keep the command concise in :LspInfo; put project-specific flags in .clangd.
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    init_options = {
      clangdFileStatus = true,
      fallbackFlags = { "-fopenmp" },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        -- lazydev.nvim injects the Neovim runtime library automatically;
        -- the old workspace.library approach added thousands of files and
        -- was extremely slow. Keep only the minimal diagnostics override.
        diagnostics = { globals = { "vim" } },
        completion = { callSnippet = "Replace" },
        telemetry = { enable = false },
      },
    },
  },
  pyright = {},
  ts_ls = {},
  html = {},
  cssls = {},
  jsonls = {},
  cmake = {},
  bashls = {
    filetypes = { "sh", "bash" },
  },
  marksman = {},   -- Markdown LSP (link checking, headings, etc.)
}

return M
