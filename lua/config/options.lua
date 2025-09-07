-- config/options.lua
-- Editor settings converted from init.vim

local opt = vim.opt
local g = vim.g

-- Disable compatibility to old-time vi
opt.compatible = false

-- Display settings
opt.showmatch = true               -- show matching brackets
opt.matchtime = 5                  -- how long to show matching bracket (increased from 2 to 5 tenths of a second)
opt.showcmd = true                 -- show command in status line
opt.number = true                  -- add line numbers
opt.relativenumber = true          -- relative line numbers
opt.ruler = true                   -- show cursor position
opt.cc = "80"                      -- set an 80 column border for good coding style
opt.termguicolors = true          -- enable true color support
opt.statusline = "%l,%c"          -- show line and column in statusline

-- Search settings
opt.ignorecase = true             -- case insensitive search
opt.hlsearch = true               -- highlight search results
opt.incsearch = true              -- incremental search

-- Mouse and clipboard
opt.mouse = "a"                   -- enable mouse support (changed from 'v' to 'a' for better support)
opt.clipboard = "unnamedplus"     -- use system clipboard

-- Indentation settings
opt.smartindent = true            -- smart auto-indenting
opt.autoindent = true             -- indent a new line the same amount as the line just typed
opt.expandtab = false             -- use actual tabs instead of spaces (noexpandtab equivalent)
opt.tabstop = 4                   -- number of columns occupied by a tab
opt.softtabstop = 4               -- see multiple spaces as tabstops so <BS> does the right thing
opt.shiftwidth = 4                -- width for autoindents

-- File handling
opt.wildmode = { "longest", "list" } -- get bash-like tab completions
opt.encoding = "utf-8"            -- always use utf-8
opt.swapfile = false              -- disable creating swap file
opt.backup = false                -- avoid backup files
opt.writebackup = false           -- avoid backup files
opt.backupdir = vim.fn.expand("~/.cache/vim") -- directory to store backup files

-- Performance and UX
opt.ttyfast = true                -- speed up scrolling in Vim
opt.updatetime = 300              -- faster updatetime for better UX
opt.spell = true                  -- enable spell check
opt.signcolumn = "yes"            -- always show signcolumn for diagnostics

-- Text formatting
opt.textwidth = 80                -- set text width to 80 characters
opt.formatoptions:append("t")     -- auto-wrap text using textwidth

-- Enable filetype detection
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

-- Enhanced bracket matching with better visibility
vim.cmd("highlight MatchParen cterm=bold ctermbg=yellow ctermfg=black guibg=#FFD700 guifg=#000000 gui=bold")
vim.g.matchparen_timeout = 50      -- Increased timeout for better visibility
vim.g.matchparen_insert_timeout = 50

-- Cursor shape configuration
vim.cmd([[
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"  
  let &t_SR = "\e[2 q"
]])

-- Grep settings (if ripgrep is available)
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --hidden --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end