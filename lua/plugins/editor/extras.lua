-- plugins/editor/extras.lua
-- Additional editor enhancement plugins

return {
  -- ============================================================================
  -- NVIM-BQF - Better quickfix window with preview and filtering
  -- ============================================================================
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      auto_enable = true,
      auto_resize_height = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border = "rounded",
        show_title = true,
        should_preview_cb = function(bufnr, _qwinid)
          -- Skip preview for very large files
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            ret = false
          end
          return ret
        end,
      },
      func_map = {
        drop = "o",
        openc = "O",
        split = "<C-s>",
        tabdrop = "<C-t>",
        tabc = "",
        ptogglemode = "z,",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    },
  },

  -- ============================================================================
  -- PROJECT.NVIM - Automatic project root detection
  -- ============================================================================
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup({
        -- Detection methods: "lsp" uses LSP root, "pattern" uses file patterns
        detection_methods = { "lsp", "pattern" },
        patterns = {
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "Makefile",
          "package.json",
          "CMakeLists.txt",
          "build.gradle",
          "pom.xml",
          "Cargo.toml",
          "go.mod",
          "pyproject.toml",
          "setup.py",
        },
        -- Silently ignore directories listed here
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = "global",
        datapath = vim.fn.stdpath("data"),
      })

      -- Integration with Telescope for recent projects
      local ok_telescope, telescope = pcall(require, "telescope")
      if ok_telescope then
        telescope.load_extension("projects")
        vim.keymap.set("n", "<leader>fp", function()
          require("telescope").extensions.projects.projects()
        end, { desc = "Find Projects" })
      end
    end,
  },

  -- ============================================================================
  -- TODO-COMMENTS - Rich TODO/FIXME/HACK/NOTE/PERF highlighting
  -- with Telescope, Trouble, and jump integration.
  -- mini.hipatterns no longer handles these keywords to avoid duplication.
  -- ============================================================================
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
      { "<leader>ft", function() Snacks.picker.todo_comments() end,
        desc = "Find TODOs (Snacks)" },
      { "<leader>st", function() Snacks.picker.todo_comments() end,
        desc = "Search TODOs (Snacks)" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>",
        desc = "TODOs (Trouble)" },
      { "]T", function() require("todo-comments").jump_next() end,
        desc = "Next TODO comment" },
      { "[T", function() require("todo-comments").jump_prev() end,
        desc = "Previous TODO comment" },
    },
  },
}
