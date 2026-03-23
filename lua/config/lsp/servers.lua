-- config/lsp/servers.lua
-- LSP server configurations

local M = {}

-- Server configurations
M.servers = {
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
	  "--extra-arg=-fopenmp",
      "--query-driver=" .. table.concat({
        "/usr/bin/gcc",
        "/usr/bin/g++",
        "/usr/bin/clang",
        "/usr/bin/clang++",
        "/usr/local/bin/gcc*",
        "/usr/local/bin/g++*",
        "/usr/local/bin/clang*",
        "C:/msys64/mingw64/bin/gcc.exe",
        "C:/Users/*/scoop/apps/gcc/*/bin/gcc.exe",
        "C:/Users/*/scoop/apps/gcc/*/bin/g++.exe",
        "C:/msys64/mingw64/bin/g++.exe",
        "C:/Program Files/LLVM/bin/clang.exe",
        "C:/Program Files/LLVM/bin/clang++.exe",
      }, ","),
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    init_options = {
      clangdFileStatus = true,
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
  bashls = {
    filetypes = { "sh", "bash" },
  },
  marksman = {},   -- Markdown LSP (link checking, headings, etc.)
}

return M
