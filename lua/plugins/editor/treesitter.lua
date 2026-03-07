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

  -- Comment functionality
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
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
            vim.api.nvim_set_hl(0, "RainbowDelimiterRed",    { fg = "#E06C75", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterBlue",   { fg = "#61AFEF", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterGreen",  { fg = "#98C379", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD", bold = true })
            vim.api.nvim_set_hl(0, "RainbowDelimiterCyan",   { fg = "#56B6C2", bold = true })
            highlights_set = true
          end
        end,
      })
    end,
  },

  -- Treesitter context: shows the current function/class/block at the top of the screen
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,        -- show up to 3 lines of context
        min_window_height = 20,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
      })

      vim.keymap.set("n", "[C", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { desc = "Jump to treesitter context" })
    end,
  },

  -- Treesitter textobjects: select/move/swap functions, classes, parameters etc.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Select outer function" },
              ["if"] = { query = "@function.inner", desc = "Select inner function" },
              ["ac"] = { query = "@class.outer",    desc = "Select outer class" },
              ["ic"] = { query = "@class.inner",    desc = "Select inner class" },
              ["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },
              ["ai"] = { query = "@conditional.outer", desc = "Select outer conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner conditional" },
              ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = { query = "@function.outer", desc = "Next function start" },
              ["]c"] = { query = "@class.outer",    desc = "Next class start" },
            },
            goto_next_end = {
              ["]F"] = { query = "@function.outer", desc = "Next function end" },
              ["]C"] = { query = "@class.outer",    desc = "Next class end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Previous function start" },
              ["[c"] = { query = "@class.outer",    desc = "Previous class start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@function.outer", desc = "Previous function end" },
              ["[C"] = { query = "@class.outer",    desc = "Previous class end" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sp"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
            },
            swap_previous = {
              ["<leader>sP"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
            },
          },
        },
      })
    end,
  },
}
