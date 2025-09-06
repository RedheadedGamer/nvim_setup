-- validate_theme_improvements.lua
-- Simple validation script to test theme improvements in Neovim

-- Test enhanced theme manager
print("🎨 Testing Enhanced Theme Manager")
print("================================")

local ok, theme_manager = pcall(require, "config.theme_enhanced")
if not ok then
  print("❌ Failed to load enhanced theme manager")
  return
end

print("✅ Enhanced theme manager loaded successfully")

-- Test theme metadata
local metadata_count = 0
for _ in pairs(theme_manager.theme_metadata or {}) do
  metadata_count = metadata_count + 1
end
print("📊 Theme metadata entries: " .. metadata_count)

-- Test current theme functions
local current_theme = theme_manager.get_current_theme()
print("🎯 Current theme: " .. current_theme)

local theme_info = theme_manager.get_theme_info(current_theme)
print("ℹ️  Theme info: " .. theme_info.desc .. " (" .. theme_info.type .. ")")

-- Test theme validation (without actually changing theme)
print("\n🔍 Testing theme validation...")
local test_themes = {"onedark_dark", "tokyonight-night", "nonexistent_theme"}
for _, theme in ipairs(test_themes) do
  local available_themes = vim.fn.getcompletion("", "color")
  local found = false
  for _, available in ipairs(available_themes) do
    if available == theme then
      found = true
      break
    end
  end
  
  if found then
    print("✅ " .. theme .. " is available")
  else
    print("❌ " .. theme .. " is not available")
  end
end

print("\n🎉 Theme manager validation complete!")
print("💡 Use :lua require('config.theme_enhanced').toggle_theme_type() to test theme switching")
print("💡 Use <leader>tt to open the enhanced theme switcher")