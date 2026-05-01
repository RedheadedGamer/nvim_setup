-- plugins/init.lua
-- Modern plugin loader using lazy.nvim's native import specs
--
-- Plugin Structure:
-- - ui/         : UI enhancements (themes, snacks, telescope, which-key, dressing)
-- - editor/     : Editor plugins (treesitter, mini.nvim ecosystem)
-- - lsp/        : LSP configuration (mason, lspconfig, blink.cmp)
-- - git/        : Git integration (gitsigns, mini.diff)
-- - dev/        : Development tools (formatting, linting, debugging)
-- - lang/       : Language-specific plugins (C/C++, Java, LaTeX)

return {
  -- UI plugins
  { import = "plugins.ui.themes" },
  { import = "plugins.ui.snacks" },
  { import = "plugins.ui.noice" },
  { import = "plugins.ui.todo-comments" },
  { import = "plugins.ui.utilities" },

  -- Editor plugins
  { import = "plugins.editor.treesitter" },
  { import = "plugins.editor.oil" },
  { import = "plugins.editor.persistence" },
  { import = "plugins.editor.mini-text" },
  { import = "plugins.editor.mini-ui" },
  { import = "plugins.editor.mini-navigation" },
  { import = "plugins.editor.navigation" },
  { import = "plugins.editor.extras" },

  -- Git plugins
  { import = "plugins.git.gitsigns" },
  { import = "plugins.git.diffview" },

  -- LSP plugins
  { import = "plugins.lsp.blink" },
  { import = "plugins.lsp.lspconfig" },

  -- Development tools
  { import = "plugins.dev.formatting" },
  { import = "plugins.dev.linting" },
  { import = "plugins.dev.debugging" },
  { import = "plugins.dev.refactoring" },

  -- Language-specific plugins
  { import = "plugins.lang.c-cpp" },
  { import = "plugins.lang.java" },
  { import = "plugins.lang.latex" },
  { import = "plugins.lang.lua" },
  { import = "plugins.lang.markdown" },
}
