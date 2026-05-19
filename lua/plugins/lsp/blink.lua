-- plugins/lsp/blink.lua
-- Premium autocompletion configuration with blink.cmp

return {
  {
    "saghen/blink.cmp",
    lazy = false,
    -- Use stable tags for production readiness
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      -- Super-tab layout for natural autocomplete experience
      keymap = { 
        preset = "super-tab",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      
      completion = {
        -- Rounded completion menus and custom column drawings
        menu = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          draw = {
            columns = {
              { "kind_icon", gap = 1 },
              { "label", "label_description", gap = 1 },
            },
          },
        },
        
        -- Rounded documentation popup with accelerated show delays
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          window = {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
        },
        
        -- Inline ghost text
        ghost_text = { enabled = true },
      },
      
      -- Inline premium signature help and parameter guidelines
      signature = {
        enabled = true,
        trigger = {
          blocked_trigger_characters = {},
          show_on_insert_on_trigger_character = true,
        },
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
        },
      },
    },
  },
}
