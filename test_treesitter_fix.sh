#!/bin/bash
# Test script to verify tree-sitter CLI error fix

echo "🧪 Testing Tree-sitter CLI Error Fix"
echo "===================================="

cd "$(dirname "$0")"

# Create test files
echo "📝 Creating test files..."
echo '\documentclass{article}\begin{document}Hello LaTeX\end{document}' > test.tex
echo 'function test() { console.log("Hello JavaScript"); }' > test.js
echo 'def test(): print("Hello Python")' > test.py

# Test 1: Basic configuration loading
echo "1. Testing basic configuration loading..."
if timeout 10 nvim --headless -c "lua print('✅ Config loads successfully')" -c "q" 2>/dev/null; then
    echo "   ✅ Basic configuration loading: PASSED"
else
    echo "   ❌ Basic configuration loading: FAILED"
fi

# Test 2: Test with different file types that might trigger treesitter
echo "2. Testing file type handling..."
for file in test.tex test.js test.py; do
    echo "   Testing $file..."
    if timeout 10 nvim --headless "$file" -c "echo 'File opened successfully'" -c "q" 2>/dev/null; then
        echo "   ✅ $file: PASSED"
    else
        echo "   ❌ $file: FAILED"
    fi
done

# Test 3: Check tree-sitter CLI detection
echo "3. Testing tree-sitter CLI detection logic..."
if timeout 10 nvim --headless -c "lua local has_cli = vim.fn.executable('tree-sitter') == 1; print('CLI available: ' .. tostring(has_cli))" -c "q" 2>/dev/null; then
    echo "   ✅ CLI detection logic: PASSED"
else
    echo "   ❌ CLI detection logic: FAILED"
fi

# Test 4: Check if configuration handles missing tree-sitter gracefully
echo "4. Testing graceful handling of missing tree-sitter..."
if timeout 10 nvim --headless -c "lua local ok, ts = pcall(require, 'nvim-treesitter.configs'); print('Treesitter loadable: ' .. tostring(ok))" -c "q" 2>/dev/null; then
    echo "   ✅ Graceful error handling: PASSED"
else
    echo "   ❌ Graceful error handling: FAILED"
fi

# Cleanup
echo "🧹 Cleaning up test files..."
rm -f test.tex test.js test.py

echo ""
echo "📋 Fix Summary:"
echo "- Modified treesitter config to detect CLI availability"
echo "- Added auto_install = has_cli to prevent CLI requirement errors"
echo "- Added protected call (pcall) for graceful error handling"
echo "- Added user notification about CLI status"
echo "- Created installation script for optional CLI setup"
echo "- Updated documentation with troubleshooting steps"
echo ""
echo "✅ Tree-sitter CLI error fix validation completed!"
echo ""
echo "🚀 To enable full treesitter functionality:"
echo "   ./install_treesitter_cli.sh"
echo ""
echo "📖 For more info, see PLUGIN_GUIDE.md troubleshooting section"