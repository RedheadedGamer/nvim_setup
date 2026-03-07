-- plugins/git/diffview.lua
-- Full-featured git diff viewer and merge conflict tool

return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",            desc = "Git Diff (working tree)" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>",           desc = "Git Diff Close" },
      { "<leader>gv", "<cmd>DiffviewFileHistory %<cr>",   desc = "Git File History (current)" },
      { "<leader>gV", "<cmd>DiffviewFileHistory<cr>",     desc = "Git Branch History" },
    },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        view = {
          default = {
            layout = "diff2_horizontal",
          },
          merge_tool = {
            -- Three-way merge layout: ours | result | theirs
            layout = "diff3_horizontal",
            disable_diagnostics = true,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 35,
          },
        },
        hooks = {
          diff_buf_read = function(bufnr)
            -- Disable distracting options in diff buffers
            vim.opt_local.wrap = false
            vim.opt_local.list = false
          end,
        },
      })
    end,
  },
}
