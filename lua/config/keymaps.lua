-- config/keymaps.lua
-- Modern key mappings for Neovim

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

-- Toggle line numbers and relative numbers
keymap.set("n", "<leader>tn", function()
  vim.opt.number = not vim.opt.number:get()
end, { desc = "Toggle line numbers" })

keymap.set("n", "<leader>tr", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative numbers" })

-- Navigation (Snacks Picker with Telescope fallback)
local function picker(name)
  return function()
    local ok_snacks, snacks = pcall(require, "snacks")
    if (_G.Snacks and _G.Snacks.picker) or (ok_snacks and snacks.picker) then
      local p = (_G.Snacks and _G.Snacks.picker) or snacks.picker
      p[name]()
    else
      -- Fallback to Telescope if available
      local ok, builtin = pcall(require, "telescope.builtin")
      if ok then
        local telescope_map = {
          files = "find_files",
          grep = "live_grep",
          recent = "oldfiles",
          buffers = "buffers",
          help = "help_tags",
          diagnostics = "diagnostics",
          lsp_symbols = "lsp_document_symbols",
          lsp_workspace_symbols = "lsp_workspace_symbols",
          grep_word = "grep_string",
          qflist = "quickfix",
          colorschemes = "colorscheme",
        }
        local builtin_name = telescope_map[name]
        if builtin_name and builtin[builtin_name] then
          builtin[builtin_name]()
        else
          vim.notify("Telescope mapping not found for: " .. name, vim.log.levels.WARN)
        end
      else
        -- Fallback to mini.pick if available
        local ok_pick, pick = pcall(require, "mini.pick")
        if ok_pick then
          local pick_map = {
            files = "files",
            grep = "grep_live",
            buffers = "buffers",
            help = "help",
          }
          local pick_name = pick_map[name]
          if pick_name and pick.builtin[pick_name] then
            pick.builtin[pick_name]()
          else
            vim.notify("Mini.pick mapping not found for: " .. name, vim.log.levels.WARN)
          end
        else
          vim.notify("No picker (Snacks, Telescope, or Mini.pick) available", vim.log.levels.WARN)
        end
      end
    end
  end
end

-- Primary Navigation
keymap.set("n", "<leader>ff", picker("files"), { desc = "Find Files" })
keymap.set("n", "<leader>fg", picker("grep"), { desc = "Grep" })
keymap.set("n", "<leader>fr", picker("recent"), { desc = "Recent Files" })
keymap.set("n", "<leader>fb", picker("buffers"), { desc = "Buffers" })
keymap.set("n", "<leader>fh", picker("help"), { desc = "Help" })
keymap.set("n", "<leader>fd", picker("diagnostics"), { desc = "Diagnostics" })
keymap.set("n", "<leader>fs", picker("lsp_symbols"), { desc = "Document Symbols" })
keymap.set("n", "<leader>fS", picker("lsp_workspace_symbols"), { desc = "Workspace Symbols" })
keymap.set("n", "<leader>fw", picker("grep_word"), { desc = "Grep Word" })
keymap.set("n", "<leader>fq", picker("qflist"), { desc = "Quickfix" })

-- Mini.pick alternatives (Consolidated to use Snacks Picker if available)
keymap.set("n", "<leader>pf", picker("files"), { desc = "Pick files" })
keymap.set("n", "<leader>pg", picker("grep"), { desc = "Pick grep live" })
keymap.set("n", "<leader>pb", picker("buffers"), { desc = "Pick buffers" })
keymap.set("n", "<leader>ph", picker("help"), { desc = "Pick help" })

-- Theme/Colorscheme picker
keymap.set("n", "<leader>tC", picker("colorschemes"), { desc = "Colorschemes" })

-- Buffer navigation improvements
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
keymap.set("n", "<leader>bD", "<cmd>%bdelete|edit#|bdelete#<cr>", { desc = "Delete all buffers except current" })

-- Quick save/quit shortcuts
keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Quick save" })
keymap.set("i", "<C-s>", "<Esc><cmd>w<cr>", { desc = "Quick save from insert mode" })

-- Better line movement in insert mode
keymap.set("i", "<C-h>", "<Left>", { desc = "Move left in insert mode" })
keymap.set("i", "<C-l>", "<Right>", { desc = "Move right in insert mode" })
keymap.set("i", "<C-j>", "<Down>", { desc = "Move down in insert mode" })
keymap.set("i", "<C-k>", "<Up>", { desc = "Move up in insert mode" })

-- Quick line duplication
keymap.set("n", "<leader>ld", "yyp", { desc = "Duplicate line" })
keymap.set("v", "<leader>ld", "y`>p", { desc = "Duplicate selection" })

-- Center screen after search
keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Improved undo break points
keymap.set("i", ",", ",<c-g>u", { desc = "Better undo break point" })
keymap.set("i", ".", ".<c-g>u", { desc = "Better undo break point" })
keymap.set("i", "!", "!<c-g>u", { desc = "Better undo break point" })
keymap.set("i", "?", "?<c-g>u", { desc = "Better undo break point" })

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
keymap.set("n", "<leader>nt", "<cmd>tabnew<cr>", { desc = "New tab" })
keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })

