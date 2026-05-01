return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      highlight = {
        multiline = true,
        keyword = "wide",
      },
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo (Snacks)" },
      { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Todo (Snacks)" },
    },
  },
}
