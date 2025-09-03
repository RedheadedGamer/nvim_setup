--  _   _                 _
-- | \ | | ___  _____   _(_)_ __ ___
-- |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
-- | |\  |  __/ (_) \ V /| | | | | | |
-- |_| \_|\___|\___/ \_/ |_|_| |_| |_|
--
-- Modern Lua Configuration for Neovim
-- Converted from init.vim by Stephan Raabe (2023)
-- -----------------------------------------------------

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Initialize theme system early
require("config.theme").init()

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup(require("plugins"))

-- Display startup message
if vim.fn.argc() == 0 then
  vim.defer_fn(function()
    print("🚀 Neovim Lua configuration loaded successfully!")
    print("💡 Use <leader>ff to find files, <leader>fg to grep, K for hover docs")
  end, 100)
end