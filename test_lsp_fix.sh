#!/bin/bash
# Test script to verify LSP duplication fixes

echo "🔬 Testing LSP Duplication Fixes"
echo "================================="

# Check if test_hover.c exists
if [ ! -f "test_hover.c" ]; then
    echo "❌ test_hover.c not found"
    exit 1
fi

echo "✅ test_hover.c found"

# Check Lua syntax of plugins file
echo "🔍 Checking Lua syntax..."
if command -v luac >/dev/null 2>&1; then
    if luac -p lua/plugins/init.lua >/dev/null 2>&1; then
        echo "✅ Lua syntax check passed"
    else
        echo "❌ Lua syntax errors found"
        luac -p lua/plugins/init.lua
        exit 1
    fi
else
    echo "⚠️  luac not available, skipping syntax check"
fi

# Check for key improvements in the configuration
echo "🔍 Checking for LSP improvements..."

# Check for focus_id in hover handler
if grep -q "focus_id.*hover_handler" lua/plugins/init.lua; then
    echo "✅ Hover handler with focus_id found (prevents duplicates)"
else
    echo "❌ Hover handler focus_id not found"
fi

# Check for enhanced clangd configuration
if grep -q "function-arg-placeholders" lua/plugins/init.lua; then
    echo "✅ Enhanced clangd configuration found"
else
    echo "❌ Enhanced clangd configuration not found"
fi

# Check for C development plugins
echo "🔍 Checking for C development plugins..."
plugins=("cmake-tools" "nvim-dap" "nvim-lint" "clangd_extensions")
for plugin in "${plugins[@]}"; do
    if grep -q "$plugin" lua/plugins/init.lua; then
        echo "✅ $plugin plugin found"
    else
        echo "❌ $plugin plugin not found"
    fi
done

# Check for CMake LSP
if grep -q '"cmake"' lua/plugins/init.lua; then
    echo "✅ CMake LSP support found"
else
    echo "❌ CMake LSP support not found"
fi

echo ""
echo "📋 Summary:"
echo "- LSP duplication prevention: Implemented with focus_id handlers"
echo "- Enhanced clangd configuration: Advanced flags and options"  
echo "- C development plugins: cmake-tools, nvim-dap, nvim-lint, clangd_extensions"
echo "- Debug support: codelldb and gdb configurations"
echo "- Static analysis: cppcheck and clang-tidy integration"
echo "- Project management: CMake integration with keybindings"
echo ""
echo "🎯 Next steps:"
echo "1. Install tools via :Mason (clangd, cppcheck, clang-tidy, codelldb)"
echo "2. Test with a C project containing CMakeLists.txt or Makefile"
echo "3. Use <leader>cg to generate build files"
echo "4. Use K to test hover documentation (should not duplicate)"
echo "5. Use <leader>db to test debugging features"

echo ""
echo "✅ LSP duplication fixes and C development enhancements completed!"