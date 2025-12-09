-- plugins/editor/mini-text.lua
-- Mini.nvim text manipulation plugins

return {
  -- Auto-close brackets and quotes
  {
    "echasnovski/mini.pairs",
    version = "*",
    config = function()
      require("mini.pairs").setup({
        modes = { insert = true, command = false, terminal = false },
        mappings = {
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
          [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
          ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
          ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
          ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
          ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
        }
      })
    end,
  },

  -- Surround text with brackets, quotes, tags
  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "sa",
          delete = "sd",
          find = "sf",
          find_left = "sF",
          highlight = "sh",
          replace = "sr",
          update_n_lines = "sn",
        },
      })
    end,
  },

  -- Move lines and selections with Alt+hjkl
  {
    "echasnovski/mini.move",
    version = "*",
    config = function()
      require("mini.move").setup({
        mappings = {
          left = "<M-h>",
          right = "<M-l>",
          down = "<M-j>",
          up = "<M-k>",
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },
      })
    end,
  },

  -- Better text objects (around/inside)
  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup({
        n_lines = 500,
      })
    end,
  },

  -- Jump to location with search
  {
    "echasnovski/mini.jump",
    version = "*",
    config = function()
      require("mini.jump").setup()
    end,
  },

  -- Split/join code blocks
  {
    "echasnovski/mini.splitjoin",
    version = "*",
    config = function()
      require("mini.splitjoin").setup({
        mappings = {
          toggle = "gS",
        },
      })
    end,
  },

  -- Show and remove trailing whitespace
  {
    "echasnovski/mini.trailspace",
    version = "*",
    config = function()
      require("mini.trailspace").setup()
      
      vim.keymap.set("n", "<leader>tw", function()
        require("mini.trailspace").trim()
        vim.notify("Trailing whitespace removed", vim.log.levels.INFO)
      end, { desc = "Trim trailing whitespace" })
      
      vim.keymap.set("n", "<leader>tl", function()
        require("mini.trailspace").trim_last_lines()
        vim.notify("Trailing empty lines removed", vim.log.levels.INFO)
      end, { desc = "Trim trailing empty lines" })
    end,
  },

  -- Advanced text operators
  {
    "echasnovski/mini.operators",
    version = "*",
    config = function()
      require("mini.operators").setup({
        evaluate    = { prefix = "g=", func = nil },
        exchange    = { prefix = "gx", func = nil },
        multiply    = { prefix = "gm", func = nil },
        replace     = { prefix = "gr", func = nil },
        sort        = { prefix = "gs", func = nil },
      })
    end,
  },

  -- Text alignment
  {
    "echasnovski/mini.align",
    version = "*",
    config = function()
      require("mini.align").setup({
        mappings = {
          start = "ga",
          start_with_preview = "gA",
        },
      })
    end,
  },
}
