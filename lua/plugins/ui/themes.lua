-- plugins/ui/themes.lua
-- Theme plugins configuration

return {
  -- ============================================================================
  -- THEMES
  -- ============================================================================
  
  -- OneDark
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
  
  -- TokyoNight
  {
    "folke/tokyonight.nvim",
    lazy = true,
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
  
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
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
  
  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("kanagawa").setup({
        transparent = true,
      })
    end,
  },

  -- Sonokai
  {
    "sainnhe/sonokai",
    lazy = true,
    config = function()
      vim.g.sonokai_style = "default"
      vim.g.sonokai_transparent_background = 1
    end,
  },
}
