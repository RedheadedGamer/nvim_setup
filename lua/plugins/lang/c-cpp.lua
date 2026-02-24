-- plugins/lang/c-cpp.lua
-- C/C++ development tools

return {
  -- CMake integration
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "cmake" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("cmake-tools").setup({
        cmake_command = "cmake",
        cmake_build_directory = "build",
        cmake_build_directory_prefix = "cmake_build_", 
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_options = {},
        cmake_console_size = 10,
        cmake_show_console = "always",
        cmake_dap_configuration = {
          name = "cpp",
          type = "codelldb",
          request = "launch",
        },
      })
      
      -- CMake keybindings
      local keymap = vim.keymap
      keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
      keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
      keymap.set("n", "<leader>cr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })
      keymap.set("n", "<leader>cd", "<cmd>CMakeDebug<cr>", { desc = "CMake Debug" })
      keymap.set("n", "<leader>cc", "<cmd>CMakeClean<cr>", { desc = "CMake Clean" })
      keymap.set("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake Select Target" })
      keymap.set("n", "<leader>cT", "<cmd>CMakeSelectBuildType<cr>", { desc = "CMake Select Build Type" })
    end,
  },

  -- Enhanced clangd features
  -- NOTE: jackguo380/vim-lsp-cxx-highlight removed - clangd semantic token highlighting
  --       is built into Neovim's LSP client and is superior.
  -- NOTE: ericcurtin/CurtineIncSw.vim removed - ClangdSwitchSourceHeader (<leader>ch) covers this.
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("clangd_extensions").setup({
        -- inlay_hints removed: use native Neovim inlay hints via vim.lsp.inlay_hint
        -- (toggle with <leader>ti from LSP keymaps)
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
          kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
          },
        },
      })
      
      -- Clangd extension keybindings
      vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch Header/Source" })
      vim.keymap.set("n", "<leader>cA", "<cmd>ClangdAST<cr>", { desc = "Show AST" })
      vim.keymap.set("n", "<leader>cS", "<cmd>ClangdSymbolInfo<cr>", { desc = "Symbol Info" })
      vim.keymap.set("n", "<leader>cM", "<cmd>ClangdMemoryUsage<cr>", { desc = "Memory Usage" })
    end,
  },
}
