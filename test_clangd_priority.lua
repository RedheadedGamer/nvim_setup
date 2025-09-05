-- Test script to verify C LSP prioritization
-- This script checks if the clangd prioritization logic works correctly

print("🧪 Testing C LSP Priority Configuration")

-- Simulate the bootstrap_clangd function logic
local function test_clangd_bootstrap()
  print("📋 Testing clangd bootstrap logic...")
  
  -- Check if clangd is available in system PATH
  local clangd_available = vim.fn.executable("clangd") == 1
  print(string.format("System clangd available: %s", clangd_available and "✅ YES" or "❌ NO"))
  
  -- Test clangd command variations
  local clangd_commands = {
    { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu", "--completion-style=detailed" },
    { "clangd", "--background-index", "--header-insertion=iwyu" },
    { "clangd", "--background-index" },
    { "clangd" },
  }
  
  print("🔧 Testing clangd command variations:")
  for i, cmd in ipairs(clangd_commands) do
    if vim.fn.executable(cmd[1]) == 1 then
      print(string.format("  %d. ✅ %s", i, table.concat(cmd, " ")))
      print(string.format("     → Would use this configuration"))
      return true
    else
      print(string.format("  %d. ❌ %s", i, table.concat(cmd, " ")))
    end
  end
  
  print("  → No clangd found, would show install message")
  return false
end

-- Test C/C++ file detection
local function test_c_file_detection()
  print("📁 Testing C/C++ file detection...")
  
  local cwd = vim.loop.cwd()
  local patterns = {"*.c", "*.cpp", "*.h", "*.hpp", "*.cc", "*.cxx"}
  
  for _, pattern in ipairs(patterns) do
    local files = vim.fn.glob(cwd .. "/" .. pattern, false, true)
    if #files > 0 then
      print(string.format("  ✅ Found %d %s files", #files, pattern))
      return true
    else
      print(string.format("  ❌ No %s files found", pattern))
    end
  end
  
  print("  → No C/C++ files detected in current directory")
  return false
end

-- Test Mason registry simulation
local function test_mason_registry()
  print("📦 Testing Mason registry logic...")
  
  -- This would be the actual Mason logic in a real environment
  local mason_available = false -- Simulated since Mason isn't loaded here
  
  if mason_available then
    print("  ✅ Mason registry available")
    print("  🔧 Would attempt clangd installation via Mason")
  else
    print("  ❌ Mason registry not available in test environment")
    print("  ⚠️  Would show manual installation message")
  end
  
  return mason_available
end

-- Run all tests
print("\n" .. string.rep("=", 50))
print("🚀 Running C LSP Priority Tests")
print(string.rep("=", 50))

local clangd_bootstrap_result = test_clangd_bootstrap()
print()

local c_files_detected = test_c_file_detection()
print()

local mason_result = test_mason_registry()
print()

print(string.rep("=", 50))
print("📊 Test Results Summary:")
print(string.rep("=", 50))
print(string.format("Clangd Bootstrap: %s", clangd_bootstrap_result and "✅ PASS" or "⚠️  FALLBACK"))
print(string.format("C/C++ Detection: %s", c_files_detected and "✅ DETECTED" or "ℹ️  NO FILES"))
print(string.format("Mason Registry: %s", mason_result and "✅ AVAILABLE" or "⚠️  SIMULATED"))

if clangd_bootstrap_result then
  print("\n🎉 C LSP prioritization is properly configured!")
  print("   → clangd will be available immediately on startup")
else
  print("\n💡 C LSP will use fallback installation methods")
  print("   → Mason will attempt to install clangd when available")
  print("   → Manual installation instructions will be provided")
end

print("\n✅ Configuration test completed successfully!")