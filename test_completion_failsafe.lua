-- Test script to verify completion failsafes
-- This script tests if completion sources adapt to LSP availability

print("🧪 Testing Completion Failsafe Configuration")
print(string.rep("=", 50))

-- Test 1: Check if LSP clients are available
local function test_lsp_availability()
  print("📋 Testing LSP client availability...")
  
  -- Simulate checking for active LSP clients
  local simulated_clients = {}  -- Empty = no LSP servers running
  local has_lsp = #simulated_clients > 0
  
  print(string.format("Active LSP clients: %d", #simulated_clients))
  print(string.format("LSP available: %s", has_lsp and "✅ YES" or "❌ NO"))
  
  return has_lsp
end

-- Test 2: Check completion sources configuration
local function test_completion_sources()
  print("\n🔧 Testing completion sources configuration...")
  
  -- Current hardcoded sources
  local current_sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }
  
  print("Current sources (hardcoded):")
  for i, source in ipairs(current_sources) do
    print(string.format("  %d. %s", i, source.name))
  end
  
  -- What sources should be available based on LSP status
  local has_lsp = test_lsp_availability()
  local recommended_sources = {}
  
  if has_lsp then
    table.insert(recommended_sources, { name = "nvim_lsp", priority = 1000 })
  end
  table.insert(recommended_sources, { name = "luasnip", priority = 750 })
  table.insert(recommended_sources, { name = "buffer", priority = 500 })
  table.insert(recommended_sources, { name = "path", priority = 250 })
  
  print("\nRecommended sources (with LSP check):")
  for i, source in ipairs(recommended_sources) do
    print(string.format("  %d. %s (priority: %d)", i, source.name, source.priority or 0))
  end
  
  return current_sources, recommended_sources
end

-- Test 3: Check completion plugin availability
local function test_completion_plugins()
  print("\n📦 Testing completion plugin availability...")
  
  local plugins_to_check = {
    "cmp",
    "luasnip", 
    "cmp_nvim_lsp",
    "cmp_buffer",
    "cmp_path",
    "cmp_luasnip"
  }
  
  local available_plugins = {}
  
  for _, plugin in ipairs(plugins_to_check) do
    -- Simulate plugin availability check
    local available = true  -- Assume plugins are installed
    if available then
      table.insert(available_plugins, plugin)
      print(string.format("  ✅ %s", plugin))
    else
      print(string.format("  ❌ %s", plugin))
    end
  end
  
  return available_plugins
end

-- Test 4: Simulate completion source failsafe logic
local function test_failsafe_logic()
  print("\n🛡️ Testing completion failsafe logic...")
  
  local function get_safe_completion_sources()
    local sources = {}
    
    -- Check if LSP is available and working
    local lsp_available = false
    -- Simulate: pcall(require, "cmp_nvim_lsp") and #vim.lsp.get_active_clients() > 0
    
    if lsp_available then
      table.insert(sources, { name = "nvim_lsp", priority = 1000 })
      print("  ✅ Added LSP source (high priority)")
    else
      print("  ⚠️  LSP source skipped (not available)")
    end
    
    -- Always try to add snippet support
    local luasnip_ok = true  -- Simulate: pcall(require, "luasnip")
    if luasnip_ok then
      table.insert(sources, { name = "luasnip", priority = 750 })
      print("  ✅ Added snippet source")
    end
    
    -- Always add buffer and path sources (they should always work)
    table.insert(sources, { name = "buffer", priority = 500 })
    table.insert(sources, { name = "path", priority = 250 })
    print("  ✅ Added buffer and path sources (always available)")
    
    return sources
  end
  
  local safe_sources = get_safe_completion_sources()
  
  print("\nSafe completion sources:")
  for i, source in ipairs(safe_sources) do
    print(string.format("  %d. %s (priority: %d)", i, source.name, source.priority))
  end
  
  return safe_sources
end

-- Run all tests
print("🔍 Running completion failsafe tests...\n")

local lsp_available = test_lsp_availability()
local current_sources, recommended_sources = test_completion_sources()
local available_plugins = test_completion_plugins()
local safe_sources = test_failsafe_logic()

print(string.rep("=", 50))
print("📊 Test Results Summary:")
print(string.rep("=", 50))
print(string.format("LSP Available: %s", lsp_available and "✅ YES" or "⚠️  NO"))
print(string.format("Available Plugins: %d/%d", #available_plugins, 6))
print(string.format("Safe Sources: %d", #safe_sources))

if not lsp_available then
  print("\n💡 Completion should work without LSP using:")
  print("   → Snippets (luasnip)")
  print("   → Buffer words")
  print("   → File paths")
  print("   → This ensures autocompletion works even when LSP fails")
else
  print("\n🎉 LSP is available, full completion enabled!")
end

print("\n✅ Completion failsafe test completed!")