-- plugins/init.lua
-- Plugin manager setup with lazy.nvim

return {
  -- Primary colorscheme (default)
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        options = {
          transparency = true,
        }
      })
    end,
  },
  
  -- Popular theme collection (optimized for transparency)
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
      })
    end,
  },
  
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
    end,
  },
  
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
  },
  
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = true
    end,
  },
  
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
    end,
  },
  
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        }
      })
    end,
  },
  
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    config = function()
      require("rose-pine").setup({
        disable_background = true,
      })
    end,
  },
  
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("kanagawa").setup({
        transparent = true,
      })
    end,
  },

  -- Essential dependencies
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },

  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "python", "javascript", "typescript", "html", "css", 
          "json", "yaml", "markdown", "bash", "vim", "vimdoc", "c", "java"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- Comment functionality
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- ============================================================================
  -- MINI.NVIM ECOSYSTEM (28 comprehensive plugins for enhanced development)
  -- ============================================================================

  -- Text manipulation and editing
  {
    "echasnovski/mini.pairs",
    version = "*",
    config = function()
      require("mini.pairs").setup()
    end,
  },

  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "sa", -- Add surrounding in Normal and Visual modes
          delete = "sd", -- Delete surrounding
          find = "sf", -- Find surrounding (to the right)
          find_left = "sF", -- Find surrounding (to the left)
          highlight = "sh", -- Highlight surrounding
          replace = "sr", -- Replace surrounding
          update_n_lines = "sn", -- Update `n_lines`
        },
      })
    end,
  },

  {
    "echasnovski/mini.indentscope",
    version = "*",
    config = function()
      require("mini.indentscope").setup({
        symbol = "╎",
        options = { try_as_border = true },
      })
    end,
  },

  -- Mini.move: Move lines and selections with Alt+hjkl
  {
    "echasnovski/mini.move",
    version = "*",
    config = function()
      require("mini.move").setup({
        mappings = {
          -- Move visual selection in Visual mode
          left = "<M-h>",
          right = "<M-l>",
          down = "<M-j>",
          up = "<M-k>",
          -- Move current line in Normal mode
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },
      })
    end,
  },

  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup({
        n_lines = 500,
      })
    end,
  },

  {
    "echasnovski/mini.jump",
    version = "*",
    config = function()
      require("mini.jump").setup()
    end,
  },

  -- File management and navigation
  {
    "echasnovski/mini.files",
    version = "*",
    config = function()
      require("mini.files").setup({
        windows = {
          preview = true,
          width_focus = 30,
          width_preview = 30,
        },
        options = {
          permanent_delete = false,
        },
      })
      
      -- Keymap to open mini.files
      vim.keymap.set("n", "<leader>e", function()
        require("mini.files").open()
      end, { desc = "Open File Explorer" })
    end,
  },

  -- UI and visual enhancements
  {
    "echasnovski/mini.statusline",
    version = "*",
    config = function()
      require("mini.statusline").setup({
        use_icons = true,
        set_vim_settings = false, -- Don't override vim settings
      })
    end,
  },

  -- Additional high-quality mini plugins for enhanced experience
  {
    "echasnovski/mini.bufremove",
    version = "*",
    config = function()
      require("mini.bufremove").setup()
      
      -- Keymap for better buffer deletion
      vim.keymap.set("n", "<leader>bd", function()
        require("mini.bufremove").delete()
      end, { desc = "Delete buffer (keep layout)" })
      
      vim.keymap.set("n", "<leader>bD", function()
        require("mini.bufremove").delete(0, true)
      end, { desc = "Force delete buffer" })
    end,
  },

  {
    "echasnovski/mini.starter",
    version = "*",
    lazy = false, -- Ensure it loads immediately
    priority = 1001, -- Load after colorscheme but very early
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        evaluate_single = true,
        items = {
          -- Essential actions section
          {
            { action = "enew", name = "N: New file", section = "📝 Quick Actions" },
            { action = "Telescope find_files", name = "F: Find files", section = "📝 Quick Actions" },
            { action = "Telescope live_grep", name = "G: Live grep", section = "📝 Quick Actions" },
            { action = "Telescope oldfiles", name = "R: Recent files", section = "📝 Quick Actions" },
          },
          -- Discovery and help section  
          {
            { action = "Telescope keymaps", name = "K: Browse keymaps", section = "🔍 Discovery" },
            { action = "Telescope commands", name = "C: Browse commands", section = "🔍 Discovery" },
            { action = "Telescope help_tags", name = "H: Browse help", section = "🔍 Discovery" },
            { action = "lua require('which-key').show({ global = true })", name = "?: Global keymaps", section = "🔍 Discovery" },
          },
          -- Theme and customization
          {
            { action = "lua require('telescope.builtin').colorscheme({enable_preview = true})", name = "T: Theme switcher", section = "🎨 Customize" },
            { action = "Telescope buffers", name = "B: Buffers", section = "🎨 Customize" },
            { action = "e ~/.config/nvim/init.lua", name = "I: Edit config", section = "🎨 Customize" },
            { action = "e ~/.config/nvim/lua/config/keymaps.lua", name = "M: Edit keymaps", section = "🎨 Customize" },
          },
          -- Management section
          {
            { action = "Lazy", name = "L: Plugin manager", section = "🔧 Management" },
            { action = "Mason", name = "S: LSP manager", section = "🔧 Management" },
            { action = "checkhealth", name = "D: Health check", section = "🔧 Management" },
            { action = "Lazy sync", name = "Y: Sync plugins", section = "🔧 Management" },
          },
          -- Session management (if sessions plugin is available)
          {
            { action = "lua require('mini.sessions').select()", name = "O: Load session", section = "💾 Sessions" },
            { action = "lua require('mini.sessions').write(vim.fn.input('Session name: '))", name = "W: Save session", section = "💾 Sessions" },
          },
          -- Built-in actions last
          starter.sections.recent_files(8, false),
          starter.sections.recent_files(5, true),
        },
        header = function()
          local hour = tonumber(vim.fn.strftime('%H'))
          local part_id = math.floor((hour + 4) / 8) + 1
          local day_part = ({ 'evening', 'morning', 'afternoon', 'evening' })[part_id]
          local username = vim.loop.os_getenv('USER') or 'user'
          
          -- Enhanced ASCII art header
          local header_art = {
            "╭─────────────────────────────────────────────────────────╮",
            "│                                                         │",
            "│  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗    │",
            "│  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║    │", 
            "│  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║    │",
            "│  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║    │",
            "│  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    │",
            "│  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝    │",
            "│                                                         │",
            "│           " .. string.format("Good %s, %s!", day_part, username) .. string.rep(" ", 25 - string.len(day_part .. username)) .. "│",
            "│                                                         │",
            "╰─────────────────────────────────────────────────────────╯",
          }
          
          return table.concat(header_art, '\n')
        end,
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
        end,
        content_hooks = {
          starter.gen_hook.adding_bullet("│ ", false),
          starter.gen_hook.indexing('all', { 'Builtin actions' }),
          starter.gen_hook.padding(3, 2),
          starter.gen_hook.aligning('center', 'center'),
        },
        query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
      })

      -- Ensure mini.starter is triggered properly on VimEnter
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("MiniStarterAutostart", { clear = true }),
        callback = function()
          -- Only open if no arguments were passed (no files to open)
          if vim.fn.argc() == 0 then
            starter.open()
          end
        end,
      })
    end,
  },

  {
    "echasnovski/mini.animate",
    version = "*",
    config = function()
      require("mini.animate").setup({
        cursor = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
        },
        resize = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
        },
        open = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
        },
        close = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
        },
      })
    end,
  },

  {
    "echasnovski/mini.cursorword",
    version = "*",
    config = function()
      require("mini.cursorword").setup({
        delay = 100, -- Delay before highlighting (in ms)
      })
    end,
  },

  {
    "echasnovski/mini.hipatterns",
    version = "*",
    config = function()
      local hipatterns = require("mini.hipatterns")
      require("mini.hipatterns").setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
          todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
          note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

          -- Highlight hex color strings (`#rrggbb`) with that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },

  {
    "echasnovski/mini.splitjoin",
    version = "*",
    config = function()
      require("mini.splitjoin").setup({
        mappings = {
          toggle = "gS", -- Toggle split/join
        },
      })
    end,
  },

  {
    "echasnovski/mini.trailspace",
    version = "*",
    config = function()
      require("mini.trailspace").setup()
      
      -- Keymap to remove trailing whitespace
      vim.keymap.set("n", "<leader>tw", function()
        require("mini.trailspace").trim()
        vim.notify("Trailing whitespace removed", vim.log.levels.INFO)
      end, { desc = "Trim trailing whitespace" })
      
      -- Keymap to remove all empty lines at end of file
      vim.keymap.set("n", "<leader>tl", function()
        require("mini.trailspace").trim_last_lines()
        vim.notify("Trailing empty lines removed", vim.log.levels.INFO)
      end, { desc = "Trim trailing empty lines" })
    end,
  },

  {
    "echasnovski/mini.operators",
    version = "*",
    config = function()
      require("mini.operators").setup({
        -- Each entry configures one operator.
        evaluate    = { prefix = "g=", func = nil },  -- Evaluate text and replace with result
        exchange    = { prefix = "gx", func = nil },  -- Exchange text regions
        multiply    = { prefix = "gm", func = nil },  -- Multiply (duplicate) text
        replace     = { prefix = "gr", func = nil },  -- Replace text with register
        sort        = { prefix = "gs", func = nil },  -- Sort text
      })
    end,
  },

  {
    "echasnovski/mini.visits",
    version = "*",
    config = function()
      require("mini.visits").setup()
      
      -- Keymaps for visits
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

  {
    "echasnovski/mini.sessions",
    version = "*",
    config = function()
      require("mini.sessions").setup({
        autoread = false, -- Don't auto-read session on startup
        autowrite = true, -- Auto-write session on exit
        directory = vim.fn.stdpath("data") .. "/sessions", -- Session directory
      })
      
      -- Session keymaps
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
      
      vim.keymap.set("n", "<leader>sd", function()
        require("mini.sessions").select("delete")
      end, { desc = "Delete session" })
    end,
  },

  -- ============================================================================
  -- QUALITY OF LIFE ENHANCEMENTS
  -- ============================================================================

  -- Which-key for key binding popup (essential for discoverability)
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
        { "<leader>t", group = "theme/trim", icon = "🎨" },
        { "<leader>g", group = "git/diff", icon = "📦" },
        { "<leader>c", group = "code/lsp", icon = "💻" },
        { "<leader>w", group = "window", icon = "🪟" },
        { "<leader>b", group = "buffer", icon = "📄" },
        { "<leader>v", group = "visits/mini.visits", icon = "📍" },
        { "<leader>s", group = "session/mini.sessions", icon = "💾" },
        { "<leader>m", group = "map/minimap", icon = "🗺️" },
        { "<leader>r", group = "refactor/rename", icon = "♻️" },
        { "<leader>d", group = "diagnostics", icon = "🩺" },
        { "<leader>h", group = "git hunks", icon = "📊" },
        { "<leader>l", group = "lsp", icon = "🔧" },
        { "<leader>n", group = "notifications/new", icon = "🔔" },
        { "<leader>c", group = "config/code", icon = "⚙️" },

        -- Git hunk actions (gitsigns)
        { "<leader>hs", desc = "Stage hunk", icon = "+" },
        { "<leader>hr", desc = "Reset hunk", icon = "↩️" },
        { "<leader>hS", desc = "Stage buffer", icon = "📁" },
        { "<leader>hu", desc = "Undo stage hunk", icon = "⏪" },
        { "<leader>hR", desc = "Reset buffer", icon = "🔄" },
        { "<leader>hp", desc = "Preview hunk", icon = "👁️" },
        { "<leader>hb", desc = "Blame line", icon = "👤" },
        { "<leader>hd", desc = "Diff this", icon = "🔍" },
        { "<leader>hD", desc = "Diff this ~", icon = "🔍" },

        -- Toggle commands
        { "<leader>tb", desc = "Toggle blame", icon = "👤" },
        { "<leader>td", desc = "Toggle deleted", icon = "🗑️" },
        { "<leader>tw", desc = "Trim trailing whitespace", icon = "✂️" },
        { "<leader>tl", desc = "Trim trailing empty lines", icon = "📝" },
        { "<leader>tt", desc = "Theme switcher", icon = "🎨" },
        { "<leader>tn", desc = "Toggle line numbers", icon = "🔢" },
        { "<leader>tr", desc = "Toggle relative numbers", icon = "🔢" },
        { "<leader>te", desc = "Open terminal", icon = "💻" },
        
        -- Enhanced keymap discovery
        { "<leader>fK", desc = "All keymaps browser", icon = "🗝️" },
        { "<leader>fkn", desc = "Normal mode keymaps", icon = "📝" },
        { "<leader>fkv", desc = "Visual mode keymaps", icon = "👁️" },
        { "<leader>fki", desc = "Insert mode keymaps", icon = "✏️" },

        -- Goto operations
        { "g", group = "goto/operators", icon = "🎯" },
        { "ga", desc = "Mini align", icon = "📐" },
        { "gA", desc = "Mini align with preview", icon = "👁️" },
        { "gS", desc = "Mini splitjoin toggle", icon = "🔄" },
        { "gs", desc = "Mini sort operator", icon = "🔤" },
        { "gr", desc = "Mini replace operator", icon = "🔄" },
        { "gm", desc = "Mini multiply operator", icon = "✖️" },
        { "gx", desc = "Mini exchange operator", icon = "🔄" },
        { "g=", desc = "Mini evaluate operator", icon = "🧮" },
        { "gh", desc = "Apply diff hunk", icon = "✅" },
        { "gH", desc = "Reset diff hunk", icon = "❌" },

        -- Surround operations
        { "s", group = "surround/mini.surround", icon = "🔄" },
        { "sa", desc = "Add surround", icon = "➕" },
        { "sd", desc = "Delete surround", icon = "➖" },
        { "sr", desc = "Replace surround", icon = "🔄" },
        { "sf", desc = "Find surround (right)", icon = "➡️" },
        { "sF", desc = "Find surround (left)", icon = "⬅️" },
        { "sh", desc = "Highlight surround", icon = "🔆" },
        { "sn", desc = "Update n_lines", icon = "📏" },

        -- Movement operations
        { "<M-h>", desc = "Move left (mini.move)", icon = "⬅️" },
        { "<M-j>", desc = "Move down (mini.move)", icon = "⬇️" },
        { "<M-k>", desc = "Move up (mini.move)", icon = "⬆️" },
        { "<M-l>", desc = "Move right (mini.move)", icon = "➡️" },

        -- Navigation groups
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
        border = "double", -- Changed from "rounded" to "double" for more attractive appearance
        padding = { 2, 3 }, -- Increased padding for better spacing
        title = true,
        title_pos = "center",
        zindex = 1000,
        wo = {
          winblend = 0, -- Full transparency for better background blending
          winhighlight = "Normal:WhichKeyFloat,FloatBorder:WhichKeyBorder",
        },
      },
      layout = {
        width = { min = 20, max = 50 }, -- Added max width for better layout
        spacing = 4, -- Increased spacing
        align = "center", -- Center alignment
      },
      keys = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
      },
      -- Enable all built-in plugins
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

  -- Better UI for vim.ui interfaces
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
          backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
          trim_prompt = true,
          telescope = require("telescope.themes").get_dropdown({
            winblend = 10,
          }),
        },
      })
    end,
  },

  -- Fancy notification manager
  {
    "rcarriga/nvim-notify",
    config = function()
      -- Check for Neovim version compatibility (nvim-notify requires vim.version.ge which is 0.8+)
      local version_ok = vim.version and vim.version.ge and vim.version.ge(vim.version(), {0, 8, 0})
      
      if not version_ok then
        -- Fallback for older Neovim versions
        vim.notify = function(msg, level)
          local levels = { "ERROR", "WARN", "INFO", "DEBUG" }
          local level_name = levels[level] or "INFO"
          print(string.format("[%s] %s", level_name, tostring(msg)))
        end
        return
      end
      
      require("notify").setup({
        background_colour = "#000000",
        fps = 30,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = ""
        },
        level = 2,
        minimum_width = 50,
        render = "default",
        stages = "fade_in_slide_out",
        timeout = 3000,
        top_down = true
      })
      
      -- Set nvim-notify as the default notification handler
      vim.notify = require("notify")
      
      -- Notification keymaps
      vim.keymap.set("n", "<leader>nd", function()
        require("notify").dismiss({ silent = true, pending = true })
      end, { desc = "Dismiss notifications" })
      
      vim.keymap.set("n", "<leader>nh", function()
        require("notify").history()
      end, { desc = "Notification history" })
      
      vim.keymap.set("n", "<leader>nc", function()
        require("notify").dismiss()
      end, { desc = "Clear notifications" })
    end,
  },

  -- ============================================================================
  -- CORE DEVELOPMENT TOOLS
  -- ============================================================================

  -- Telescope (fuzzy finder) with optimized theme switcher
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      
      -- Configure vimgrep_arguments with fallback support
      local vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename", 
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden"
      }
      
      -- Fallback to grep if ripgrep is not available
      if vim.fn.executable("rg") ~= 1 then
        vimgrep_arguments = {
          "grep",
          "-r", 
          "-n",
          "-H",
          "--exclude-dir=.git",
          "--exclude-dir=node_modules",
          "--exclude=*.min.js",
          "--exclude=*.log"
        }
      end
      
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          vimgrep_arguments = vimgrep_arguments,
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
      
      -- Enhanced keymap discovery - comprehensive keymap browser
      keymap.set("n", "<leader>fK", function()
        require("telescope.builtin").keymaps({
          prompt_title = "🗝️  All Keymaps Browser",
          show_plug = true,
          only_buf = false,
          modes = {"n", "i", "v", "x", "c", "t", "o"}, -- All modes
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              width = 0.9,
              height = 0.9,
              preview_height = 0.6,
            },
          },
        })
      end, { desc = "All Keymaps Browser" })
      
      -- Quick keymap help for specific modes
      keymap.set("n", "<leader>fkn", function()
        require("telescope.builtin").keymaps({
          prompt_title = "Normal Mode Keymaps",
          modes = {"n"},
        })
      end, { desc = "Normal Mode Keymaps" })
      
      keymap.set("n", "<leader>fkv", function()
        require("telescope.builtin").keymaps({
          prompt_title = "Visual Mode Keymaps", 
          modes = {"v", "x"},
        })
      end, { desc = "Visual Mode Keymaps" })
      
      keymap.set("n", "<leader>fki", function()
        require("telescope.builtin").keymaps({
          prompt_title = "Insert Mode Keymaps",
          modes = {"i"},
        })
      end, { desc = "Insert Mode Keymaps" })
      keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
      keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Grep String" })
      keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Grep Word" })
      keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Marks" })
      keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Jumplist" })
      keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Projects" })
      keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
      keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix" })
      keymap.set("n", "<leader>fl", "<cmd>Telescope loclist<cr>", { desc = "Location List" })
      
      -- Theme switcher keymap
      keymap.set("n", "<leader>tt", function() theme_switcher() end, { desc = "Theme Switcher" })
      
      -- Optimized theme switcher with curated high-quality themes
      local function theme_switcher()
        local themes = {
          -- Primary themes
          "onedark_dark",
          "tokyonight",
          "tokyonight-night",
          "tokyonight-storm", 
          "tokyonight-day",
          "gruvbox",
          "dracula",
          "nord",
          -- Catppuccin variants
          "catppuccin",
          "catppuccin-latte",
          "catppuccin-frappe", 
          "catppuccin-macchiato",
          "catppuccin-mocha",
          -- Nightfox family
          "nightfox",
          "nordfox",
          "dawnfox",
          "duskfox",
          "terafox",
          "carbonfox",
          -- Rose Pine variants
          "rose-pine",
          "rose-pine-main",
          "rose-pine-moon",
          "rose-pine-dawn",
          -- Kanagawa variants
          "kanagawa",
          "kanagawa-wave",
          "kanagawa-dragon",
          "kanagawa-lotus",
        }
        
        vim.ui.select(themes, {
          prompt = "Select a theme:",
          format_item = function(item)
            return "🎨 " .. item
          end,
        }, function(choice)
          if choice then
            local theme_manager = require("config.theme")
            -- Try to apply the colorscheme
            if theme_manager.apply_theme(choice) then
              -- If successful, save it for persistence
              theme_manager.save_theme(choice)
            end
          end
        end)
      end
      
      keymap.set("n", "<leader>th", theme_switcher, { desc = "Theme switcher" })
      keymap.set("n", "<leader>tt", theme_switcher, { desc = "Theme switcher" })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      -- Mason setup with enhanced compatibility
      require("mason").setup({
        ui = {
          border = "rounded",
        },
        -- Add timeout and retry settings for better reliability
        max_concurrent_installers = 4,
        providers = {
          "mason.providers.registry-api",
          "mason.providers.client",
        },
      })
      
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",     -- C/C++ LSP (prioritized as default)
          "lua_ls",
          "pyright", 
          "ts_ls",
          "html",
          "cssls",
          "jsonls",
          "jdtls",      -- Java LSP
        },
        automatic_installation = true,
      })

      -- LSP settings
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      
      local capabilities = cmp_nvim_lsp.default_capabilities()
      
      local on_attach = function(client, bufnr)
        local keymap = vim.keymap
        local opts = { buffer = bufnr, silent = true }
        
        -- LSP keymaps (replacing CoC mappings) - with proper descriptions for which-key
        keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
        keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
        keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
        keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
        keymap.set("n", "<leader>lf", vim.lsp.buf.format, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
        keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
        keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        keymap.set("n", "<leader>ld", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
        keymap.set("n", "<leader>ll", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostic loclist" }))
        keymap.set("n", "<leader>lq", vim.diagnostic.setqflist, vim.tbl_extend("force", opts, { desc = "Diagnostic quickfix" }))
        keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))
        keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", vim.tbl_extend("force", opts, { desc = "LSP info" }))
      end

      -- Configure LSP servers with shared setup
      local servers = {
        -- Prioritize clangd configuration for C/C++ development
        clangd = {
          cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = function() 
            return vim.loop.cwd() 
          end,
          settings = {
            clangd = {
              fallbackFlags = { "-std=c++17" },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            },
          },
        },
        pyright = {},
        ts_ls = {},
        html = {},
        cssls = {},
        jsonls = {},
        jdtls = {
          settings = {
            java = {
              signatureHelp = { enabled = true },
              contentProvider = { preferred = "fernflower" },
            },
          },
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        config.on_attach = on_attach
        lspconfig[server].setup(config)
      end

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
      })

      -- Completion setup (nvim-cmp)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      require("luasnip.loaders.from_vscode").lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  },

  -- ============================================================================
  -- SPECIALIZED TOOLS
  -- ============================================================================

  -- LaTeX support
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
    end,
  },

  -- Trouble.nvim: Better diagnostics display (updated for new API)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        auto_close = false,
        auto_open = false,
        auto_preview = true,
        auto_refresh = true,
        use_diagnostic_signs = true,
      })
      
      local keymap = vim.keymap
      -- Updated keybinds for new trouble.nvim API
      keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Trouble" })
      keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
      keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
      keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List" })
      keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols" })
      keymap.set("n", "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP References" })
    end,
  },

  -- Additional mini.nvim ecosystem plugins (extending coverage to 28 total)
  {
    "echasnovski/mini.align",
    version = "*",
    config = function()
      require("mini.align").setup({
        mappings = {
          start = "ga",
          start_with_preview = "gA",
        },
      })
    end,
  },

  {
    "echasnovski/mini.bracketed",
    version = "*",
    config = function()
      require("mini.bracketed").setup({
        -- First letter of every pair defines the target
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

  {
    "echasnovski/mini.diff",
    version = "*",
    config = function()
      require("mini.diff").setup({
        view = {
          style = "sign",
          signs = { add = "+", change = "~", delete = "-" },
        },
        mappings = {
          apply = "gh",
          reset = "gH",
          textobject = "gh",
          goto_first = "[H",
          goto_prev = "[h",
          goto_next = "]h",
          goto_last = "]H",
        },
      })
    end,
  },

  {
    "echasnovski/mini.extra",
    version = "*",
    config = function()
      require("mini.extra").setup()
    end,
  },

  {
    "echasnovski/mini.fuzzy",
    version = "*",
    config = function()
      require("mini.fuzzy").setup()
    end,
  },

  -- Git integration with fugitive.vim (replacing problematic mini.git)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git log --oneline<cr>", desc = "Git log" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    },
  },

  -- Gitsigns for enhanced git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end, { desc = "Next git hunk" })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end, { desc = "Previous git hunk" })

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk" })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset hunk" })
          map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage hunk" })
          map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset hunk" })
          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage buffer" })
          map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Reset buffer" })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview hunk" })
          map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = "Blame line" })
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Toggle blame" })
          map('n', '<leader>hd', gitsigns.diffthis, { desc = "Diff this" })
          map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "Diff this ~" })
          map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
        end
      })
    end,
  },

  {
    "echasnovski/mini.icons",
    version = "*",
    config = function()
      require("mini.icons").setup({
        file = {},
        directory = {},
        extension = {},
        filetype = {},
        lsp = {},
        os = {},
      })
    end,
  },

  {
    "echasnovski/mini.jump2d",
    version = "*",
    config = function()
      require("mini.jump2d").setup({
        mappings = {
          start_jumping = "<CR>",
        },
        view = {
          dim = true,
          n_steps_ahead = 0,
        },
      })
    end,
  },

  {
    "echasnovski/mini.map",
    version = "*",
    config = function()
      require("mini.map").setup({
        integrations = {
          require("mini.map").gen_integration.builtin_search(),
          require("mini.map").gen_integration.diff(),
          require("mini.map").gen_integration.diagnostic(),
        },
        symbols = {
          encode = require("mini.map").gen_encode_symbols.dot("4x2"),
        },
        window = {
          side = "right",
          width = 15,
          winblend = 25,
        },
      })
      
      -- Map keymaps
      vim.keymap.set("n", "<leader>mm", function()
        require("mini.map").toggle()
      end, { desc = "Toggle minimap" })
      
      vim.keymap.set("n", "<leader>mr", function()
        require("mini.map").refresh()
      end, { desc = "Refresh minimap" })
      
      vim.keymap.set("n", "<leader>mf", function()
        require("mini.map").toggle_focus()
      end, { desc = "Focus minimap" })
    end,
  },

  {
    "echasnovski/mini.misc",
    version = "*",
    config = function()
      require("mini.misc").setup()
      
      -- Set up some useful mini.misc functions
      vim.keymap.set("n", "<leader>z", function()
        require("mini.misc").zoom()
      end, { desc = "Zoom current window" })
    end,
  },

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
      
      -- Pick keymaps as alternatives to telescope
      vim.keymap.set("n", "<leader>pf", function()
        require("mini.pick").builtin.files()
      end, { desc = "Pick files" })
      
      vim.keymap.set("n", "<leader>pg", function()
        require("mini.pick").builtin.grep_live()
      end, { desc = "Pick grep live" })
      
      vim.keymap.set("n", "<leader>pb", function()
        require("mini.pick").builtin.buffers()
      end, { desc = "Pick buffers" })
      
      vim.keymap.set("n", "<leader>ph", function()
        require("mini.pick").builtin.help()
      end, { desc = "Pick help" })
    end,
  },

  {
    "echasnovski/mini.tabline",
    version = "*",
    config = function()
      require("mini.tabline").setup({
        show_icons = true,
        set_vim_settings = false,
        tabpage_section = "left",
      })
    end,
  },

  -- Formatting (disabled auto-format on save for custom standards)
  {
    "stevearc/conform.nvim",
    config = function()
      -- Helper function to check if a formatter is available
      local function is_formatter_available(formatter)
        return vim.fn.executable(formatter) == 1
      end

      -- Build formatters table based on what's available
      local formatters_by_ft = {}
      
      -- Only add formatters that are available
      if is_formatter_available("stylua") then
        formatters_by_ft.lua = { "stylua" }
      end
      
      if is_formatter_available("black") then
        formatters_by_ft.python = { "black" }
      end
      
      if is_formatter_available("prettier") then
        formatters_by_ft.javascript = { "prettier" }
        formatters_by_ft.typescript = { "prettier" }
        formatters_by_ft.html = { "prettier" }
        formatters_by_ft.css = { "prettier" }
        formatters_by_ft.json = { "prettier" }
        formatters_by_ft.yaml = { "prettier" }
      end
      
      -- C formatter
      if is_formatter_available("clang-format") then
        formatters_by_ft.c = { "clang-format" }
        formatters_by_ft.cpp = { "clang-format" }
      end
      
      -- Java formatter
      if is_formatter_available("google-java-format") then
        formatters_by_ft.java = { "google-java-format" }
      end

      require("conform").setup({
        formatters_by_ft = formatters_by_ft,
        -- Automatic formatting disabled by user request
        -- Manual formatting available via <leader>fm
        -- format_on_save = {
        --   timeout_ms = 500,
        --   lsp_fallback = true,
        -- },
      })
      
      -- Manual format keymap (optional)
      vim.keymap.set("n", "<leader>fm", function()
        require("conform").format({ lsp_fallback = true })
      end, { desc = "Format buffer manually" })
    end,
  },
}
