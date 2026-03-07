-- plugins/lang/lua.lua
-- Neovim Lua development tooling

return {
  -- lazydev.nvim: proper Neovim Lua API type-checking and completion.
  -- Replaces the old `workspace.library = vim.api.nvim_get_runtime_file("", true)`
  -- approach in lua_ls config, which was extremely slow (adds thousands of files).
  -- lazydev uses targeted library injection only for Neovim API symbols.
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit type annotations when `vim.uv` is referenced
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  -- luvit-meta: Type annotations for vim.uv (libuv bindings)
  { "Bilal2453/luvit-meta", lazy = true },
}
