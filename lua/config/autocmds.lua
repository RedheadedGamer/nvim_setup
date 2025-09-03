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