-- plugins/editor/mini-navigation.lua
-- Mini.nvim navigation and utility plugins

return {
  -- Advanced navigation with brackets
  {
    "echasnovski/mini.bracketed",
    version = "*",
    config = function()
      require("mini.bracketed").setup({
        buffer     = { suffix = "b", options = {} },
        comment    = { suffix = "c", options = {} },
        conflict   = { suffix = "x", options = {} },
        diagnostic = { suffix = "d", options = {} },
        file       = { suffix = "f", options = {} },
        indent     = { suffix = "i", options = {} },
        jump       = { suffix = "j", options = {} },
        location   = { suffix = "l", options = {} },
        oldfile    = { suffix = "o", options = {} },
        quickfix   = { suffix = "q", options = {} },
        treesitter = { suffix = "t", options = {} },
        undo       = { suffix = "u", options = {} },
        window     = { suffix = "w", options = {} },
        yank       = { suffix = "y", options = {} },
      })
    end,
  },

  -- Fuzzy picker (alternative to telescope)
  {
    "echasnovski/mini.pick",
    version = "*",
    config = function()
      require("mini.pick").setup({
        mappings = {
          caret_left  = "<Left>",
          caret_right = "<Right>",
          choose      = "<CR>",
          choose_in_split    = "<C-s>",
          choose_in_tabpage  = "<C-t>",
          choose_in_vsplit   = "<C-v>",
          choose_marked      = "<M-CR>",
          delete_char        = "<BS>",
          delete_char_right  = "<Del>",
          delete_left        = "<C-u>",
          delete_word        = "<C-w>",
          mark     = "<C-x>",
          mark_all = "<C-a>",
          move_down  = "<C-n>",
          move_start = "<C-g>",
          move_up    = "<C-p>",
          paste      = "<C-r>",
          refine     = "<C-Space>",
          scroll_down = "<C-f>",
          scroll_left = "<C-h>",
          scroll_right = "<C-l>",
          scroll_up   = "<C-b>",
          stop = "<Esc>",
          toggle_info    = "<S-Tab>",
          toggle_preview = "<Tab>",
        },
        window = {
          config = {
            border = "rounded",
          },
        },
      })
      
      -- Pick keymaps migrated to snacks.picker in config/keymaps.lua
    end,
  },

  -- Visit tracking
  {
    "echasnovski/mini.visits",
    version = "*",
    config = function()
      require("mini.visits").setup()
      
      vim.keymap.set("n", "<leader>vv", function()
        require("mini.visits").add_label()
      end, { desc = "Add visit label" })
      
      vim.keymap.set("n", "<leader>vV", function()
        require("mini.visits").remove_label()
      end, { desc = "Remove visit label" })
      
      vim.keymap.set("n", "<leader>vl", function()
        require("mini.visits").list()
      end, { desc = "List visits" })
    end,
  },

  -- Session management
  {
    "echasnovski/mini.sessions",
    version = "*",
    config = function()
      require("mini.sessions").setup({
        autoread = false,
        autowrite = true,
        directory = vim.fn.stdpath("data") .. "/sessions",
      })
      
      vim.keymap.set("n", "<leader>ss", function()
        require("mini.sessions").select()
      end, { desc = "Select session" })
      
      vim.keymap.set("n", "<leader>sw", function()
        local session_name = vim.fn.input("Session name: ")
        if session_name ~= "" then
          require("mini.sessions").write(session_name)
          vim.notify("Session saved: " .. session_name, vim.log.levels.INFO)
        end
      end, { desc = "Write session" })
      
      vim.keymap.set("n", "<leader>sD", function()
        require("mini.sessions").select("delete")
      end, { desc = "Delete session" })
    end,
  },

  -- Fuzzy matching
  {
    "echasnovski/mini.fuzzy",
    version = "*",
    config = function()
      require("mini.fuzzy").setup()
    end,
  },

  -- Extra pickers and utilities
  {
    "echasnovski/mini.extra",
    version = "*",
    config = function()
      require("mini.extra").setup()
    end,
  },
}
