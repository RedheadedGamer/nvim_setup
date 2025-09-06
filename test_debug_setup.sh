#!/bin/bash
# test_debug_setup.sh
# Test script to validate debugging environment setup

echo "🔧 Testing Neovim Debugging Setup..."
echo "=================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if command exists
check_command() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}✅ $1 is installed${NC}"
        return 0
    else
        echo -e "${RED}❌ $1 is not installed${NC}"
        return 1
    fi
}

# Function to check if file exists
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✅ $1 exists${NC}"
        return 0
    else
        echo -e "${RED}❌ $1 not found${NC}"
        return 1
    fi
}

echo ""
echo "🔍 Checking Core Debug Tools..."
echo "--------------------------------"

# Check core debugging tools
check_command "gdb"
check_command "valgrind"
check_command "python3"
check_command "node"

echo ""
echo "🦊 Checking GEF Installation..."
echo "-------------------------------"

# Check for GEF
GEF_PATHS=(
    "$HOME/.gef.py"
    "/usr/share/gef/gef.py"
    "/opt/gef/gef.py"
)

GEF_FOUND=0
for path in "${GEF_PATHS[@]}"; do
    if check_file "$path"; then
        echo -e "${GREEN}   GEF found at: $path${NC}"
        GEF_FOUND=1
        break
    fi
done

if [ $GEF_FOUND -eq 0 ]; then
    echo -e "${YELLOW}💡 Install GEF with: wget -O ~/.gef.py https://github.com/hugsy/gef/raw/main/gef.py${NC}"
fi

echo ""
echo "📂 Checking Neovim Configuration..."
echo "-----------------------------------"

# Check Neovim config files
NVIM_CONFIG_DIR="$HOME/.config/nvim"
if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo -e "${GREEN}✅ Neovim config directory exists${NC}"
    
    # Check specific files
    check_file "$NVIM_CONFIG_DIR/lua/config/debugging.lua"
    check_file "$NVIM_CONFIG_DIR/DEBUGGING_GUIDE.md"
    
    # Check if debugging is mentioned in keymaps
    if grep -q "debugging" "$NVIM_CONFIG_DIR/lua/config/keymaps.lua" 2>/dev/null; then
        echo -e "${GREEN}✅ Debug keymaps configured${NC}"
    else
        echo -e "${RED}❌ Debug keymaps not found${NC}"
    fi
else
    echo -e "${RED}❌ Neovim config directory not found${NC}"
fi

echo ""
echo "🐍 Checking Python Debug Support..."
echo "------------------------------------"

# Check Python debugpy
if python3 -c "import debugpy" 2>/dev/null; then
    echo -e "${GREEN}✅ Python debugpy is available${NC}"
else
    echo -e "${RED}❌ Python debugpy not found${NC}"
    echo -e "${YELLOW}💡 Install with: pip install debugpy${NC}"
fi

echo ""
echo "🧪 Creating Test Files..."
echo "-------------------------"

# Create a simple C test program
cat > test_debug.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>

int main() {
    int *ptr = malloc(sizeof(int) * 10);
    
    // Intentional issues for debugging demo
    for(int i = 0; i <= 10; i++) {  // Buffer overflow
        ptr[i] = i * 2;
    }
    
    printf("Debug test program\n");
    printf("Pointer value: %p\n", (void*)ptr);
    
    // Memory leak - not freeing ptr
    return 0;
}
EOF

# Create a simple Python test program  
cat > test_debug.py << 'EOF'
#!/usr/bin/env python3

def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

def main():
    numbers = [5, 10, 15, 20]
    
    print("Factorial calculations:")
    for num in numbers:
        result = factorial(num)
        print(f"{num}! = {result}")
    
    # Intentional issue for debugging
    zero_division = 10 / 0  # This will cause an error

if __name__ == "__main__":
    main()
EOF

echo -e "${GREEN}✅ Created test_debug.c${NC}"
echo -e "${GREEN}✅ Created test_debug.py${NC}"

# Try to compile the C program
if check_command "gcc"; then
    if gcc -g -o test_debug test_debug.c 2>/dev/null; then
        echo -e "${GREEN}✅ Compiled test_debug.c successfully${NC}"
        echo -e "${YELLOW}💡 Use 'valgrind ./test_debug' to test memory checking${NC}"
    else
        echo -e "${RED}❌ Failed to compile test_debug.c${NC}"
    fi
fi

echo ""
echo "🚀 Quick Test Commands..."
echo "-------------------------"
echo -e "${YELLOW}In Neovim:${NC}"
echo "  1. Open test_debug.c"
echo "  2. Press <leader>dI to check debug tool status"
echo "  3. Press <leader>b to set a breakpoint"
echo "  4. Press <F5> to start debugging"
echo "  5. Press <leader>dM for memory analysis tools"
echo ""
echo -e "${YELLOW}Command line tests:${NC}"
echo "  valgrind --leak-check=full ./test_debug"
echo "  gdb ./test_debug"
echo "  python3 test_debug.py"

echo ""
echo "🏁 Test Summary"
echo "==============="

# Count successful checks
TOTAL_CHECKS=0
PASSED_CHECKS=0

# This is a simplified summary - in a real script you'd track the actual results
echo -e "${GREEN}Debug environment setup validation complete!${NC}"
echo -e "${YELLOW}Check the output above for any missing components.${NC}"
echo ""
echo -e "${GREEN}🎯 Next steps:${NC}"
echo "  1. Install any missing tools shown above"
echo "  2. Open Neovim and test the debugging features"
echo "  3. Read DEBUGGING_GUIDE.md for detailed usage instructions"

# Clean up test files
read -p "Remove test files? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -f test_debug.c test_debug.py test_debug
    echo "Test files removed."
fi