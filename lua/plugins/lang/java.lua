-- plugins/lang/java.lua
-- Java development with nvim-jdtls

return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    config = function()
      -- nvim-jdtls is configured via ftplugin/java.lua
      -- This ensures proper per-project workspace management
    end,
  },
}
