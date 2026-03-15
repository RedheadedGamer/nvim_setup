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
  
  -- Helper function to merge plugin tables with error handling
  local function merge(module_name)
    local ok, module = pcall(require, module_name)
    if not ok then
      vim.notify(
        string.format("Failed to load plugin module '%s': %s", module_name, tostring(module)),
        vim.log.levels.ERROR
      )
      return
    end
    
    if type(module) ~= "table" then
      vim.notify(
        string.format("Plugin module '%s' did not return a table", module_name),
        vim.log.levels.ERROR
      )
      return
    end
    
    for _, plugin in ipairs(module) do
      table.insert(plugins, plugin)
    end
  end
  
  -- UI plugins
  merge("plugins.ui.themes")
  merge("plugins.ui.snacks")
  merge("plugins.ui.utilities")
  
  -- Editor plugins
  merge("plugins.editor.treesitter")
  merge("plugins.editor.mini-text")
  merge("plugins.editor.mini-ui")
  merge("plugins.editor.mini-navigation")
  merge("plugins.editor.navigation")
  merge("plugins.editor.extras")
  
  -- Git plugins
  merge("plugins.git.gitsigns")
  merge("plugins.git.diffview")
  
  -- LSP plugins
  merge("plugins.lsp.lspconfig")
  
  -- Development tools
  merge("plugins.dev.formatting")
  merge("plugins.dev.linting")
  merge("plugins.dev.debugging")
  merge("plugins.dev.refactoring")
  
  -- Language-specific plugins
  merge("plugins.lang.c-cpp")
  merge("plugins.lang.java")
  merge("plugins.lang.latex")
  merge("plugins.lang.lua")
  merge("plugins.lang.markdown")
  
  return plugins
end

return load_plugin_modules()
