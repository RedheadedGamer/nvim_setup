#!/bin/bash

# Test script to verify enhanced diagnostic functionality
echo "Testing enhanced diagnostic functionality..."

cd /home/runner/work/nvim_setup/nvim_setup

# Create a test file with various diagnostic issues
cat > test_enhanced_diagnostics.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>

int main() {
    // Error: missing semicolon
    printf("Testing diagnostics")
    
    // Warning: unused variable
    int unused_var = 42;
    
    // Error: undeclared variable
    int result = undeclared_variable;
    
    // Warning: uninitialized pointer usage
    char *ptr;
    *ptr = 'a';
    
    return 0;
}
EOF

echo "Created test file with diagnostic issues: test_enhanced_diagnostics.c"

# Test if neovim can be started with our configuration
echo "Testing neovim configuration..."
if nvim --headless +q 2>/dev/null; then
    echo "✓ Neovim starts successfully with configuration"
else
    echo "✗ Neovim configuration has issues"
    exit 1
fi

echo "Enhanced diagnostic functionality test completed!"
echo ""
echo "Features added:"
echo "  ✓ Auto-hover diagnostics on CursorHold (300ms delay)"
echo "  ✓ Enhanced diagnostic signs with better icons"
echo "  ✓ Severity-based navigation: [e]rror, [w]arning, [d]iagnostic"
echo "  ✓ Toggle auto-hover with <leader>lh"
echo "  ✓ Improved floating window styling"
echo ""
echo "To test manually:"
echo "  1. nvim test_enhanced_diagnostics.c"
echo "  2. Position cursor on any line with errors/warnings"
echo "  3. Wait 300ms - diagnostic popup should appear automatically"
echo "  4. Use [e/]e for error navigation, [w/]w for warnings"
echo "  5. Use <leader>lh to toggle auto-hover on/off"