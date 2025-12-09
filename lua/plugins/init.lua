-- plugins/init.lua (modular version)
-- Main plugin loader that imports all modular plugin configurations
--
-- Plugin Structure:
-- - ui/         : UI enhancements (themes, snacks, telescope, which-key, dressing)
-- - editor/     : Editor plugins (treesitter, mini.nvim ecosystem)
-- - lsp/        : LSP configuration (mason, lspconfig, nvim-cmp)
-- - git/        : Git integration (gitsigns, mini.diff)
-- - dev/        : Development tools (formatting, linting, debugging)
-- - lang/       : Language-specific plugins (C/C++, Java, LaTeX)

-- Load all plugin modules and flatten into a single table
local function load_plugin_modules()
  local plugins = {}
  
  -- Helper function to merge plugin tables
  local function merge(t)
    for _, plugin in ipairs(t) do
      table.insert(plugins, plugin)
    end
  end
  
  -- UI plugins
  merge(require("plugins.ui.themes"))
  merge(require("plugins.ui.snacks"))
  merge(require("plugins.ui.utilities"))
  
  -- Editor plugins
  merge(require("plugins.editor.treesitter"))
  merge(require("plugins.editor.mini-text"))
  merge(require("plugins.editor.mini-ui"))
  merge(require("plugins.editor.mini-navigation"))
  
  -- Git plugins
  merge(require("plugins.git.gitsigns"))
  
  -- LSP plugins
  merge(require("plugins.lsp.lspconfig"))
  
  -- Development tools
  merge(require("plugins.dev.formatting"))
  merge(require("plugins.dev.linting"))
  merge(require("plugins.dev.debugging"))
  
  -- Language-specific plugins
  merge(require("plugins.lang.c-cpp"))
  merge(require("plugins.lang.java"))
  merge(require("plugins.lang.latex"))
  
  return plugins
end

return load_plugin_modules()
