-- plugins/editor/extras.lua
-- Additional editor enhancement plugins

return {
  -- todo-comments.nvim: rich TODO/FIXME/HACK/NOTE/PERF highlighting
  -- with Telescope, Trouble, and jump integration.
  -- mini.hipatterns no longer handles these keywords to avoid duplication.
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning",  alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "default",  alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint",     alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test",    alt = { "TESTING", "PASSED", "FAILED" } },
      },
      highlight = {
        multiline = true,
        before = "",
        keyword = "wide_fg",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        pattern = [[\b(KEYWORDS):]],
      },
    },
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>",
        desc = "Find TODOs (Telescope)" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>",
        desc = "TODOs (Trouble)" },
      { "]T", function() require("todo-comments").jump_next() end,
        desc = "Next TODO comment" },
      { "[T", function() require("todo-comments").jump_prev() end,
        desc = "Previous TODO comment" },
    },
  },
}
