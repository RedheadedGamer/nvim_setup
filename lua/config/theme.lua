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

-- Apply theme with error handling and fallback
function M.apply_theme(theme_name)
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
        vim.notify("Applied theme variation: " .. variation, vim.log.levels.INFO)
        return true
      end
    end
    
    vim.notify("Failed to load theme: " .. theme_name, vim.log.levels.ERROR)
    return false
  end
end

-- Get list of available themes
function M.get_available_themes()
  local colorschemes = vim.fn.getcompletion("", "color")
  
  -- Add themes that might not be loaded yet but should be available
  local additional_themes = {
    -- OneDark variants
    "onedark_dark", "onedark_vivid", "onedark_cool", "onedark_warm",
    -- Tokyo Night variants
    "tokyonight-night", "tokyonight-storm", "tokyonight-day", "tokyonight-moon",
    -- Gruvbox family
    "gruvbox", "gruvbox-baby", "gruvbox-material", "gruvbox-flat",
    -- Dracula variants
    "dracula", "dracula-soft",
    -- Nord theme
    "nord",
    -- Catppuccin variants
    "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha",
    -- Fox themes
    "nightfox", "dawnfox", "dayfox", "duskfox", "nordfox", "terafox", "carbonfox",
    -- Rose Pine variants
    "rose-pine", "rose-pine-main", "rose-pine-moon", "rose-pine-dawn",
    -- Kanagawa variants
    "kanagawa", "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus",
    -- Popular themes
    "sonokai", "edge", "everforest", "everforest-dark", "everforest-light", "material",
    "vscode", "darkplus", "aurora",
    -- GitHub theme variants (enhanced collection)
    "github_dark", "github_light", "github_dark_dimmed", "github_dark_high_contrast",
    "github_dark_colorblind", "github_light_high_contrast", "github_light_colorblind",
    "github_dark_tritanopia", "github_light_tritanopia", "github_dark_default",
    "github_light_default",
    -- Premium modern themes  
    "monokai-pro", "solarized", "ayu-dark", "ayu-light", "ayu-mirage",
    "oceanic-next", "palenight", "tender", "spaceduck", "deep-space",
    "moonfly", "nightfly", "zephyr", "oxocarbon", "melange", "flow",
    "cyberdream", "vesper", "bamboo", "flexoki", "lackluster",
    -- Additional premium themes for 50+ count
    "onehalf-dark", "onehalf-light", "papercolor-theme", "apprentice",
    "seoul256", "hybrid", "jellybeans", "molokai", "srcery", 
    "iceberg", "falcon", "challenger-deep", "vim-monokai-tasty", "substrata",
    "calvera-dark", "tokyodark", "alduin", "tender-vim", "space-vim-dark",
    "gotham", "zenburn", "railscasts", "badwolf", "lucius"
  }
  
  -- Combine and deduplicate
  local all_themes = {}
  local seen = {}
  
  for _, theme in ipairs(colorschemes) do
    if not seen[theme] then
      table.insert(all_themes, theme)
      seen[theme] = true
    end
  end
  
  for _, theme in ipairs(additional_themes) do
    if not seen[theme] then
      table.insert(all_themes, theme)
      seen[theme] = true
    end
  end
  
  table.sort(all_themes)
  return all_themes
end

-- Get list of GitHub themes specifically
function M.get_github_themes()
  return {
    "github_dark",
    "github_light", 
    "github_dark_dimmed",
    "github_dark_high_contrast",
    "github_light_high_contrast",
    "github_dark_colorblind",
    "github_light_colorblind",
    "github_dark_tritanopia",
    "github_light_tritanopia",
    "github_dark_default",
    "github_light_default"
  }
end

-- Quick function to cycle through GitHub themes
function M.cycle_github_themes()
  local github_themes = M.get_github_themes()
  local current = _G.nvim_current_theme or vim.g.current_theme or vim.g.colors_name or ""
  
  -- Find current theme index
  local current_index = 1
  for i, theme in ipairs(github_themes) do
    if theme == current then
      current_index = i
      break
    end
  end
  
  -- Get next theme (cycle back to first if at end)
  local next_index = current_index < #github_themes and current_index + 1 or 1
  local next_theme = github_themes[next_index]
  
  if M.apply_theme(next_theme) then
    M.save_theme(next_theme)
    vim.notify("🎨 GitHub Theme: " .. next_theme, vim.log.levels.INFO)
    return next_theme
  end
  
  return current
end

-- Initialize theme system
function M.init()
  -- Load saved theme on startup
  local saved_theme = M.load_theme()
  
  -- Try to apply the saved theme, fallback to default if it fails
  if not M.apply_theme(saved_theme) then
    -- If saved theme fails, try default theme
    if saved_theme ~= default_theme then
      if not M.apply_theme(default_theme) then
        -- If even default fails, try a built-in theme
        M.apply_theme("default")
        vim.g.current_theme = "default"
        _G.nvim_current_theme = "default"
      end
    end
  end
  
  -- Set up autocommand to detect manual theme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ThemePersistence", { clear = true }),
    callback = function(args)
      if args.match and args.match ~= "" then
        vim.g.current_theme = args.match
        _G.nvim_current_theme = args.match
        -- Optional: Auto-save theme changes (uncomment if desired)
        -- M.save_theme(args.match)
      end
    end,
  })
end

return M