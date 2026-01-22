-- config/options.lua
-- Modern editor settings for Neovim

local opt = vim.opt
local g = vim.g

-- Disable compatibility to old-time vi (not needed in Neovim, kept for clarity)
-- opt.compatible = false -- This is always false in Neovim

-- Display settings
opt.showmatch = true               -- show matching brackets
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
local backup_dir = vim.fn.expand("~/.cache/vim")
opt.backupdir = backup_dir        -- directory to store backup files
-- Create backup directory if it doesn't exist (just in case backup gets enabled)
if vim.fn.isdirectory(backup_dir) == 0 then
  vim.fn.mkdir(backup_dir, "p")
end

-- Performance and UX
opt.ttyfast = true                -- speed up scrolling in Vim
opt.updatetime = 300              -- faster updatetime for better UX
opt.spell = true                  -- enable spell check
opt.signcolumn = "yes"            -- always show signcolumn for diagnostics
opt.scrolloff = 8                 -- keep 8 lines visible when scrolling
opt.sidescrolloff = 8             -- keep 8 columns visible when scrolling horizontally
opt.cmdheight = 1                 -- command line height
opt.pumheight = 10                -- popup menu height
opt.conceallevel = 0              -- show concealed text
opt.fileencoding = "utf-8"        -- file encoding
opt.timeoutlen = 1000             -- time to wait for mapped sequence to complete
opt.ttimeoutlen = 0               -- time to wait for key code sequence to complete
opt.splitbelow = true             -- force horizontal splits below current window
opt.splitright = true             -- force vertical splits right of current window
opt.wrap = false                  -- disable line wrapping by default
opt.linebreak = true              -- break lines at word boundaries when wrap is enabled

-- Better completion
opt.completeopt = { "menu", "menuone", "noselect" } -- modern completion options
opt.shortmess:append("c")         -- avoid showing completion messages

-- Undo settings
opt.undofile = true               -- enable persistent undo
local undo_dir = vim.fn.expand("~/.cache/nvim/undo")
opt.undodir = undo_dir           -- undo directory
-- Create undo directory if it doesn't exist
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, "p")
end

-- Search improvements
opt.smartcase = true              -- smart case sensitivity (override ignorecase when uppercase present)

-- Folding improvements (better defaults)
opt.foldmethod = "expr"           -- use expression for folding
opt.foldexpr = "nvim_treesitter#foldexpr()" -- use treesitter for folding
opt.foldlevel = 99                -- open all folds by default
opt.foldlevelstart = 99           -- open all folds when opening files

-- Text formatting
opt.textwidth = 80                -- set text width to 80 characters
opt.formatoptions:append("t")     -- auto-wrap text using textwidth

-- Enable filetype detection (modern API)
vim.filetype.add({
  pattern = {
    [".*%.wistl"] = "wistl",
  },
})

-- Enhanced bracket matching with better visibility
vim.api.nvim_set_hl(0, "MatchParen", {
  bold = true,
  bg = "#FFD700",
  fg = "#000000",
})

-- Cursor shape configuration (modern terminal codes)
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Grep settings (if ripgrep is available)
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --hidden --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end