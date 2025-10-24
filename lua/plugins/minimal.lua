-- plugins/minimal.lua
-- Minimal plugin configuration without LSP, Mason, and C/C++ development tools
-- This configuration provides essential editing features with a lightweight footprint

return {
  -- ============================================================================
  -- ESSENTIAL THEMES (5 popular themes for minimal setup)
  -- ============================================================================
  
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
    lazy = false,
    priority = 999,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
    end,
  },
  
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 998,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
    end,
  },
  
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 997,
    config = function()
      require("dracula").setup({
        transparent_bg = true,
        show_end_of_buffer = false,
      })
    end,
  },
  
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 996,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          telescope = true,
          which_key = true,
        },
      })
    end,
  },

  -- ============================================================================
  -- ESSENTIAL DEPENDENCIES
  -- ============================================================================
  
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },

  -- ============================================================================
  -- SYNTAX HIGHLIGHTING
  -- ============================================================================
  
  -- Treesitter (syntax highlighting) - Essential for good syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "python", "javascript", "html", "css", 
          "json", "yaml", "markdown", "bash", "vim", "vimdoc"
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

  -- ============================================================================
  -- ESSENTIAL MINI.NVIM PLUGINS
  -- ============================================================================
  
  -- Auto-close brackets and quotes
  {
    "echasnovski/mini.pairs",
    version = "*",
    config = function()
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
    end,
  },
  
  -- Surround text with brackets, quotes, tags
  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
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
    end,
  },
  
  -- Visualize and operate on indent scope
  {
    "echasnovski/mini.indentscope",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
      })
    end,
  },
  
  -- Move lines and selections
  {
    "echasnovski/mini.move",
    version = "*",
    config = function()
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
    end,
  },
  
  -- Better text objects (around/inside)
  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup({
        n_lines = 500,
      })
    end,
  },
  
  -- File explorer
  {
    "echasnovski/mini.files",
    version = "*",
    config = function()
      require("mini.files").setup({
        windows = {
          preview = true,
          width_preview = 50,
        },
      })
      
      vim.keymap.set("n", "<leader>e", function()
        require("mini.files").open()
      end, { desc = "Open File Explorer" })
    end,
  },
  
  -- Minimal statusline
  {
    "echasnovski/mini.statusline",
    version = "*",
    config = function()
      require("mini.statusline").setup({
        use_icons = true,
        set_vim_settings = false,
      })
    end,
  },
  
  -- Better buffer deletion
  {
    "echasnovski/mini.bufremove",
    version = "*",
    config = function()
      require("mini.bufremove").setup()
      
      vim.keymap.set("n", "<leader>bd", function()
        require("mini.bufremove").delete()
      end, { desc = "Delete Buffer" })
      
      vim.keymap.set("n", "<leader>bD", function()
        require("mini.bufremove").delete(0, true)
      end, { desc = "Force Delete Buffer" })
    end,
  },
  
  -- Beautiful start screen
  {
    "echasnovski/mini.starter",
    version = "*",
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        items = {
          starter.sections.builtin_actions(),
          starter.sections.recent_files(5, false),
          starter.sections.recent_files(5, true),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.aligning("center", "center"),
        },
      })
    end,
  },
  
  -- Smooth animations
  {
    "echasnovski/mini.animate",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.animate").setup({
        cursor = { enable = false },
        scroll = { enable = true },
        resize = { enable = true },
        open = { enable = true },
        close = { enable = true },
      })
    end,
  },
  
  -- Highlight word under cursor
  {
    "echasnovski/mini.cursorword",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup({
        delay = 100,
      })
    end,
  },
  
  -- Highlight patterns (TODO, FIXME, hex colors)
  {
    "echasnovski/mini.hipatterns",
    version = "*",
    event = "VeryLazy",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
          hack = { pattern = "HACK", group = "MiniHipatternsHack" },
          todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
          note = { pattern = "NOTE", group = "MiniHipatternsNote" },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  
  -- Show and remove trailing whitespace
  {
    "echasnovski/mini.trailspace",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.trailspace").setup()
      
      vim.keymap.set("n", "<leader>tw", function()
        require("mini.trailspace").trim()
      end, { desc = "Trim Whitespace" })
      
      vim.keymap.set("n", "<leader>tl", function()
        require("mini.trailspace").trim_last_lines()
      end, { desc = "Trim Last Lines" })
    end,
  },
  
  -- Comment functionality
  {
    "echasnovski/mini.comment",
    version = "*",
    config = function()
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
    end,
  },
  
  -- Tabline
  {
    "echasnovski/mini.tabline",
    version = "*",
    config = function()
      require("mini.tabline").setup({
        show_icons = true,
        set_vim_settings = false,
      })
    end,
  },
  
  -- Icons
  {
    "echasnovski/mini.icons",
    version = "*",
    config = function()
      require("mini.icons").setup()
    end,
  },

  -- ============================================================================
  -- TELESCOPE - Essential for file finding
  -- ============================================================================
  
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      
      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<CR>"] = actions.select_default,
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
      keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
      
      -- Theme switcher for minimal setup
      keymap.set("n", "<leader>th", function()
        local builtin = require("telescope.builtin")
        local themes = {
          "onedark",
          "tokyonight",
          "tokyonight-night",
          "tokyonight-storm",
          "tokyonight-day",
          "gruvbox",
          "dracula",
          "catppuccin",
          "catppuccin-mocha",
          "catppuccin-latte",
          "catppuccin-frappe",
          "catppuccin-macchiato",
        }
        
        builtin.colorscheme({
          prompt_title = "Theme Switcher (Minimal)",
          enable_preview = true,
        })
      end, { desc = "Theme Switcher" })
      
      keymap.set("n", "<leader>tt", function()
        local builtin = require("telescope.builtin")
        builtin.colorscheme({
          prompt_title = "Theme Switcher (Minimal)",
          enable_preview = true,
        })
      end, { desc = "Theme Switcher" })
    end,
  },

  -- ============================================================================
  -- GIT INTEGRATION - Essential for version control
  -- ============================================================================
  
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          
          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Next Hunk" })
          
          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Previous Hunk" })
          
          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
          map("v", "<leader>hs", function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Stage Hunk" })
          map("v", "<leader>hr", function() gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Reset Hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
          map("n", "<leader>hb", function() gs.blame_line({full=true}) end, { desc = "Blame Line" })
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Blame" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
          map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff This ~" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })
        end,
      })
    end,
  },

  -- ============================================================================
  -- WHICH-KEY - Essential for keybinding discovery
  -- ============================================================================
  
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        window = {
          border = "rounded",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 2, 2, 2, 2 },
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
      })
      
      -- Register key groups for better organization
      wk.register({
        ["<leader>f"] = { name = "find/telescope", icon = "🔍" },
        ["<leader>b"] = { name = "buffer", icon = "📄" },
        ["<leader>t"] = { name = "toggle/theme", icon = "🎨" },
        ["<leader>h"] = { name = "git hunk", icon = "🔀" },
      })
    end,
  },

  -- ============================================================================
  -- LATEX SUPPORT (optional, can be useful for document editing)
  -- ============================================================================
  
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
    end,
  },
}
