-- plugins/ui/themes.lua
-- Theme plugins configuration

return {
  -- ============================================================================
  -- THEMES
  -- ============================================================================
  
  -- Primary colorscheme (default)
  {
    "olimorris/onedarkpro.nvim",
    lazy = false, -- PERFORMANCE: Keep default theme eager for immediate UI
    priority = 1000,
    config = function()
      -- ERROR HANDLING: Protect theme loading
      local ok, onedarkpro = pcall(require, "onedarkpro")
      if not ok then
        vim.notify("Failed to load onedarkpro theme: " .. tostring(onedarkpro), vim.log.levels.ERROR)
        return
      end
      onedarkpro.setup({
        options = {
          transparency = true,
        }
      })
    end,
  },
  
  -- Popular theme collection (optimized for transparency)
  {
    "folke/tokyonight.nvim",
    lazy = true, -- PERFORMANCE: Lazy load themes not actively used
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
    lazy = true, -- PERFORMANCE: Lazy load themes not actively used
    config = function()
      require("gruvbox").setup({
        transparent_mode = true,
      })
    end,
  },
  
  {
    "Mofiqul/dracula.nvim",
    lazy = true, -- PERFORMANCE: Lazy load themes not actively used
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
    lazy = true, -- PERFORMANCE: Lazy load themes not actively used
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
    lazy = true, -- PERFORMANCE: Lazy load themes not actively used
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
    "projekt0n/github-nvim-theme",
    lazy = true, -- PERFORMANCE: Lazy load themes not actively used
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          terminal_colors = true,
          dim_inactive = false,
          styles = {
            comments = "italic",
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = {
            match_paren = false,
            visual = false,
            search = false,
          },
        },
        palettes = {},
        specs = {},
        groups = {
          -- Enhanced transparency support
          all = {
            Normal = { bg = "NONE" },
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE" },
            Pmenu = { bg = "NONE" },
            PmenuSel = { bg = "NONE" },
            TelescopeNormal = { bg = "NONE" },
            TelescopeBorder = { bg = "NONE" },
            TelescopePromptNormal = { bg = "NONE" },
            TelescopeResultsNormal = { bg = "NONE" },
            TelescopePreviewNormal = { bg = "NONE" },
          },
        },
      })
    end,
  },
}
