#!/usr/bin/env lua

-- Validation script for nvim configuration
-- This script tests the key fixes applied to handle missing dependencies

print("🔍 Validating Neovim configuration fixes...")

-- Test 1: Version compatibility check
print("\n1. Testing version compatibility...")
if vim.version and vim.version.ge then
    print("✅ vim.version.ge is available (Neovim 0.8+)")
else
    print("⚠️  vim.version.ge not available, fallback should be used")
end

-- Test 2: Check ripgrep availability and fallbacks
print("\n2. Testing ripgrep and fallbacks...")
if vim.fn.executable("rg") == 1 then
    print("✅ ripgrep is available")
else
    print("⚠️  ripgrep not available, checking fallbacks...")
    if vim.fn.executable("grep") == 1 then
        print("✅ grep fallback is available")
    else
        print("❌ No grep tools available")
    end
end

-- Test 3: Check essential plugins can be loaded
print("\n3. Testing plugin loading...")
local plugins_to_test = {
    "plenary.nvim",
    "nvim-treesitter",
    "mini.pairs",
    "telescope",
}

for _, plugin in ipairs(plugins_to_test) do
    local ok, _ = pcall(require, plugin)
    if ok then
        print(string.format("✅ %s loaded successfully", plugin))
    else
        print(string.format("⚠️  %s failed to load", plugin))
    end
end

-- Test 4: Check notify functionality
print("\n4. Testing notification system...")
if vim.notify then
    print("✅ vim.notify is available")
    -- Test a notification
    pcall(vim.notify, "Test notification", vim.log.levels.INFO)
else
    print("❌ vim.notify not available")
end

-- Test 5: Check mason and LSP
print("\n5. Testing LSP system...")
local mason_ok, _ = pcall(require, "mason")
if mason_ok then
    print("✅ Mason is available")
else
    print("⚠️  Mason not available")
end

local lspconfig_ok, _ = pcall(require, "lspconfig")
if lspconfig_ok then
    print("✅ LSP config is available")
else
    print("⚠️  LSP config not available")
end

print("\n🎉 Configuration validation complete!")
print("💡 If you see warnings (⚠️), the fallbacks should handle them gracefully.")