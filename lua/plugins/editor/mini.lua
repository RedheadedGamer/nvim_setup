-- plugins/editor/mini.lua
-- Consolidated and optimized mini.nvim configuration
-- Standardizes all essential micro-plugins from the mini.nvim ecosystem in one place

return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      -- ── 1. Auto-pairs (brackets/quotes auto-closing) ───────────────────────
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

      -- ── 2. Surround (add, delete, replace bracket/quotes/tags) ─────────────
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

      -- ── 3. Move lines and visual selections with Alt+hjkl ──────────────────
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

      -- ── 4. Enhanced text objects (around/inside queries) ───────────────────
      require("mini.ai").setup({
        n_lines = 500,
      })

      -- ── 5. Standard Comments (gc, gcc visual/normal commenting) ────────────
      require("mini.comment").setup({
        options = {
          ignore_blank_line = true,
        },
        mappings = {
          comment = "gc",
          comment_line = "gcc",
          comment_visual = "gc",
          textobject = "gc",
        },
      })

      -- ── 6. Text alignment (ga/gA visual selectors) ──────────────────────────
      require("mini.align").setup({
        mappings = {
          start = "ga",
          start_with_preview = "gA",
        },
      })

      -- ── 7. Statusline (clean, minimal status indicators) ────────────────────
      require("mini.statusline").setup({
        use_icons = true,
        set_vim_settings = false,
      })

      -- ── 8. Tabline (clean buffer/tab header interface) ─────────────────────
      require("mini.tabline").setup({
        show_icons = true,
        set_vim_settings = false,
        tabpage_section = "left",
      })

      -- ── 9. Cursorword (subtle highlight of current word under cursor) ──────
      require("mini.cursorword").setup({
        delay = 120,
      })

      -- ── 10. Hipatterns (highlight inline CSS hex colors beautifully) ───────
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      -- ── 11. Icons (modern nerd-font set + nvim-web-devicons mock) ───────────
      require("mini.icons").setup({
        file = {},
        directory = {},
        extension = {},
        filetype = {},
        lsp = {},
        os = {},
      })
      require("mini.icons").mock_nvim_web_devicons()

      -- ── 12. Bracketed (quick jumps: [b/[d etc.) ─────────────────────────────
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

      -- ── 13. Visits (jump to historically and frequently visited files) ─────
      require("mini.visits").setup()
      vim.keymap.set("n", "<leader>vv", function() require("mini.visits").add_label() end, { desc = "Add visit label" })
      vim.keymap.set("n", "<leader>vV", function() require("mini.visits").remove_label() end, { desc = "Remove visit label" })
      vim.keymap.set("n", "<leader>vl", function() require("mini.visits").list() end, { desc = "List visits" })

      -- ── 14. Trailspace (highlight and trim trailing whitespace) ─────────────
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
}
