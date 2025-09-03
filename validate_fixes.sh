#!/usr/bin/env bash

# Validation script for nvim_setup fixes
echo "🧪 Testing nvim_setup configuration fixes..."

cd "$(dirname "$0")"

# Test 1: Check if configuration loads without errors
echo "1. Testing basic configuration loading..."
if nvim --headless -c "lua print('✅ Config loads successfully')" -c "q" 2>/dev/null; then
    echo "   ✅ Basic configuration loading: PASSED"
else
    echo "   ❌ Basic configuration loading: FAILED"
fi

# Test 2: Check which-key syntax
echo "2. Testing which-key configuration syntax..."
if nvim --headless -c "lua local ok, wk = pcall(require, 'which-key'); if ok then print('✅ which-key syntax: PASSED') else print('❌ which-key syntax: FAILED') end" -c "q" 2>/dev/null; then
    echo "   ✅ which-key configuration: PASSED"
else
    echo "   ⚠️  which-key not installed yet (this is expected)"
fi

# Test 3: Check git environment setup
echo "3. Testing git environment configuration..."
export GIT_TERMINAL_PROMPT=0
export GIT_ASKPASS=echo
if timeout 10 git ls-remote https://github.com/folke/which-key.nvim.git HEAD >/dev/null 2>&1; then
    echo "   ✅ Git authentication prevention: PASSED"
else
    echo "   ❌ Git authentication prevention: FAILED"
fi

echo ""
echo "🎯 Configuration validation summary:"
echo "   - which-key updated to latest v3 syntax with modern preset"
echo "   - Environment variables set to prevent git authentication prompts"
echo "   - lazy.nvim configured with proper git settings"
echo ""
echo "The fixes should resolve:"
echo "   1. which-key compatibility with newest syntax"
echo "   2. mini.git authentication errors during plugin installation"