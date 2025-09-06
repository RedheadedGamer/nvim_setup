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

-- ============================================================================
-- DEBUGGING KEYMAPS (GDB GEF & Valgrind Integration)
-- ============================================================================

-- Core debugging controls
keymap.set("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Continue" })
keymap.set("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
keymap.set("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Step Into" })
keymap.set("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Step Out" })
keymap.set("n", "<leader>b", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })

-- Advanced debugging features
keymap.set("n", "<leader>dM", function() require("config.debugging").memory_analysis() end, { desc = "Memory Analysis Tools" })
keymap.set("n", "<leader>dS", function() require("config.debugging").security_analysis() end, { desc = "Security Analysis" })
keymap.set("n", "<leader>dT", function() require("config.debugging").debug_templates() end, { desc = "Debug Templates" })
keymap.set("n", "<leader>dgc", function() require("config.debugging").gef_commands() end, { desc = "GEF Commands" })

-- Valgrind shortcuts
keymap.set("n", "<leader>dvm", function() require("config.debugging").run_valgrind("memcheck") end, { desc = "Valgrind Memcheck" })
keymap.set("n", "<leader>dvh", function() require("config.debugging").run_valgrind("helgrind") end, { desc = "Valgrind Helgrind" })
keymap.set("n", "<leader>dvd", function() require("config.debugging").run_valgrind("drd") end, { desc = "Valgrind DRD" })
keymap.set("n", "<leader>dvs", function() require("config.debugging").run_valgrind("massif") end, { desc = "Valgrind Massif" })
keymap.set("n", "<leader>dvo", function() require("config.debugging").run_valgrind("cachegrind") end, { desc = "Valgrind Cachegrind" })
keymap.set("n", "<leader>dvp", function() require("config.debugging").run_valgrind("callgrind") end, { desc = "Valgrind Callgrind" })

-- Quick debug session management
keymap.set("n", "<leader>dqs", function()
  local dap = require("dap")
  dap.close()
  require("dapui").close()
  vim.notify("🐛 Debug session terminated", vim.log.levels.INFO)
end, { desc = "Quick Stop Debug" })

keymap.set("n", "<leader>dqr", function()
  local dap = require("dap")
  dap.restart()
  vim.notify("🔄 Debug session restarted", vim.log.levels.INFO)
end, { desc = "Quick Restart Debug" })

-- Debugging information display
keymap.set("n", "<leader>dI", function()
  local debug_info = require("config.debugging").check_debug_tools()
  local info_lines = {"🔧 Debugging Tools Status:", ""}
  
  for tool, available in pairs(debug_info) do
    if tool ~= "gef_path" then
      local status = available and "✅" or "❌"
      table.insert(info_lines, string.format("%s %s: %s", status, tool, available and "Available" or "Not Found"))
    end
  end
  
  if debug_info.gef and debug_info.gef_path then
    table.insert(info_lines, string.format("📁 GEF Path: %s", debug_info.gef_path))
  end
  
  vim.notify(table.concat(info_lines, "\n"), vim.log.levels.INFO)
end, { desc = "Debug Tools Info" })