-- plugins/dev/refactoring.lua
-- Code refactoring with refactoring.nvim (ThePrimeagen/refactoring.nvim)

return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "lua", "python", "javascript", "typescript", "go", "java", "c", "cpp" },
    config = function()
      require("refactoring").setup({
        prompt_func_return_type = {
          go = false,
          java = false,
          cpp = false,
          c = false,
          python = false,
        },
        prompt_func_param_type = {
          go = false,
          java = false,
          cpp = false,
          c = false,
          python = false,
        },
        printf_statements = {},
        print_var_statements = {},
        show_success_message = true,
      })

      -- Load Telescope extension if available
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("refactoring")
      end

      -- Normal/visual mode: pick refactoring via Telescope
      vim.keymap.set({ "n", "v" }, "<leader>rr", function()
        require("telescope").extensions.refactoring.refactors()
      end, { desc = "Refactor (pick)" })

      -- Extract function from visual selection
      vim.keymap.set("v", "<leader>re", function()
        require("refactoring").refactor("Extract Function")
      end, { desc = "Extract Function" })

      -- Extract function to file
      vim.keymap.set("v", "<leader>rE", function()
        require("refactoring").refactor("Extract Function To File")
      end, { desc = "Extract Function To File" })

      -- Extract variable from visual selection
      vim.keymap.set("v", "<leader>rv", function()
        require("refactoring").refactor("Extract Variable")
      end, { desc = "Extract Variable" })

      -- Inline variable
      vim.keymap.set({ "n", "v" }, "<leader>ri", function()
        require("refactoring").refactor("Inline Variable")
      end, { desc = "Inline Variable" })

      -- Extract block (normal mode)
      vim.keymap.set("n", "<leader>rb", function()
        require("refactoring").refactor("Extract Block")
      end, { desc = "Extract Block" })

      -- Extract block to file (normal mode)
      vim.keymap.set("n", "<leader>rB", function()
        require("refactoring").refactor("Extract Block To File")
      end, { desc = "Extract Block To File" })

      -- Debug print helpers
      vim.keymap.set("n", "<leader>rp", function()
        require("refactoring").debug.printf({ below = false })
      end, { desc = "Debug: printf above" })

      vim.keymap.set({ "n", "v" }, "<leader>rP", function()
        require("refactoring").debug.print_var()
      end, { desc = "Debug: print variable" })

      vim.keymap.set("n", "<leader>rc", function()
        require("refactoring").debug.cleanup({})
      end, { desc = "Debug: cleanup prints" })
    end,
  },
}
