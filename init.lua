--  _   _                 _
-- | \ | | ___  _____   _(_)_ __ ___
-- |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
-- | |\  |  __/ (_) \ V /| | | | | | |
-- |_| \_|\___|\___/ \_/ |_|_| |_| |_|
--
-- Modern Lua Configuration for Neovim
-- Updated and modernized (2026)
-- Cross-platform support: Linux, macOS, Windows
-- -----------------------------------------------------

-- Detect OS for cross-platform compatibility (modernized)
local is_windows = vim.fn.has("win32") == 1
local is_mac = vim.fn.has("mac") == 1
local is_linux = not is_windows and not is_mac

-- Store OS detection globally for other modules
_G.is_windows = is_windows
_G.is_mac = is_mac
_G.is_linux = is_linux

-- Ensure proper runtime path for configuration modules
local config_path = vim.fn.stdpath("config")
vim.opt.rtp:prepend(config_path)

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Use vim.uv (modern API) instead of deprecated vim.loop
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  -- Configure git to disable terminal prompts before cloning lazy.nvim
  vim.env.GIT_TERMINAL_PROMPT = "0"
  vim.env.GIT_ASKPASS = "echo"
  vim.env.SSH_ASKPASS = "echo"
  
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

-- Check for minimal setup and load appropriate plugins
local is_minimal = vim.fn.filereadable(config_path .. "/.minimal_setup") == 1
local plugins_module = is_minimal and "plugins.minimal" or "plugins"

-- Load plugins
require("lazy").setup(require(plugins_module), {
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
  ui = {
    -- Disable automatic opening of lazy UI
    backdrop = 100, -- Set high backdrop to make it less intrusive
    size = { width = 0.8, height = 0.8 },
    wrap = true,
    border = "rounded",
    title = "Lazy",
    title_pos = "center",
    -- Don't show UI automatically on startup
    throttle = 20,
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
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Initialize theme system after plugins are loaded
require("config.theme").init()

-- Display startup message
if vim.fn.argc() == 0 then
  vim.defer_fn(function()
    local current_theme = _G.nvim_current_theme or vim.g.current_theme or vim.g.colors_name or "default"
    local setup_type = vim.fn.filereadable(vim.fn.stdpath("config") .. "/.minimal_setup") == 1 and "Minimal" or "Full"
    print("🚀 Neovim Lua configuration loaded successfully!")
    print("📦 Setup: " .. setup_type)
    print("🎨 Current theme: " .. current_theme)
    print("💡 Use <leader>ff to find files, <leader>fg to grep, K for hover docs")
    print("⚡ Theme shortcuts: <leader>th (switcher), <leader>ts (quick), <leader>tg (GitHub)")
  end, 100)
end
