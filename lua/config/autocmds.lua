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

-- Transparent background highlight groups
autocmd("VimEnter", {
  group = general,
  callback = function()
    local transparent_groups = {
      "NonText",
      "Normal", 
      "NormalNC",
      "SignColumn",
      "Pmenu",
      "FloatBorder",
      "NormalFloat",
      "TabLine",
      "LineNr",
      "CursorLineNr",
      "StatusLine",
      "StatusLineNC",
      -- Additional groups for better transparency
      "EndOfBuffer",
      "VertSplit",
      "WinSeparator",
      -- Lazy.nvim transparency
      "LazyNormal",
      "LazyReasonPlugin", 
      "LazyReasonRuntime",
      "LazyReasonSource",
      "LazyH1",
      "LazyH2",
      -- Telescope transparency
      "TelescopeNormal",
      "TelescopeBorder",
      "TelescopePromptBorder",
      "TelescopeResultsBorder",
      "TelescopePreviewBorder",
      -- Which-key transparency
      "WhichKeyFloat",
      -- Mini.nvim transparency
      "MiniStarterHeader",
      "MiniStarterSection",
      "MiniStarterItem",
    }
    
    for _, group in ipairs(transparent_groups) do
      vim.cmd(string.format("hi %s ctermbg=NONE ctermfg=NONE guibg=NONE", group))
    end
  end,
})

-- Apply transparency after colorscheme changes
autocmd("ColorScheme", {
  group = general,
  callback = function()
    -- Ensure transparency persists across colorscheme changes
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "LazyNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "NONE" })
  end,
})