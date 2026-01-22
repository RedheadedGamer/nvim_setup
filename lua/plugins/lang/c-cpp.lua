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

  -- Enhanced C/C++ highlighting
  {
    "jackguo380/vim-lsp-cxx-highlight",
    ft = { "c", "cpp" },
    config = function()
      vim.cmd([[
        hi default LspCxxHlGroupEnumConstant ctermfg=155 guifg=#b5bd68
        hi default LspCxxHlGroupNamespace ctermfg=170 guifg=#c678dd
        hi default LspCxxHlGroupMemberVariable ctermfg=204 guifg=#e06c75
      ]])
    end,
  },

  -- Header/Source file switching
  {
    "ericcurtin/CurtineIncSw.vim",
    ft = { "c", "cpp" },
    config = function()
      vim.keymap.set("n", "<leader>ch", "<cmd>call CurtineIncSw()<cr>", { desc = "Switch Header/Source" })
    end,
  },

  -- Enhanced clangd features
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("clangd_extensions").setup({
        extensions = {
          autoSetHints = true,
          inlay_hints = {
            inline = true, -- Neovim 0.10+ is now standard
            only_current_line = false,
            only_current_line_autocmd = "CursorHold",
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
            priority = 100,
          },
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
        },
      })
      
      -- Clangd extension keybindings
      vim.keymap.set("n", "<leader>cI", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch Source/Header" })
      vim.keymap.set("n", "<leader>cH", "<cmd>ClangdSetInlayHints<cr>", { desc = "Toggle Inlay Hints" })
      vim.keymap.set("n", "<leader>cA", "<cmd>ClangdAST<cr>", { desc = "Show AST" })
      vim.keymap.set("n", "<leader>cS", "<cmd>ClangdSymbolInfo<cr>", { desc = "Symbol Info" })
      vim.keymap.set("n", "<leader>cM", "<cmd>ClangdMemoryUsage<cr>", { desc = "Memory Usage" })
    end,
  },
}
