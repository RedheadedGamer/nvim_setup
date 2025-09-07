-- config/autocmds.lua
-- Autocommands converted from init.vim

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Create augroups
local general = augroup("General", { clear = true })
local wistl_filetype = augroup("WistlFiletype", { clear = true })

-- Auto-generate ctags if not present
autocmd("VimEnter", {
  group = general,
  callback = function()
    if vim.fn.filereadable("tags") == 0 then
      vim.fn.system("ctags -R .")
    end
  end,
})

-- Filetype detection and settings for .wistl files (converted to Lua)
autocmd({ "BufReadPost", "BufNewFile" }, {
  group = wistl_filetype,
  pattern = "*.wistl",
  callback = function()
    vim.bo.filetype = "wistl"
  end,
})

autocmd("FileType", {
  group = wistl_filetype,
  pattern = "wistl",
  callback = function()
    vim.bo.autoindent = true
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.tabstop = 4
    vim.bo.textwidth = 80
  end,
})

-- Consolidated transparency configuration
local function apply_transparency()
  local transparent_groups = {
    -- Core UI elements
    "Normal",
    "NormalNC", 
    "NormalFloat",
    "EndOfBuffer",
    "SignColumn",
    "LineNr",
    "CursorLineNr",
    "StatusLine",
    "StatusLineNC",
    "WinBar",
    "WinBarNC",
    "VertSplit",
    "WinSeparator",
    "Folded",
    "FoldColumn",
    "ColorColumn",
    
    -- Popup menus and floating windows
    "Pmenu",
    "PmenuSel",
    "PmenuSbar", 
    "PmenuThumb",
    "FloatBorder",
    
    -- Tabline
    "TabLine",
    "TabLineSel",
    "TabLineFill",
    
    -- Lazy.nvim
    "LazyNormal",
    "LazyReasonPlugin",
    "LazyReasonRuntime", 
    "LazyReasonSource",
    "LazyH1",
    "LazyH2",
    "LazyButton",
    "LazyButtonActive",
    "LazyProgressTodo",
    "LazyProgressDone",
    "LazyCommit",
    "LazyCommitIssue",
    "LazyCommitType",
    "LazyCommitScope",
    
    -- Telescope
    "TelescopeNormal",
    "TelescopeBorder",
    "TelescopePromptBorder",
    "TelescopeResultsBorder",
    "TelescopePreviewBorder",
    "TelescopePromptNormal",
    "TelescopeResultsNormal",
    "TelescopePreviewNormal",
    "TelescopeSelection",
    "TelescopeMultiSelection",
    
    -- Which-key
    "WhichKeyFloat",
    "WhichKeyBorder",
    "WhichKeyGroup",
    "WhichKeyDesc",
    "WhichKeySeperator",
    "WhichKey",
    "WhichKeyValue",
    "WhichKeyIcon",
    "WhichKeyTitle",
    
    -- Mini.nvim
    "MiniStarterHeader",
    "MiniStarterSection", 
    "MiniStarterItem",
    "MiniStarterQuery",
    "MiniStarterCurrent",
    "MiniStarterInactive",
    "MiniFilesNormal",
    "MiniFilesBorder",
    "MiniPickNormal",
    "MiniPickBorder",
    "MiniPickPrompt",
    "MiniNotifyNormal",
    "MiniNotifyBorder",
    "MiniMapNormal",
    "MiniMapSymbolCount",
    "MiniMapSymbolLine",
    "MiniMapSymbolView",
    
    -- LSP and completion
    "LspFloatWinNormal",
    "LspFloatWinBorder",
    "DiagnosticFloatingWarn",
    "DiagnosticFloatingError", 
    "DiagnosticFloatingInfo",
    "DiagnosticFloatingHint",
    "CmpNormal",
    "CmpBorder",
    "CmpDocumentation", 
    "CmpDocumentationBorder",
    
    -- Additional plugins
    "TroubleNormal",
    "TroubleBorder",
    "TroubleText",
    "TroubleCount",
    "TroubleCode",
    "MasonNormal",
    "MasonBorder",
    "MasonHeader",
    "MasonHighlight",
    "NoiceNormal",
    "NoiceBorder", 
    "NotifyBackground",
    "NotifyBorder",
    "DressingInput",
    "DressingSelect",
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "BufferLineBackground",
    "BufferLineFill",
    
    -- Mini.statusline transparency
    "MiniStatuslineDevinfo",
    "MiniStatuslineFileinfo", 
    "MiniStatuslineFilename",
    "MiniStatuslineInactive",
    "MiniStatuslineModeCommand",
    "MiniStatuslineModeInsert",
    "MiniStatuslineModeNormal",
    "MiniStatuslineModeOther",
    "MiniStatuslineModeReplace",
    "MiniStatuslineModeVisual",
    
    -- Telescope enhancement for theme switcher
    "TelescopeMatching",
    "TelescopeTitle",
    
    -- Dressing.nvim (theme switcher UI)
    "DressingBorder",
    "DressingTitle",
    
    -- Additional Which-key elements
    "WhichKeyNormal",
    
    -- Mini.starter transparency
    "MiniStarterCurrent",
    "MiniStarterFooter", 
    "MiniStarterHeader",
    "MiniStarterInactive",
    "MiniStarterItem",
    "MiniStarterItemBullet",
    "MiniStarterItemPrefix",
    "MiniStarterSection",
    "MiniStarterQuery",
  }
  
  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end
end

-- Apply transparency on startup
autocmd("VimEnter", {
  group = general,
  callback = apply_transparency,
})

-- Apply transparency after colorscheme changes  
autocmd("ColorScheme", {
  group = general,
  callback = apply_transparency,
})

-- Makefile project support - generate compile_commands.json
local makefile_group = augroup("MakefileSupport", { clear = true })

-- Create a command to generate compile_commands.json for Makefile projects
vim.api.nvim_create_user_command("MakeCompileCommands", function()
  local cwd = vim.fn.getcwd()
  
  -- Check if we're in a Makefile-based project
  if vim.fn.filereadable(cwd .. "/Makefile") == 1 then
    vim.notify("Generating compile_commands.json for Makefile project...", vim.log.levels.INFO)
    
    -- Use bear to generate compile_commands.json if available
    if vim.fn.executable("bear") == 1 then
      vim.fn.system("bear -- make clean && bear -- make")
      if vim.v.shell_error == 0 then
        vim.notify("compile_commands.json generated successfully!", vim.log.levels.INFO)
      else
        vim.notify("Failed to generate with bear. Install bear: pacman -S bear", vim.log.levels.WARN)
      end
    else
      -- Fallback: suggest manual creation
      vim.notify("Install 'bear' for automatic compile_commands.json generation: sudo pacman -S bear", vim.log.levels.WARN)
      vim.notify("Then run: bear -- make", vim.log.levels.INFO)
    end
  else
    vim.notify("No Makefile found in current directory", vim.log.levels.WARN)
  end
end, { desc = "Generate compile_commands.json for Makefile projects" })

-- Auto-detect Makefile projects and suggest generating compile_commands.json
autocmd("BufEnter", {
  group = makefile_group,
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = function()
    local cwd = vim.fn.getcwd()
    if vim.fn.filereadable(cwd .. "/Makefile") == 1 and vim.fn.filereadable(cwd .. "/compile_commands.json") == 0 then
      vim.defer_fn(function()
        vim.notify("Makefile project detected. Run :MakeCompileCommands to improve LSP support", vim.log.levels.INFO)
      end, 2000)
    end
  end,
})