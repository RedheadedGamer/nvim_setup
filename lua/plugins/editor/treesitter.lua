-- plugins/editor/treesitter.lua
-- Treesitter configuration for syntax highlighting

return {
  -- Essential dependencies
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },

  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- ERROR HANDLING: Protect treesitter loading
      local ok, treesitter = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.notify("Failed to load treesitter: " .. tostring(treesitter), vim.log.levels.ERROR)
        return
      end
      treesitter.setup({
        ensure_installed = {
          "lua", "python", "javascript", "typescript", "html", "css", 
          "json", "yaml", "markdown", "bash", "vim", "vimdoc", "c", "java", "asm"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- Comment functionality (mini.comment - integrates with mini ecosystem)
  {
    "echasnovski/mini.comment",
    version = "*",
    config = function()
      require("mini.comment").setup({
        options = {
          -- Ignore blank lines when (un)commenting
          ignore_blank_line = true,
        },
        mappings = {
          comment = "gc",
          comment_line = "gcc",
          comment_visual = "gc",
          textobject = "gc",
        },
      })
    end,
  },

  -- Rainbow brackets for better bracket visibility
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow", 
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        blacklist = {},
      }
      
      local highlights_set = false
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("RainbowDelimitersHighlight", { clear = true }),
        callback = function()
          if not highlights_set then
            vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2", bold = true })
            highlights_set = true
          end
        end,
      })
    end,
  },
}
