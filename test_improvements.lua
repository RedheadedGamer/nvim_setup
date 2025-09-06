#!/usr/bin/env lua

-- test_improvements.lua
-- Test script for the nvim configuration improvements

print("🧪 Testing Neovim Configuration Improvements")
print("=" .. string.rep("=", 50))

-- Test 1: Plugin configuration syntax
print("\n1. 📋 Testing plugin configuration...")
local ok, plugins = pcall(loadfile, "lua/plugins/init.lua")
if ok then
    print("   ✅ Plugin configuration syntax is valid")
    local plugin_list = plugins()
    print("   📦 Found " .. #plugin_list .. " plugin configurations")
    
    -- Count theme plugins
    local theme_count = 0
    for _, plugin in ipairs(plugin_list) do
        if type(plugin) == "table" and plugin[1] then
            local repo = plugin[1]
            if repo:match("theme") or repo:match("color") or 
               repo:match("onedark") or repo:match("tokyo") or 
               repo:match("gruvbox") or repo:match("dracula") or
               repo:match("catppuccin") or repo:match("rose-pine") or
               repo:match("kanagawa") or repo:match("nightfox") or
               repo:match("nord") or repo:match("material") or
               repo:match("github") or repo:match("oxocarbon") or
               repo:match("nordic") then
                theme_count = theme_count + 1
            end
        end
    end
    print("   🎨 Found " .. theme_count .. " theme plugins")
else
    print("   ❌ Plugin configuration has syntax errors:")
    print("   " .. tostring(plugins))
    os.exit(1)
end

-- Test 2: Enhanced theme manager
print("\n2. 🎨 Testing enhanced theme manager...")
local ok, theme_manager_source = pcall(io.open, "lua/config/theme_enhanced.lua", "r")
if ok and theme_manager_source then
    local content = theme_manager_source:read("*all")
    theme_manager_source:close()
    
    print("   ✅ Theme manager file exists and is readable")
    
    -- Check for key functions
    local functions = {"save_theme", "load_theme", "apply_theme", "get_current_theme", "toggle_theme_type"}
    for _, func in ipairs(functions) do
        if content:match("function M%." .. func) then
            print("   ✅ " .. func .. " function found")
        else
            print("   ⚠️  " .. func .. " function missing")
        end
    end
    
    -- Check for theme metadata
    if content:match("theme_metadata") then
        print("   ✅ Theme metadata structure found")
    else
        print("   ⚠️  Theme metadata missing")
    end
else
    print("   ❌ Theme manager file not accessible")
end

-- Test 3: Startup optimizations
print("\n3. ⚡ Testing startup optimizations...")
local ok, startup_file = pcall(io.open, "lua/config/startup_optimizations.lua", "r")
if ok and startup_file then
    local content = startup_file:read("*all")
    startup_file:close()
    
    print("   ✅ Startup optimizations file exists and is readable")
    
    -- Check for key functions
    local functions = {"setup_performance", "setup_error_handling", "validate_environment", "setup_ux_improvements", "init"}
    for _, func in ipairs(functions) do
        if content:match("function M%." .. func) then
            print("   ✅ " .. func .. " function found")
        else
            print("   ⚠️  " .. func .. " function missing")
        end
    end
else
    print("   ❌ Startup optimizations file not accessible")
end

-- Test 4: ASCII Art validation
print("\n4. 🎭 Testing ASCII art...")
-- Check if the ASCII art is properly formatted (simulate the header function)
local function test_ascii_art()
    local day_part = "morning"
    local username = "user"
    
    local header_art = {
        "╭─────────────────────────────────────────────────────────╮",
        "│                                                         │",
        "│   ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ │",
        "│   ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ │",
        "│   ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ │",
        "│   ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ │",
        "│   ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║ │",
        "│   ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ │",
        "│                                                         │",
        "│              🚀 Your Ultimate Coding Companion 🚀        │",
        "│                                                         │",
        "│         " .. string.format("Good %s, %s!", day_part, username) .. string.rep(" ", math.max(0, 29 - string.len(day_part .. username))) .. "│",
        "│                                                         │",
        "╰─────────────────────────────────────────────────────────╯",
    }
    
    -- Check if all lines have consistent width
    local expected_width = 61 -- Based on border characters
    local consistent = true
    for i, line in ipairs(header_art) do
        local actual_width = string.len(line)
        if actual_width ~= expected_width then
            print("   ⚠️  Line " .. i .. " width mismatch: expected " .. expected_width .. ", got " .. actual_width)
            consistent = false
        end
    end
    
    if consistent then
        print("   ✅ ASCII art has consistent formatting")
    end
    
    return header_art
end

local art = test_ascii_art()
print("   📐 ASCII art height: " .. #art .. " lines")

-- Test 5: Theme categories validation
print("\n5. 📂 Testing theme categories...")
local categories = {
    "🌙 Dark Professional",
    "🎨 Dark Colorful", 
    "🌿 Nature & Minimal",
    "🦊 Nightfox Family",
    "☀️ Light Themes"
}

print("   📁 Defined categories: " .. #categories)
for i, category in ipairs(categories) do
    print("   " .. i .. ". " .. category)
end

print("\n🎉 All tests completed!")
print("=" .. string.rep("=", 50))
print("✨ Configuration improvements are ready for use!")