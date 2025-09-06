-- config/theme_enhanced.lua
-- Enhanced theme persistence and management system

local M = {}

-- Path to store theme configuration
local config_dir = vim.fn.stdpath("config")
local theme_file = config_dir .. "/theme_config.lua"
local favorites_file = config_dir .. "/theme_favorites.lua"

-- Default theme
local default_theme = "onedark_dark"

-- Theme metadata for better user experience
M.theme_metadata = {
  ["onedark_dark"] = { type = "dark", family = "onedark", desc = "Professional dark theme" },
  ["onedark"] = { type = "dark", family = "onedark", desc = "Clean VSCode-inspired" },
  ["tokyonight-night"] = { type = "dark", family = "tokyonight", desc = "Dark blue night" },
  ["tokyonight-storm"] = { type = "dark", family = "tokyonight", desc = "Storm variant" },
  ["tokyonight-day"] = { type = "light", family = "tokyonight", desc = "Clean light theme" },
  ["gruvbox"] = { type = "dark", family = "gruvbox", desc = "Retro groove colors" },
  ["dracula"] = { type = "dark", family = "dracula", desc = "Popular purple theme" },
  ["nord"] = { type = "dark", family = "nord", desc = "Arctic color palette" },
  ["oxocarbon"] = { type = "dark", family = "oxocarbon", desc = "IBM's modern theme" },
  ["github_dark"] = { type = "dark", family = "github", desc = "Official GitHub dark" },
  ["github_light"] = { type = "light", family = "github", desc = "Official GitHub light" },
  ["material"] = { type = "dark", family = "material", desc = "Material design colors" },
  ["nordic"] = { type = "dark", family = "nordic", desc = "Scandinavian-inspired" },
}

-- Save theme to persistent storage with enhanced error handling
function M.save_theme(theme_name)
  -- Validate theme name
  if not theme_name or theme_name == "" then
    vim.notify("❌ Invalid theme name", vim.log.levels.ERROR)
    return false
  end

  local config_content = string.format([=[
-- Auto-generated theme configuration
-- Do not edit manually - this file is overwritten by theme switcher
-- Last updated: %s
return "%s"
]=], os.date("%Y-%m-%d %H:%M:%S"), theme_name)
  
  local file = io.open(theme_file, "w")
  if file then
    file:write(config_content)
    file:close()
    vim.notify("💾 Theme saved: " .. theme_name, vim.log.levels.INFO)
    return true
  else
    vim.notify("❌ Failed to save theme configuration", vim.log.levels.ERROR)
    return false
  end
end

-- Load theme from persistent storage with fallback handling
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
    vim.notify("⚠️  Failed to load saved theme, using default: " .. default_theme, vim.log.levels.WARN)
    return default_theme
  end
end

-- Apply theme with enhanced error handling and validation
function M.apply_theme(theme_name)
  if not theme_name or theme_name == "" then
    vim.notify("❌ Invalid theme name provided", vim.log.levels.ERROR)
    return false
  end

  local ok, _ = pcall(vim.cmd, "colorscheme " .. theme_name)
  if ok then
    vim.g.current_theme = theme_name
    -- Add slight delay for theme to fully load before showing success
    vim.defer_fn(function()
      local metadata = M.theme_metadata[theme_name]
      if metadata then
        vim.notify(string.format("🎨 Theme applied: %s (%s)", theme_name, metadata.desc), vim.log.levels.INFO)
      else
        vim.notify("🎨 Theme applied: " .. theme_name, vim.log.levels.INFO)
      end
    end, 100)
    return true
  else
    vim.notify("❌ Failed to load theme: " .. theme_name, vim.log.levels.ERROR)
    return false
  end
end

-- Get current theme
function M.get_current_theme()
  return vim.g.current_theme or default_theme
end

-- Get theme info
function M.get_theme_info(theme_name)
  return M.theme_metadata[theme_name] or { type = "unknown", family = "unknown", desc = "No description available" }
end

-- Toggle between light and dark themes
function M.toggle_theme_type()
  local current = M.get_current_theme()
  local current_info = M.get_theme_info(current)
  
  if current_info.type == "dark" then
    -- Switch to a light theme
    local light_themes = { "tokyonight-day", "catppuccin-latte", "rose-pine-dawn", "github_light" }
    for _, theme in ipairs(light_themes) do
      if M.apply_theme(theme) then
        M.save_theme(theme)
        break
      end
    end
  else
    -- Switch to a dark theme
    local dark_themes = { "onedark_dark", "tokyonight-night", "dracula", "gruvbox" }
    for _, theme in ipairs(dark_themes) do
      if M.apply_theme(theme) then
        M.save_theme(theme)
        break
      end
    end
  end
end

-- Initialize theme system with enhanced startup
function M.init()
  -- Load saved theme on startup
  local saved_theme = M.load_theme()
  
  -- Try to apply the saved theme, fallback to default if it fails
  if not M.apply_theme(saved_theme) then
    -- If saved theme fails, try default theme
    if saved_theme ~= default_theme then
      if not M.apply_theme(default_theme) then
        -- If even default fails, notify user
        vim.notify("❌ Critical: Could not load any theme. Check your theme plugins.", vim.log.levels.ERROR)
      end
    end
  end
end

return M