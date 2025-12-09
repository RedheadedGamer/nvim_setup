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
      preset = "helix", -- Changed from "modern" to "helix" for better theme
      -- Delay before showing the popup
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,
      spec = {
        -- Leader key groups
        { "<leader>f", group = "find/telescope", icon = "🔍" },
        { "<leader>p", group = "pick/mini.pick", icon = "📋" },
        { "<leader>x", group = "trouble/diagnostics", icon = "🔧" },
        { "<leader>t", group = "theme/toggle/terminal", icon = "🎨" },
        { "<leader>g", group = "git/snacks", icon = "📦" },
        { "<leader>c", group = "code/lsp", icon = "💻" },
        { "<leader>w", group = "window", icon = "🪟" },
        { "<leader>b", group = "buffer/snacks", icon = "📄" },
        { "<leader>v", group = "visits/mini.visits", icon = "📍" },
        { "<leader>s", group = "session/snacks/scope", icon = "💾" },
        { "<leader>m", group = "map/minimap", icon = "🗺️" },
        { "<leader>r", group = "refactor/rename", icon = "♻️" },
        { "<leader>d", group = "debug/diagnostics/profiler", icon = "🩺" },
        { "<leader>h", group = "git hunks", icon = "📊" },
        { "<leader>l", group = "lsp", icon = "🔧" },
        { "<leader>n", group = "notifications/snacks", icon = "🔔" },
        { "<leader>z", group = "zen/snacks", icon = "🧘" },
        { "<leader>j", group = "java/jdtls", icon = "☕" },
        
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
          enabled = true,
          default_prompt = "Input:",
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
      
      -- Telescope keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
      keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
      keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
      keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
      keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
      keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
      
      -- Enhanced keymap discovery
      keymap.set("n", "<leader>fK", function()
        require("telescope.builtin").keymaps({
          prompt_title = "🗝️  All Keymaps Browser",
          show_plug = true,
          only_buf = false,
          modes = {"n", "i", "v", "x", "c", "t", "o"},
        })
      end, { desc = "All keymaps browser" })
      
      keymap.set("n", "<leader>fkn", function()
        require("telescope.builtin").keymaps({
          prompt_title = "📝 Normal Mode Keymaps",
          modes = {"n"},
        })
      end, { desc = "Normal mode keymaps" })
      
      keymap.set("n", "<leader>fkv", function()
        require("telescope.builtin").keymaps({
          prompt_title = "👁️  Visual Mode Keymaps",
          modes = {"v", "x"},
        })
      end, { desc = "Visual mode keymaps" })
      
      keymap.set("n", "<leader>fki", function()
        require("telescope.builtin").keymaps({
          prompt_title = "✏️  Insert Mode Keymaps",
          modes = {"i"},
        })
      end, { desc = "Insert mode keymaps" })
      
      -- Theme switcher
      local theme_config = require("config.theme")
      local theme_switcher = function()
        local themes = theme_config.get_available_themes()
        local original_theme = _G.nvim_current_theme or vim.g.current_theme or vim.g.colors_name or "default"
        
        require("telescope.pickers").new(require("telescope.themes").get_dropdown({
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
        }), {
          prompt_title = "🎨 Theme Switcher",
          finder = require("telescope.finders").new_table({
            results = themes,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry,
                ordinal = entry,
              }
            end,
          }),
          sorter = require("telescope.config").values.generic_sorter({}),
          previewer = false,
          layout_config = {
            width = 0.8,
            height = 0.7,
            prompt_position = "top",
          },
          attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            local state = require("telescope.actions.state")
            
            actions.select_default:replace(function()
              local selection = state.get_selected_entry()
              actions.close(prompt_bufnr)
              if selection then
                local theme_name = selection.value
                if theme_config.apply_theme(theme_name) then
                  theme_config.save_theme(theme_name)
                  vim.notify("🎨 Theme applied and saved: " .. theme_name, vim.log.levels.INFO)
                else
                  vim.notify("❌ Failed to load theme: " .. theme_name, vim.log.levels.ERROR)
                end
              end
            end)
            
            local restore_theme = function()
              actions.close(prompt_bufnr)
              theme_config.apply_theme(original_theme)
              vim.notify("🔄 Theme restored to: " .. original_theme, vim.log.levels.INFO)
            end
            
            map("i", "<C-c>", restore_theme)
            map("n", "<Esc>", restore_theme)
            map("n", "q", restore_theme)
            
            return true
          end,
        }):find()
      end
      
      keymap.set("n", "<leader>th", theme_switcher, { desc = "Theme switcher" })
    end,
  },
}
