-- plugins/dev/formatting.lua
-- Code formatting with conform.nvim

return {
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>fm", desc = "Format buffer manually" },
      { "<leader>fi", desc = "Formatter info" },
      { "<leader>tf", desc = "Auto-formatting status (disabled)" },
    },
    config = function()
      -- Cache formatter availability checks
      local formatter_cache = {}
      local function is_formatter_available(formatter)
        if formatter_cache[formatter] ~= nil then
          return formatter_cache[formatter]
        end
        
        if vim.fn.executable(formatter) == 1 then
          formatter_cache[formatter] = true
          return true
        end
        
        local mason_path = vim.fn.stdpath("data") .. "/mason/bin/" .. formatter
        if vim.fn.executable(mason_path) == 1 then
          formatter_cache[formatter] = true
          return true
        end
        
        formatter_cache[formatter] = false
        return false
      end

      -- Build formatters table
      local formatters_by_ft = {}
      
      if is_formatter_available("stylua") then
        formatters_by_ft.lua = { "stylua" }
      end
      
      if is_formatter_available("black") then
        formatters_by_ft.python = { "black" }
        if is_formatter_available("isort") then
          formatters_by_ft.python = { "isort", "black" }
        end
      end
      
      if is_formatter_available("prettier") then
        formatters_by_ft.javascript = { "prettier" }
        formatters_by_ft.javascriptreact = { "prettier" }
        formatters_by_ft.typescript = { "prettier" }
        formatters_by_ft.typescriptreact = { "prettier" }
        formatters_by_ft.html = { "prettier" }
        formatters_by_ft.css = { "prettier" }
        formatters_by_ft.scss = { "prettier" }
        formatters_by_ft.json = { "prettier" }
        formatters_by_ft.jsonc = { "prettier" }
        formatters_by_ft.yaml = { "prettier" }
        formatters_by_ft.yml = { "prettier" }
        formatters_by_ft.markdown = { "prettier" }
        formatters_by_ft.graphql = { "prettier" }
        formatters_by_ft.vue = { "prettier" }
        formatters_by_ft.svelte = { "prettier" }
      end
      
      if is_formatter_available("clang-format") then
        formatters_by_ft.c = { "clang-format" }
        formatters_by_ft.cpp = { "clang-format" }
        formatters_by_ft.objc = { "clang-format" }
        formatters_by_ft.objcpp = { "clang-format" }
      end
      
      if is_formatter_available("google-java-format") then
        formatters_by_ft.java = { "google-java-format" }
      end
      
      if is_formatter_available("shfmt") then
        formatters_by_ft.sh = { "shfmt" }
        formatters_by_ft.bash = { "shfmt" }
      end
      
      if is_formatter_available("gofmt") then
        formatters_by_ft.go = { "gofmt" }
      end
      
      if is_formatter_available("asmfmt") then
        formatters_by_ft.asm = { "asmfmt" }
        formatters_by_ft.nasm = { "asmfmt" }
        formatters_by_ft.s = { "asmfmt" }
      end

      require("conform").setup({
        formatters_by_ft = formatters_by_ft,
        formatters = {
          stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          },
          black = {
            prepend_args = { "--fast" },
          },
          prettier = {
            prepend_args = { "--tab-width", "2" },
          },
        },
      })
      
      -- Format keymaps
      vim.keymap.set("n", "<leader>fm", function()
        local ok, err = pcall(function()
          require("conform").format({ lsp_fallback = true })
        end)
        if ok then
          vim.notify("Buffer formatted successfully", vim.log.levels.INFO)
        else
          vim.notify("Format failed: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, { desc = "Format buffer manually" })
      
      vim.keymap.set("n", "<leader>tf", function()
        vim.notify("Auto-formatting is permanently disabled. Use <leader>fm for manual formatting.", vim.log.levels.INFO)
      end, { desc = "Auto-formatting status (disabled)" })
      
      vim.keymap.set("n", "<leader>fi", "<cmd>ConformInfo<cr>", { desc = "Formatter info" })
    end,
  },
}
