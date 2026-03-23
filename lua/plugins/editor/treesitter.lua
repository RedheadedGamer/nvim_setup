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
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
	  require("nvim-treesitter").setup({
		ensure_installed = {
		  "lua", "python", "javascript", "typescript", "html", "css",
		  "json", "yaml", "markdown", "bash", "vim", "vimdoc", "c", "java", "asm"
		},
		sync_install = false,
		auto_install = true,
		highlight = { enable = true, additional_vim_regex_highlighting = false },
		indent = { enable = true },
		textobjects = {
		  select = {
			enable = true,
			lookahead = true,
			keymaps = {
			  ["af"] = "@function.outer",
			  ["if"] = "@function.inner",
			  ["ac"] = "@class.outer",
			  ["ic"] = "@class.inner",
			  ["aa"] = "@parameter.outer",
			  ["ia"] = "@parameter.inner",
			},
		  },
		  move = {
			enable = true,
			set_jumps = true,
			goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
			goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
			goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
			goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
		  },
		  swap = {
			enable = true,
			swap_next     = { ["<leader>sp"] = "@parameter.inner" },
			swap_previous = { ["<leader>sP"] = "@parameter.inner" },
		  },
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
}
