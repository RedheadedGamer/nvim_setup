-- plugins/ui/utilities.lua
-- UI enhancement plugins (which-key, dressing, telescope)

return {
  -- ============================================================================
  -- WHICH-KEY - Key binding discovery
  -- ============================================================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Using "helix" preset provides:
      -- - Better organized layout with categories
      -- - Improved visual hierarchy
      -- - More intuitive navigation
      -- - Better support for nested keybindings
      preset = "helix",
      -- Delay before showing the popup
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,
      spec = {
        -- Leader key groups
        { "<leader>f", group = "find/picker", icon = "🔍" },
        { "<leader>p", group = "pick/mini.pick", icon = "📋" },
        { "<leader>x", group = "trouble/diagnostics", icon = "🔧" },
        { "<leader>t", group = "theme/toggle/terminal", icon = "🎨" },
        { "<leader>g", group = "git (snacks/gitsigns/diffview)", icon = "📦" },
        { "<leader>w", group = "window", icon = "🪟" },
        { "<leader>b", group = "buffer/snacks", icon = "📄" },
        { "<leader>v", group = "visits/mini.visits", icon = "📍" },
        { "<leader>s", group = "session/snacks/scope", icon = "💾" },
        { "<leader>m", group = "map/minimap/markdown", icon = "🗺️" },
        { "<leader>r", group = "refactor/rename", icon = "♻️" },
        { "<leader>d", group = "debug/diagnostics/profiler", icon = "🩺" },
        { "<leader>h", group = "git hunks", icon = "📊" },
        { "<leader>l", group = "lsp", icon = "🔧" },
        { "<leader>n", group = "notifications/snacks", icon = "🔔" },
        { "<leader>z", group = "zen/snacks", icon = "🧘" },
        { "<leader>j", group = "java/jdtls", icon = "☕" },
        { "<leader>a", group = "harpoon", icon = "🪝" },
        
        -- Additional keymap documentation
        { "g", group = "goto/operators", icon = "🎯" },
        { "s", group = "surround/mini.surround", icon = "🔄" },
        { "[", group = "previous (mini.bracketed)", icon = "⬅️" },
        { "]", group = "next (mini.bracketed)", icon = "➡️" },
      },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        ellipsis = "…",
        mappings = true,
        rules = {},
        colors = true,
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          Space = "󱁐 ",
          Tab = "󰌒 ",
        },
      },
      win = {
        border = "double",
        padding = { 2, 3 },
        title = true,
        title_pos = "center",
        zindex = 1000,
        wo = {
          winblend = 0,
          winhighlight = "Normal:WhichKeyFloat,FloatBorder:WhichKeyBorder",
        },
      },
      layout = {
        width = { min = 20, max = 50 },
        spacing = 4,
        align = "center",
      },
      keys = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
      },
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      show_help = true,
      show_keys = true,
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        "<leader><leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Global Keymaps (which-key)",
      },
    },
  },

  -- ============================================================================
  -- DRESSING - Better UI for vim.ui interfaces
  -- ============================================================================
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = {
          enabled = false, -- snacks.input replaces vim.ui.input; disable to avoid conflict
          prompt_align = "left",
          insert_only = true,
          start_in_insert = true,
          border = "rounded",
          relative = "cursor",
          prefer_width = 40,
          width = nil,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
          win_options = {
            winblend = 10,
            winhighlight = "",
          },
        },
        select = {
          enabled = true,
          backend = { "telescope", "builtin", "fzf_lua", "nui" },
          trim_prompt = true,
          telescope = require("telescope.themes").get_dropdown({
            winblend = 10,
            layout_config = {
              width = 0.8,
              height = 0.8,
              prompt_position = "top",
            },
            sorting_strategy = "ascending",
          }),
          builtin = {
            show_numbers = true,
            border = "rounded",
            relative = "editor",
            buf_options = {},
            win_options = {
              winblend = 10,
              winhighlight = "",
            },
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.8,
            min_height = { 10, 0.2 },
            mappings = {
              ["<Esc>"] = "Close",
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
            },
          },
          get_config = function(opts)
            if opts.prompt and (opts.prompt:match("theme") or opts.prompt:match("🎨")) then
              return {
                backend = "telescope",
                telescope = require("telescope.themes").get_dropdown({
                  winblend = 10,
                  layout_config = {
                    width = 0.7,
                    height = 0.75,
                    preview_cutoff = 120,
                    prompt_position = "top",
                  },
                  scroll_strategy = "limit",
                  sorting_strategy = "ascending",
                  layout_strategy = "vertical",
                }),
              }
            end
            return {}
          end,
        },
      })
    end,
  },

  -- ============================================================================
  -- TELESCOPE - Fuzzy finder
  -- ============================================================================
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- ERROR HANDLING: Protect telescope loading
      local ok_telescope, telescope = pcall(require, "telescope")
      local ok_actions, actions = pcall(require, "telescope.actions")
      if not ok_telescope or not ok_actions then
        vim.notify("Failed to load telescope", vim.log.levels.ERROR)
        return
      end
      
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            },
          },
        },
      })
      
      -- Telescope keymaps migrated to snacks.picker in config/keymaps.lua
    end,
  },
}
