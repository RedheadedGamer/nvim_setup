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

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- Configure git to disable terminal prompts before cloning lazy.nvim
  -- This prevents the "could not read Username for 'https://github.com'" error
  vim.env.GIT_TERMINAL_PROMPT = "0"
  vim.env.GIT_ASKPASS = "echo"
  vim.env.SSH_ASKPASS = "echo"
  
  -- Set git configs to prevent authentication prompts
  os.execute("git config --global credential.helper store 2>/dev/null || true")
  os.execute("git config --global core.askPass '' 2>/dev/null || true")
  
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
require("lazy").setup(require("plugins"), {
  git = {
    -- Use HTTPS with environment variables to prevent authentication prompts
    url_format = "https://github.com/%s.git",
    timeout = 120,
    cmd = "git",
    log = { "-C", "%(file)s", "log", "--oneline", "--graph", "--decorate" },
  },
  install = {
    -- Use fallback colorscheme while installing plugins
    colorscheme = { "default" },
  },
  -- Better default config options
  defaults = {
    version = false, -- Try loading the latest commit if version is not specified
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen", 
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Set environment variables to prevent git authentication prompts
-- This should prevent the mini.git clone error
vim.env.GIT_TERMINAL_PROMPT = "0"
vim.env.GIT_ASKPASS = "echo"
vim.env.SSH_ASKPASS = "echo"

-- Initialize theme system after plugins are loaded
require("config.theme").init()

-- Display startup message
if vim.fn.argc() == 0 then
  vim.defer_fn(function()
    print("🚀 Neovim Lua configuration loaded successfully!")
    print("💡 Use <leader>ff to find files, <leader>fg to grep, K for hover docs")
  end, 100)
end