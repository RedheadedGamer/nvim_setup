-- plugins/editor/mini-ui.lua
-- Mini.nvim UI enhancement plugins

return {
  -- Statusline
  {
    "echasnovski/mini.statusline",
    version = "*",
    config = function()
      require("mini.statusline").setup({
        use_icons = true,
        set_vim_settings = false,
      })
    end,
  },

  -- Tabline
  {
    "echasnovski/mini.tabline",
    version = "*",
    config = function()
      require("mini.tabline").setup({
        show_icons = true,
        set_vim_settings = false,
        tabpage_section = "left",
      })
    end,
  },

  -- Highlight word under cursor
  {
    "echasnovski/mini.cursorword",
    version = "*",
    config = function()
      require("mini.cursorword").setup({
        delay = 100,
      })
    end,
  },

  -- Highlight patterns (TODO, FIXME, hex colors)
  {
    "echasnovski/mini.hipatterns",
    version = "*",
    config = function()
      local hipatterns = require("mini.hipatterns")
      require("mini.hipatterns").setup({
        highlighters = {
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
          todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
          note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },

  -- Icons
  {
    "echasnovski/mini.icons",
    version = "*",
    config = function()
      require("mini.icons").setup({
        file = {},
        directory = {},
        extension = {},
        filetype = {},
        lsp = {},
        os = {},
      })
    end,
  },

  -- Minimap
  {
    "echasnovski/mini.map",
    version = "*",
    config = function()
      require("mini.map").setup({
        integrations = {
          require("mini.map").gen_integration.builtin_search(),
          require("mini.map").gen_integration.diff(),
          require("mini.map").gen_integration.diagnostic(),
        },
        symbols = {
          encode = require("mini.map").gen_encode_symbols.dot("4x2"),
        },
        window = {
          side = "right",
          width = 15,
          winblend = 25,
        },
      })
      
      vim.keymap.set("n", "<leader>mm", function()
        require("mini.map").toggle()
      end, { desc = "Toggle minimap" })
      
      vim.keymap.set("n", "<leader>mr", function()
        require("mini.map").refresh()
      end, { desc = "Refresh minimap" })
      
      vim.keymap.set("n", "<leader>mf", function()
        require("mini.map").toggle_focus()
      end, { desc = "Focus minimap" })
    end,
  },

  -- File explorer
  {
    "echasnovski/mini.files",
    version = "*",
    config = function()
      require("mini.files").setup({
        windows = {
          preview = true,
          width_focus = 30,
          width_preview = 30,
        },
        options = {
          permanent_delete = false,
        },
      })
      
      vim.keymap.set("n", "<leader>e", function()
        require("mini.files").open()
      end, { desc = "Open File Explorer" })
    end,
  },

  -- 2D jump
  {
    "echasnovski/mini.jump2d",
    version = "*",
    config = function()
      require("mini.jump2d").setup({
        mappings = {
          start_jumping = "<CR>",
        },
        view = {
          dim = true,
          n_steps_ahead = 0,
        },
      })
    end,
  },

  -- Miscellaneous utilities
  {
    "echasnovski/mini.misc",
    version = "*",
    config = function()
      require("mini.misc").setup()
      
      vim.keymap.set("n", "<leader>mz", function()
        require("mini.misc").zoom()
      end, { desc = "Zoom current window (mini.misc)" })
    end,
  },
}
