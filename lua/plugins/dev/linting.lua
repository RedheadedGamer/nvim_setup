-- plugins/dev/linting.lua
-- Code linting with nvim-lint

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      
      -- Cache linter availability checks
      local linter_cache = {}
      local function is_linter_available(linter)
        if linter_cache[linter] ~= nil then
          return linter_cache[linter]
        end
        
        if vim.fn.executable(linter) == 1 then
          linter_cache[linter] = true
          return true
        end
        
        local mason_path = vim.fn.stdpath("data") .. "/mason/bin/" .. linter
        if vim.fn.executable(mason_path) == 1 then
          linter_cache[linter] = true
          return true
        end
        
        linter_cache[linter] = false
        return false
      end
      
      -- Build linters table
      local linters_by_ft = {}
      
      if is_linter_available("cppcheck") then
        linters_by_ft.c = { "cppcheck" }
        linters_by_ft.cpp = { "cppcheck" }
      end
      
      if is_linter_available("cpplint") then
        if linters_by_ft.c then
          table.insert(linters_by_ft.c, "cpplint")
        else
          linters_by_ft.c = { "cpplint" }
        end
        
        if linters_by_ft.cpp then
          table.insert(linters_by_ft.cpp, "cpplint")
        else
          linters_by_ft.cpp = { "cpplint" }
        end
      end
      
      if is_linter_available("pylint") then
        linters_by_ft.python = { "pylint" }
      end
      
      if is_linter_available("eslint_d") then
        linters_by_ft.javascript = { "eslint_d" }
        linters_by_ft.javascriptreact = { "eslint_d" }
        linters_by_ft.typescript = { "eslint_d" }
        linters_by_ft.typescriptreact = { "eslint_d" }
      elseif is_linter_available("eslint") then
        linters_by_ft.javascript = { "eslint" }
        linters_by_ft.javascriptreact = { "eslint" }
        linters_by_ft.typescript = { "eslint" }
        linters_by_ft.typescriptreact = { "eslint" }
      end
      
      if is_linter_available("shellcheck") then
        linters_by_ft.sh = { "shellcheck" }
        linters_by_ft.bash = { "shellcheck" }
      end
      
      if is_linter_available("markdownlint") then
        linters_by_ft.markdown = { "markdownlint" }
      end
      
      if is_linter_available("yamllint") then
        linters_by_ft.yaml = { "yamllint" }
        linters_by_ft.yml = { "yamllint" }
      end

      lint.linters_by_ft = linters_by_ft
      
      -- Auto-lint with debouncing
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          local ft = vim.bo.filetype
          if linters_by_ft[ft] then
            lint.try_lint()
          end
        end,
      })
      
      -- Manual lint command
      vim.keymap.set("n", "<leader>lL", function()
        lint.try_lint()
      end, { desc = "Lint current file" })
      
      -- Show linter info
      vim.keymap.set("n", "<leader>lI", function()
        local ft = vim.bo.filetype
        local linters = linters_by_ft[ft] or {}
        if #linters > 0 then
          vim.notify("Available linters for " .. ft .. ": " .. table.concat(linters, ", "), vim.log.levels.INFO)
        else
          vim.notify("No linters configured for " .. ft, vim.log.levels.WARN)
        end
      end, { desc = "Show linter info" })
      
      -- Show helpful installation messages
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp" },
        callback = function()
          if not is_linter_available("cppcheck") and not is_linter_available("cpplint") then
            vim.notify(
              "No C/C++ linters found. Mason can install cpplint, or install cppcheck manually:\n" ..
              "• Arch Linux: sudo pacman -S cppcheck\n" ..
              "• Ubuntu: sudo apt install cppcheck\n" ..
              "• macOS: brew install cppcheck",
              vim.log.levels.INFO,
              { title = "C/C++ Linting" }
            )
          end
        end,
        once = true,
      })
    end,
  },
}
