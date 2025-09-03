-- config/theme.lua
-- Theme persistence configuration

local M = {}

-- Path to store theme configuration
local config_dir = vim.fn.stdpath("config")
local theme_file = config_dir .. "/theme_config.lua"

-- Default theme
local default_theme = "onedark_dark"

-- Save theme to persistent storage
function M.save_theme(theme_name)
  local config_content = string.format([[
-- Auto-generated theme configuration
-- Do not edit manually - this file is overwritten by theme switcher
return "%s"
]], theme_name)
  
  local file = io.open(theme_file, "w")
  if file then
    file:write(config_content)
    file:close()
    vim.notify("Theme saved: " .. theme_name, vim.log.levels.INFO)
    return true
  else
    vim.notify("Failed to save theme configuration", vim.log.levels.ERROR)
    return false
  end
end

-- Load theme from persistent storage
function M.load_theme()
  -- Check if theme config file exists
  local file = io.open(theme_file, "r")
  if not file then
    -- File doesn't exist, return default theme
    return default_theme
  end
  file:close()
  
  -- Try to load the theme configuration
  local ok, theme = pcall(dofile, theme_file)
  if ok and theme and type(theme) == "string" then
    return theme
  else
    -- Failed to load, return default
    vim.notify("Failed to load saved theme, using default", vim.log.levels.WARN)
    return default_theme
  end
end

-- Apply theme with error handling
function M.apply_theme(theme_name)
  local ok, _ = pcall(vim.cmd, "colorscheme " .. theme_name)
  if ok then
    vim.g.current_theme = theme_name
    return true
  else
    vim.notify("Failed to load theme: " .. theme_name, vim.log.levels.ERROR)
    return false
  end
end

-- Initialize theme system
function M.init()
  -- Load saved theme on startup
  local saved_theme = M.load_theme()
  
  -- Try to apply the saved theme, fallback to default if it fails
  if not M.apply_theme(saved_theme) then
    -- If saved theme fails, try default theme
    if saved_theme ~= default_theme then
      M.apply_theme(default_theme)
    end
  end
end

return M