#!/bin/bash
# Validation script for Neovim configuration improvements

echo "🔍 Validating Neovim Configuration Improvements..."

# Check file syntax integrity
echo "📁 Checking file integrity..."

# Check if key files exist
for file in "lua/plugins/init.lua" "lua/config/keymaps.lua" "lua/config/autocmds.lua"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing"
        exit 1
    fi
done

# Check Lua syntax balance
echo "⚖️  Checking syntax balance..."
python3 << 'EOF'
import sys

def check_file_balance(filename):
    try:
        with open(filename, 'r') as f:
            content = f.read()
        
        # Count braces and parentheses
        open_braces = content.count('{')
        close_braces = content.count('}')
        open_parens = content.count('(')
        close_parens = content.count(')')
        open_brackets = content.count('[')
        close_brackets = content.count(']')
        
        balanced = True
        
        if open_braces != close_braces:
            print(f"❌ {filename}: Unbalanced braces ({open_braces} open, {close_braces} close)")
            balanced = False
        else:
            print(f"✅ {filename}: Braces balanced ({open_braces})")
            
        if open_parens != close_parens:
            print(f"❌ {filename}: Unbalanced parentheses ({open_parens} open, {close_parens} close)")
            balanced = False
        else:
            print(f"✅ {filename}: Parentheses balanced ({open_parens})")
            
        if open_brackets != close_brackets:
            print(f"❌ {filename}: Unbalanced brackets ({open_brackets} open, {close_brackets} close)")
            balanced = False
        else:
            print(f"✅ {filename}: Brackets balanced ({open_brackets})")
        
        return balanced
    except Exception as e:
        print(f"❌ Error checking {filename}: {e}")
        return False

# Check main files
files_to_check = [
    'lua/plugins/init.lua',
    'lua/config/keymaps.lua', 
    'lua/config/autocmds.lua'
]

all_balanced = True
for file in files_to_check:
    if not check_file_balance(file):
        all_balanced = False

if not all_balanced:
    sys.exit(1)
EOF

if [ $? -eq 0 ]; then
    echo "✅ All syntax checks passed"
else
    echo "❌ Syntax check failed"
    exit 1
fi

# Check for specific improvements
echo "🔧 Validating improvements..."

# Check for keymap discovery enhancements
if grep -q "All Keymaps Browser" lua/plugins/init.lua; then
    echo "✅ Enhanced keymap discovery added"
else
    echo "❌ Enhanced keymap discovery missing"
fi

# Check for transparency improvements  
if grep -q "MiniStatusline" lua/config/autocmds.lua; then
    echo "✅ Enhanced transparency system added"
else
    echo "❌ Enhanced transparency system missing"
fi

# Check for starter improvements
if grep -q "Discovery" lua/plugins/init.lua; then
    echo "✅ Enhanced starter screen added"
else
    echo "❌ Enhanced starter screen missing"
fi

# Check for key conflict resolutions
if grep -q "<leader>te" lua/config/keymaps.lua && grep -q "<leader>nt" lua/config/keymaps.lua; then
    echo "✅ Key conflict resolutions applied"
else
    echo "❌ Key conflict resolutions missing"
fi

echo ""
echo "🎉 Configuration validation complete!"
echo ""
echo "🗝️  New keymap discovery features:"
echo "   <leader>fK  - Browse ALL keymaps"
echo "   <leader>fkn - Normal mode keymaps"
echo "   <leader>fkv - Visual mode keymaps"
echo "   <leader>fki - Insert mode keymaps"
echo "   <leader><leader>? - Global which-key viewer"
echo ""
echo "🔧 Key changes:"
echo "   <leader>te  - Terminal (was <leader>t;)"
echo "   <leader>nt  - New tab (was <leader>tn)"
echo ""
echo "✨ Enhanced transparency for:"
echo "   - Which-key backgrounds"
echo "   - Theme switcher UI"
echo "   - Statusline elements" 
echo "   - Starter screen"
echo ""
echo "🚀 Improved starter screen with:"
echo "   - Quick Actions section"
echo "   - Discovery section with keymap access"
echo "   - Customization section"
echo "   - Management section"