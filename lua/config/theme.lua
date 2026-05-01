-- config/theme.lua
-- Theme persistence configuration

local M = {}

-- State to track if we are currently picking a theme (to avoid auto-saving previews)
local picking_theme = false

-- Path to store theme configuration
local config_dir = vim.fn.stdpath("config")
local theme_file = config_dir .. "/theme_config.lua"

-- Default theme
local default_theme = "onedark_dark"

-- Save theme to persistent storage
function M.save_theme(theme_name, silent)
  local config_content = string.format([[
-- Auto-generated theme configuration
-- Do not edit manually - this file is overwritten by theme switcher
return "%s"
]], theme_name)
  
  local file = io.open(theme_file, "w")
  if file then
    file:write(config_content)
    file:close()
    if not silent then
      vim.notify("Theme saved: " .. theme_name, vim.log.levels.INFO)
    end
    return true
  else
    if not silent then
      vim.notify("Failed to save theme configuration", vim.log.levels.ERROR)
    end
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

-- Apply theme with error handling and fallback
function M.apply_theme(theme_name, opts)
  if not theme_name or theme_name == "" then return false end
  
  opts = opts or {}
  local silent = opts.silent

  -- Handle Sonokai style variants
  if type(theme_name) == "string" and theme_name:match("^sonokai%-") then
    local style = theme_name:match("^sonokai%-(.+)$")
    vim.g.sonokai_style = style
    theme_name = "sonokai"
  end

  local ok, _ = pcall(vim.cmd, "colorscheme " .. theme_name)
  if ok then
    vim.g.current_theme = theme_name
    -- Also store in global variable for easier access
    _G.nvim_current_theme = theme_name
    return true
  else
    -- Try some common variations
    local variations = {
      theme_name:gsub("-", "_"),
      theme_name:gsub("_", "-"),
      theme_name .. "-dark",
      theme_name .. "_dark"
    }
    
    for _, variation in ipairs(variations) do
      local var_ok, _ = pcall(vim.cmd, "colorscheme " .. variation)
      if var_ok then
        vim.g.current_theme = variation
        _G.nvim_current_theme = variation
        if not silent then
          vim.notify("Applied theme variation: " .. variation, vim.log.levels.INFO)
        end
        return true
      end
    end
    
    if not silent then
      vim.notify("Failed to load theme: " .. theme_name, vim.log.levels.ERROR)
    end
    return false
  end
end

-- Get list of available themes
function M.get_available_themes()
  local themes = {
    -- TokyoNight
    "tokyonight", "tokyonight-night", "tokyonight-storm", "tokyonight-moon",
    -- Kanagawa
    "kanagawa", "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus",
    -- OneDark
    "onedark", "onedark_vivid", "onedark_dark",
    -- Catppuccin
    "catppuccin", "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha",
    -- Sonokai (Styles/Categories)
    "sonokai-default", "sonokai-atlantis", "sonokai-andromeda", "sonokai-shusia", "sonokai-maia", "sonokai-espresso",
  }
  table.sort(themes)
  return themes
end

-- Initialize theme system
function M.init()
  -- Load saved theme on startup
  local saved_theme = M.load_theme()
  
  -- Try to apply the saved theme, fallback to default if it fails
  if not M.apply_theme(saved_theme, { silent = true }) then
    -- If saved theme fails, try default theme
    if saved_theme ~= default_theme then
      if not M.apply_theme(default_theme, { silent = true }) then
        -- If even default fails, try a built-in theme
        M.apply_theme("default", { silent = true })
        vim.g.current_theme = "default"
        _G.nvim_current_theme = "default"
      end
    end
  end
  
  -- Set up autocommand to detect manual theme changes and persist them
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ThemePersistence", { clear = true }),
    callback = function(args)
      -- PERSISTENCE: Save theme changes automatically
      -- GUARD: Don't save while we are just "previewing" in the picker
      if not picking_theme and args.match and args.match ~= "" then
        vim.g.current_theme = args.match
        _G.nvim_current_theme = args.match
        M.save_theme(args.match, true)
      end
    end,
  })
end

-- Enhanced theme picker using Snacks.picker
function M.theme_picker()
  local ok, snacks = pcall(require, "snacks")
  if not ok then
    vim.cmd("Telescope colorscheme")
    return
  end

  local original_theme = _G.nvim_current_theme or vim.g.current_theme or vim.g.colors_name or "default"
  local themes = M.get_available_themes()
  local items = {}
  for _, theme in ipairs(themes) do
    table.insert(items, {
      text = theme,
      value = theme,
    })
  end

  picking_theme = true

  -- Use Snacks picker for a professional, persistent, and filtered experience
  snacks.picker.pick({
    source = "colorschemes",
    items = items,
    layout = "vertical",
    format = "text",
    on_change = function(_, item)
      if item and item.value then
        -- Live preview using our robust apply function (silently)
        M.apply_theme(item.value, { silent = true })
      end
    end,
    confirm = function(picker, item)
      picker:close()
      picking_theme = false
      if item and item.value then
        -- Final apply (with notifications)
        M.apply_theme(item.value)
        M.save_theme(item.value)
        vim.notify("🎨 Theme applied: " .. item.value, vim.log.levels.INFO)
      else
        -- Restore original
        M.apply_theme(original_theme)
      end
    end,
    on_close = function()
      if picking_theme then
        picking_theme = false
        -- Restore original theme if we closed without selecting
        M.apply_theme(original_theme, { silent = true })
      end
    end,
  })
end

return M