-- Quick navigation
keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<cr>", { desc = "Change to file directory" })
keymap.set("n", "<leader>pwd", "<cmd>pwd<cr>", { desc = "Print working directory" })

-- Search and replace helpers
keymap.set("n", "<leader>sr", ":%s//g<Left><Left>", { desc = "Search and replace" })
keymap.set("v", "<leader>sr", ":s//g<Left><Left>", { desc = "Search and replace selection" })

-- Quick save and source config
keymap.set("n", "<leader><leader>", "<cmd>source %<cr>", { desc = "Source current file" })
keymap.set("n", "<leader>so", "<cmd>source $MYVIMRC<cr>", { desc = "Source config" })

-- Open config files quickly
keymap.set("n", "<leader>cc", "<cmd>e ~/.config/nvim/init.lua<cr>", { desc = "Edit config" })
keymap.set("n", "<leader>cp", "<cmd>e ~/.config/nvim/lua/plugins/init.lua<cr>", { desc = "Edit plugins" })
keymap.set("n", "<leader>ck", "<cmd>e ~/.config/nvim/lua/config/keymaps.lua<cr>", { desc = "Edit keymaps" })

-- Terminal shortcuts
keymap.set("n", "<leader>te", "<cmd>terminal<cr>", { desc = "Open terminal" })
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Clipboard operations  
keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap.set("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

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

-- Enhanced bracket matching test
keymap.set("n", "<leader>tb", function()
  vim.cmd("NoMatchParen")
  vim.defer_fn(function()
    vim.cmd("DoMatchParen")
    vim.notify("Bracket matching reloaded with enhanced highlighting", vim.log.levels.INFO)
  end, 100)
end, { desc = "Reload bracket matching" })

-- Create a test buffer with brackets to demonstrate matching
keymap.set("n", "<leader>tB", function()
  -- Create a new buffer with bracket examples
  vim.cmd("enew")
  local examples = {
    "-- Bracket matching examples:",
    "if condition then",
    "  local table = {",
    "    key = 'value',",
    "    nested = {",
    "      array = [1, 2, 3],",
    "      func = function(a, b)",
    "        return (a + b) * 2",
    "      end",
    "    }",
    "  }",
    "end",
    "",
    "-- Move cursor to any bracket to see matching pairs highlighted",
    "-- Rainbow delimiters show nested levels in different colors",
  }
  vim.api.nvim_buf_set_lines(0, 0, -1, false, examples)
  vim.opt_local.filetype = "lua"
  vim.notify("Bracket test buffer created! Move cursor to brackets to see highlighting", vim.log.levels.INFO)
end, { desc = "Create bracket matching test buffer" })