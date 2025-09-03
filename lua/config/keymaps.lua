-- config/keymaps.lua
-- Key mappings converted from init.vim

local keymap = vim.keymap

-- Set leader key (if not already set)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Note: LSP-specific keymaps will be configured in plugins/lsp.lua
-- This file contains general editor keymaps

-- Example keymaps (add more as needed)
-- keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
-- keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Clear search highlighting
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize with arrows
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Additional useful keybinds
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap.set("n", "<leader>wq", "<cmd>wq<cr>", { desc = "Save and quit" })
keymap.set("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })

-- Better indenting
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Toggle line numbers and relative numbers
keymap.set("n", "<leader>tn", function()
  vim.opt.number = not vim.opt.number:get()
end, { desc = "Toggle line numbers" })

keymap.set("n", "<leader>tr", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative numbers" })

-- Split management
keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
keymap.set("n", "<leader>wh", "<cmd>split<cr>", { desc = "Horizontal split" })
keymap.set("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close window" })
keymap.set("n", "<leader>wo", "<cmd>only<cr>", { desc = "Close other windows" })

-- Buffer navigation
keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bl", "<cmd>blast<cr>", { desc = "Last buffer" })
keymap.set("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First buffer" })

-- Tab management  
keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })

-- Quick navigation
keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<cr>", { desc = "Change to file directory" })
keymap.set("n", "<leader>pwd", "<cmd>pwd<cr>", { desc = "Print working directory" })

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Stay in indent mode
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Keep cursor centered when scrolling
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Better paste behavior
keymap.set("v", "p", '"_dP', { desc = "Paste without overwriting register" })