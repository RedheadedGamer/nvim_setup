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
    lazy = false, -- Load immediately for availability
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
    lazy = false, -- Load immediately for availability
    priority = 998,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
    end,
  },
  
  {
    "Mofiqul/dracula.nvim",
    lazy = false, -- Load immediately for availability
    priority = 997,
    config = function()
      require("dracula").setup({
        transparent_bg = true,
        show_end_of_buffer = false,
      })
    end,
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
    lazy = false, -- Load immediately for availability
    priority = 996,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          telescope = true,
          nvimtree = true,
          which_key = true,
        },
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

  -- Additional popular themes
  {
    "sainnhe/sonokai",
    lazy = true,
    config = function()
      vim.g.sonokai_style = "default"
      vim.g.sonokai_transparent_background = 1
    end,
  },

  {
    "sainnhe/edge",
    lazy = true,
    config = function()
      vim.g.edge_style = "default"
      vim.g.edge_transparent_background = 1
    end,
  },

  {
    "sainnhe/everforest",
    lazy = false, -- Load immediately for theme switcher availability
    priority = 976, -- Set priority for immediate loading
    config = function()
      vim.g.everforest_background = "medium"
      vim.g.everforest_transparent_background = 1
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_disable_italic_comment = 0
    end,
  },

  {
    "sainnhe/gruvbox-material",
    lazy = true,
    config = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_transparent_background = 1
    end,
  },

  {
    "marko-cerovac/material.nvim",
    lazy = true,
    config = function()
      require("material").setup({
        contrast = {
          terminal = false,
          sidebars = false,
          floating_windows = false,
          cursor_line = false,
          non_current_windows = false,
          filetypes = {},
        },
        styles = {
          comments = { italic = true },
          strings = { italic = false },
          keywords = { italic = false },
          functions = { italic = false },
          variables = {},
          operators = {},
          types = {},
        },
        plugins = {
          "telescope",
          "nvim-cmp",
          "nvim-web-devicons",
          "mini",
        },
        disable = {
          colored_cursor = false,
          borders = false,
          background = true, -- Enable transparency
          term_colors = false,
          eob_lines = false,
        },
      })
    end,
  },

  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    config = function()
      require("vscode").setup({
        transparent = true,
        italic_comments = true,
        disable_nvimtree_bg = true,
      })
    end,
  },

  {
    "projekt0n/github-nvim-theme",
    lazy = true,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
        }
      })
    end,
  },

  {
    "lunarvim/darkplus.nvim",
    lazy = true,
  },

  {
    "ray-x/aurora",
    lazy = true,
  },

  -- ============================================================================ 
  -- ADDITIONAL PREMIUM THEMES (20+ new high-quality themes)
  -- ============================================================================

  -- Monokai Pro family - Professional themes
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false, -- Load immediately for theme switcher
    priority = 995,
    config = function()
      require("monokai-pro").setup({
        transparent_background = true,
        filter = "pro", -- pro, classic, machine, octagon, ristretto, spectrum
      })
    end,
  },

  -- Solarized - Classic and beloved
  {
    "maxmx03/solarized.nvim",
    lazy = false, -- Load immediately for theme switcher
    priority = 994,
    config = function()
      require("solarized").setup({
        transparent = {
          enabled = true,
          pmenu = true,
          normal = true,
          normalfloat = true,
          neotree = true,
          nvimtree = true,
          whichkey = true,
          telescope = true,
          lazy = true,
        },
        palette = "solarized", -- solarized, selenized
        styles = {
          comments = { italic = true },
          functions = { italic = false },
          variables = { italic = false },
        },
        highlights = {},
        colors = {},
        theme = "neo", -- or "default"
      })
    end,
  },

  -- Ayu - Elegant minimal themes
  {
    "Shatur/neovim-ayu",
    lazy = false, -- Load immediately for theme switcher
    priority = 993,
    config = function()
      require("ayu").setup({
        mirage = true,
        terminal = false,
        overrides = {},
      })
    end,
  },

  -- Oceanic Next - Beautiful blue theme
  {
    "mhartington/oceanic-next",
    lazy = false, -- Load immediately for theme switcher
    priority = 992,
  },

  -- Palenight - Material inspired
  {
    "drewtempelmeyer/palenight.vim",
    lazy = false, -- Load immediately for theme switcher
    priority = 991,
  },

  -- Gruvbox Baby - Modern Gruvbox
  {
    "luisiacc/gruvbox-baby",
    lazy = false, -- Load immediately for theme switcher
    priority = 990,
    config = function()
      vim.g.gruvbox_baby_transparent_mode = 1
      vim.g.gruvbox_baby_function_style = "NONE"
      vim.g.gruvbox_baby_keyword_style = "italic"
    end,
  },

  -- Tender - Gentle purple theme
  {
    "jacoborus/tender.vim",
    lazy = false, -- Load immediately for theme switcher
    priority = 989,
  },

  -- Spaceduck - Retro space theme
  {
    "pineapplegiant/spaceduck",
    lazy = false, -- Load immediately for theme switcher
    priority = 988,
  },

  -- Deep Space - Cosmic dark theme
  {
    "tyrannicaltoucan/vim-deep-space",
    lazy = false, -- Load immediately for theme switcher
    priority = 987,
  },

  -- Moonfly - Dark blue theme
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false, -- Load immediately for theme switcher
    priority = 986,
  },

  -- Nightowl - Dark theme for night owls
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false, -- Load immediately for theme switcher
    priority = 985,
  },

  -- Zephyr - Modern dark theme
  {
    "glepnir/zephyr-nvim",
    lazy = false, -- Load immediately for theme switcher
    priority = 984,
  },

  -- Onedark Vivid - Enhanced OneDark
  {
    "navarasu/onedark.nvim",
    name = "onedark-nvim", -- Avoid name conflict
    lazy = false, -- Load immediately for theme switcher
    priority = 983,
    config = function()
      require("onedark").setup({
        style = "vivid", -- dark, darker, cool, deep, warm, warmer, vivid
        transparent = true,
        code_style = {
          comments = "italic",
          keywords = "bold",
          functions = "bold",
          strings = "italic",
          variables = "NONE"
        },
      })
    end,
  },

  -- Oxocarbon - Modern IBM inspired
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false, -- Load immediately for theme switcher
    priority = 982,
  },

  -- Melange - Warm color palette
  {
    "savq/melange-nvim",
    lazy = false, -- Load immediately for theme switcher
    priority = 981,
  },

  -- Flow - Minimal and clean
  {
    "0xstepit/flow.nvim",
    lazy = false, -- Load immediately for theme switcher
    priority = 980,
    config = function()
      require("flow").setup({
        transparent = true,
        fluo_color = "pink",
        mode = "normal",
        aggressive_spell = false,
      })
    end,
  },

  -- Cyberdream - Futuristic theme
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false, -- Load immediately for theme switcher
    priority = 979,
    config = function()
      require("cyberdream").setup({
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
      })
    end,
  },

  -- Vesper - Dark purple theme
  {
    "datsfilipe/vesper.nvim",
    lazy = false, -- Load immediately for theme switcher
    priority = 978,
  },

  -- Bamboo - Natural green theme
  {
    "ribru17/bamboo.nvim",
    lazy = false, -- Load immediately for theme switcher
    priority = 977,
    config = function()
      require("bamboo").setup({
        transparent = true,
        style = "vulgaris", -- vulgaris, multiplex
      })
    end,
  },

  -- Flexoki - Modern neutral theme
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    lazy = false, -- Load immediately for theme switcher
    priority = 975,
  },

  -- Lackluster - Deliberately muted
  {
    "slugbyte/lackluster.nvim",
    lazy = false, -- Load immediately for theme switcher
    priority = 974,
  },

  -- ============================================================================
  -- ADDITIONAL COOL THEMES (20+ more popular and modern themes)
  -- ============================================================================

  -- Fluoromachine - Modern neon themes
  {
    "maxmx03/fluoromachine.nvim",
    lazy = false,
    priority = 973,
    config = function()
      require("fluoromachine").setup({
        glow = false,
        brightness = 0.05,
        transparent = true,
      })
    end,
  },

  -- Lualine themes for variety
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Nightfox family - More fox themes
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox-extended",
    lazy = false,
    priority = 972,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          terminal_colors = true,
          inverse = {
            match_paren = false,
            visual = false,
            search = false,
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })
    end,
  },

  -- Doom themes family
  {
    "NTBBloodbath/doom-one.nvim",
    lazy = false,
    priority = 971,
    config = function()
      vim.g.doom_one_cursor_coloring = false
      vim.g.doom_one_terminal_colors = true
      vim.g.doom_one_italic_comments = true
      vim.g.doom_one_enable_treesitter = true
      vim.g.doom_one_diagnostics_text_color = false
      vim.g.doom_one_transparent_background = true
    end,
  },

  -- Tokyo Night variants
  {
    "folke/tokyonight.nvim",
    name = "tokyonight-extended",
    lazy = false,
    priority = 970,
    config = function()
      require("tokyonight").setup({
        style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day",
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "transparent",
          floats = "transparent",
        },
        sidebars = { "qf", "help" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
      })
    end,
  },

  -- PaperColor theme
  {
    "NLKNguyen/papercolor-theme",
    lazy = false,
    priority = 969,
  },

  -- Codedark theme (VS Code inspired)
  {
    "tomasiser/vim-code-dark",
    lazy = false,
    priority = 968,
  },

  -- One themes
  {
    "rakr/vim-one",
    lazy = false,
    priority = 967,
  },

  -- Apprentice-inspired theme (replacement for problematic romainl/Apprentice)
  {
    "adisen99/apprentice.nvim",
    lazy = false,
    priority = 966,
    config = function()
      require("apprentice").setup({
        style = "dark", -- "dark" or "light"
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
          functions = { italic = false },
          variables = { italic = false },
        },
      })
    end,
  },

  -- Zenburn theme
  {
    "jnurmine/Zenburn",
    lazy = false,
    priority = 965,
  },

  -- Base16 alternatives - Arctic themes
  {
    "rockerBOO/boo-colorscheme-nvim",
    lazy = false,
    priority = 964,
  },

  -- Rigel theme
  {
    "Rigellute/rigel",
    lazy = false,
    priority = 963,
  },

  -- Blue Moon theme
  {
    "kyazdani42/blue-moon",
    lazy = false,
    priority = 962,
  },

  -- Horizon theme
  {
    "akinsho/horizon.nvim",
    lazy = false,
    priority = 961,
    config = function()
      vim.g.horizon_italic_comments = true
      vim.g.horizon_italic_keywords = true
      vim.g.horizon_italic_functions = false
      vim.g.horizon_italic_variables = false
      vim.g.horizon_contrast = true
      vim.g.horizon_borders = false
      vim.g.horizon_disable_background = true
    end,
  },

  -- Embark theme
  {
    "embark-theme/vim",
    name = "embark",
    lazy = false,
    priority = 960,
  },

  -- Forest Night theme
  {
    "sainnhe/forest-night",
    lazy = false,
    priority = 959,
    config = function()
      vim.g.forest_night_style = "default"
      vim.g.forest_night_enable_italic = 1
      vim.g.forest_night_disable_italic_comment = 0
      vim.g.forest_night_transparent_background = 1
    end,
  },

  -- Iceberg theme
  {
    "cocopon/iceberg.vim",
    lazy = false,
    priority = 958,
  },

  -- Challenger Deep theme
  {
    "challenger-deep-theme/vim",
    name = "challenger-deep",
    lazy = false,
    priority = 957,
  },

  -- Jellybeans theme
  {
    "nanotech/jellybeans.vim",
    lazy = false,
    priority = 956,
  },

  -- Srcery theme
  {
    "srcery-colors/srcery-vim",
    lazy = false,
    priority = 955,
  },

  -- PaperColor improved
  {
    "NLKNguyen/papercolor-theme",
    name = "papercolor-improved",
    lazy = false,
    priority = 954,
  },

  -- Miramare theme
  {
    "franbach/miramare",
    lazy = false,
    priority = 953,
  },

  -- Artify theme
  {
    "RRethy/vim-illuminate", -- This includes some nice themes
    lazy = false,
    priority = 952,
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
      require("mini.pairs").setup({
        -- In which modes mappings from this `config` should be created
        modes = { insert = true, command = false, terminal = false },
        
        -- Global mappings. Each right hand side should be a pair information, a
        -- table with at least these fields (see more in help):
        -- - <action> - one of 'open', 'close', 'closeopen'.
        -- - <pair> - two character string for pair to be used.
        -- By default pair is not inserted after `\`, quotes are not recognized by
        -- `<CR>`, `'` does not insert pair after a letter.
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

  -- Rainbow brackets for better bracket visibility
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow", 
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        blacklist = {}, -- No blacklisted filetypes
      }
      
      -- Set up enhanced highlight colors for better visibility
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("RainbowDelimitersHighlight", { clear = true }),
        callback = function()
          vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75", bold = true })
          vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B", bold = true })
          vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF", bold = true })
          vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66", bold = true })
          vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379", bold = true })
          vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD", bold = true })
          vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2", bold = true })
        end,
      })
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
          backend = { "telescope", "builtin", "fzf_lua", "nui" },
          trim_prompt = true,
          telescope = require("telescope.themes").get_dropdown({
            winblend = 10,
            layout_config = {
              width = 0.8,
              height = 0.8, -- Reduced from 0.9 to prevent UI splitting
              prompt_position = "top", -- Ensure prompt is at top
            },
            sorting_strategy = "ascending", -- Keep items in order
          }),
          -- Enhanced builtin config for better theme switcher experience
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
            max_height = 0.8, -- Reduced from 0.9 to prevent UI splitting
            min_height = { 10, 0.2 },
            mappings = {
              ["<Esc>"] = "Close",
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
            },
          },
          -- Use telescope for theme selection to handle large lists with proper scrolling
          get_config = function(opts)
            if opts.prompt and (opts.prompt:match("theme") or opts.prompt:match("🎨")) then
              return {
                backend = "telescope",
                telescope = require("telescope.themes").get_dropdown({
                  winblend = 10,
                  layout_config = {
                    width = 0.7,
                    height = 0.75, -- Reduced height to prevent splitting
                    preview_cutoff = 120,
                    prompt_position = "top", -- Force prompt at top
                  },
                  -- Enable scrolling and navigation
                  scroll_strategy = "limit",
                  sorting_strategy = "ascending", -- Keep themes in alphabetical order
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

  -- Fancy notification manager
  {
    "rcarriga/nvim-notify",
    config = function()
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
      
      -- Enhanced theme switcher with preview showing current theme name
      local function theme_switcher()
        local theme_config = require("config.theme")
        
        -- Get current theme more reliably
        local function get_current_theme()
          return _G.nvim_current_theme or vim.g.current_theme or vim.g.colors_name or ""
        end
        
        local original_theme = get_current_theme()
        
        -- Use telescope's built-in colorscheme picker with enhanced feedback
        require("telescope.builtin").colorscheme({
          enable_preview = true,
          prompt_title = string.format("🎨 Theme Switcher (Original: %s) - Use ↑↓ to preview, Enter to apply, ESC to cancel", original_theme),
          layout_config = {
            width = 0.8,
            height = 0.7,
            prompt_position = "top",
          },
          attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            local state = require("telescope.actions.state")
            
            -- Track notification for replacement
            local preview_notification_id = nil
            
            -- Show current selection in the prompt
            local function update_prompt()
              local selection = state.get_selected_entry()
              if selection then
                local current_theme = selection.value
                -- Show notification with current preview theme - use unique title for replacement
                local notification_opts = {
                  timeout = 1500,
                  title = "Theme Preview",
                }
                
                -- If we have a previous notification, try to replace it with error handling
                if preview_notification_id then
                  -- Use pcall to safely attempt notification replacement
                  local ok, result = pcall(function()
                    notification_opts.replace = preview_notification_id
                    return vim.notify(string.format("📋 Previewing: %s", current_theme), vim.log.levels.INFO, notification_opts)
                  end)
                  
                  if ok then
                    preview_notification_id = result
                  else
                    -- If replacement fails (notification expired), create new notification
                    notification_opts.replace = nil
                    preview_notification_id = vim.notify(string.format("📋 Previewing: %s", current_theme), vim.log.levels.INFO, notification_opts)
                  end
                else
                  preview_notification_id = vim.notify(string.format("📋 Previewing: %s", current_theme), vim.log.levels.INFO, notification_opts)
                end
              end
            end
            
            -- Update on cursor movement
            map("i", "<Down>", function()
              actions.move_selection_next(prompt_bufnr)
              vim.defer_fn(update_prompt, 100)
            end)
            
            map("i", "<Up>", function()
              actions.move_selection_previous(prompt_bufnr)
              vim.defer_fn(update_prompt, 100)
            end)
            
            map("n", "j", function()
              actions.move_selection_next(prompt_bufnr)
              vim.defer_fn(update_prompt, 100)
            end)
            
            map("n", "k", function()
              actions.move_selection_previous(prompt_bufnr)
              vim.defer_fn(update_prompt, 100)
            end)
            
            -- Save theme on selection
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
            
            -- Restore original theme on cancel
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
        })
      end
      
      -- Theme switcher keymaps
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
      -- Mason setup
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })
      
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright", 
          "ts_ls",
          "html",
          "cssls",
          "jsonls",
          "clangd",     -- C/C++ LSP
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
        
        -- Enhanced hover documentation with duplicate prevention
        keymap.set("n", "K", function()
          -- Track active hover window globally to prevent duplicates
          if vim.g.active_hover_win and vim.api.nvim_win_is_valid(vim.g.active_hover_win) then
            vim.api.nvim_win_close(vim.g.active_hover_win, false)
            vim.g.active_hover_win = nil
          end
          
          -- Create custom hover handler to track window
          local original_handler = vim.lsp.handlers["textDocument/hover"]
          vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(function(err, result, ctx, config)
            local bufnr, winnr = original_handler(err, result, ctx, config)
            if winnr and vim.api.nvim_win_is_valid(winnr) then
              vim.g.active_hover_win = winnr
            end
            return bufnr, winnr
          end, {
            border = "rounded",
            max_width = 120,
            max_height = 30,
          })
          
          -- Request hover information
          vim.lsp.buf.hover()
        end, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
        
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
        clangd = {
          cmd = { "clangd", "--background-index" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
        },
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
              vim.cmd.normal(']c')
            else
              gitsigns.nav_hunk('next')
            end
          end, { desc = "Next git hunk" })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal('[c')
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
