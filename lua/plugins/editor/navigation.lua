-- plugins/editor/navigation.lua
-- Fast navigation: flash.nvim (jump labels) and harpoon (file bookmarks)

return {
  -- ============================================================================
  -- FLASH.NVIM - Fast navigation with search labels
  -- ============================================================================
  -- NOTE: flash uses `s` / `S` in normal mode by default, but since
  -- mini.surround occupies `sa`/`sd`/…, we map flash to `gl` / `gL` so both
  -- plugins coexist without conflict.
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- Search configuration
      search = {
        multi_window = true,
        forward = true,
        wrap = true,
        mode = "exact",
        incremental = false,
      },
      -- Jump configuration
      jump = {
        jumplist = true,
        pos = "start",
        history = false,
        register = false,
        nohlsearch = false,
        autojump = false,
      },
      -- Label configuration
      label = {
        uppercase = false,
        -- Exclude common Vim navigation/motion keys so they remain accessible
        -- while the flash label overlay is active.
        exclude = "hjkliardc",
        current = true,
        after = true,
        before = false,
        style = "overlay",
        reuse = "lowercase",
        distance = true,
        min_pattern_length = 0,
        rainbow = {
          enabled = false,
          shade = 5,
        },
      },
      highlight = {
        backdrop = true,
        matches = true,
        priority = 5000,
        groups = {
          match = "FlashMatch",
          current = "FlashCurrent",
          backdrop = "FlashBackdrop",
          label = "FlashLabel",
        },
      },
      -- Use `gl` for jump and `gL` for treesitter, keeping `s` for mini.surround
      modes = {
        char = {
          enabled = true,
          keys = { "f", "F", "t", "T", ";", "," },
          search = { wrap = false },
          highlight = { backdrop = false },
          jump = { register = false, autojump = true },
        },
        search = {
          enabled = false,
        },
        treesitter = {
          labels = "abcdefghijklmnopqrstuvwxyz",
          jump = { pos = "range" },
          search = { incremental = false },
          label = { before = true, after = true, style = "inline" },
          highlight = { backdrop = false, matches = false },
        },
      },
    },
    keys = {
      { "gl",  function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash jump" },
      { "gL",  function() require("flash").treesitter() end,        mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
      { "r",   function() require("flash").remote() end,            mode = "o",               desc = "Remote Flash" },
      { "R",   function() require("flash").treesitter_search() end, mode = { "o", "x" },      desc = "Treesitter Search" },
      { "<c-s>", function() require("flash").toggle() end,          mode = { "c" },           desc = "Toggle Flash Search" },
    },
  },

  -- ============================================================================
  -- HARPOON (v2) - Quick file navigation / bookmarks
  -- ============================================================================
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      -- Add current file to harpoon list
      vim.keymap.set("n", "<leader>aa", function()
        harpoon:list():add()
        vim.notify("File added to Harpoon", vim.log.levels.INFO)
      end, { desc = "Harpoon: add file" })

      -- Open the harpoon quick-menu
      vim.keymap.set("n", "<leader>am", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon: menu" })

      -- Jump to slots 1-5
      for i = 1, 5 do
        vim.keymap.set("n", "<leader>a" .. i, function()
          harpoon:list():select(i)
        end, { desc = "Harpoon: file " .. i })
      end

      -- Navigate prev/next in the harpoon list
      vim.keymap.set("n", "<leader>a[", function()
        harpoon:list():prev()
      end, { desc = "Harpoon: prev file" })

      vim.keymap.set("n", "<leader>a]", function()
        harpoon:list():next()
      end, { desc = "Harpoon: next file" })
    end,
  },
}
