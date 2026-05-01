-- plugins/lang/markdown.lua
-- Markdown support: live browser preview via markdown-preview.nvim

return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      -- Install the required node dependencies
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      -- Configuration must be set before the plugin loads
      vim.g.mkdp_auto_start = 0            -- don't auto-open preview
      vim.g.mkdp_auto_close = 1            -- close preview when buffer is closed
      vim.g.mkdp_refresh_slow = 0          -- refresh in real-time
      vim.g.mkdp_command_for_global = 0    -- only available in markdown buffers
      vim.g.mkdp_open_to_the_world = 0     -- only accessible locally
      vim.g.mkdp_browser = ""              -- use the system default browser
      vim.g.mkdp_echo_preview_url = 1      -- print the preview URL in cmdline
      vim.g.mkdp_page_title = "${name}"    -- tab title = filename
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown Preview toggle" },
      { "<leader>mo", "<cmd>MarkdownPreview<cr>",       ft = "markdown", desc = "Markdown Preview open" },
      { "<leader>mc", "<cmd>MarkdownPreviewStop<cr>",   ft = "markdown", desc = "Markdown Preview close" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {},
  },
}
