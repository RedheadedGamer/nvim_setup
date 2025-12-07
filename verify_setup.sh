#!/bin/bash

# Neovim Setup Verification Script
# This script checks if all prerequisites are installed and working

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
PASSED=0
FAILED=0
WARNINGS=0

# Print colored message
print_msg() {
    local color=$1
    shift
    echo -e "${color}$@${NC}"
}

# Check if command exists
check_command() {
    local cmd=$1
    local name=$2
    local required=$3
    
    if command -v "$cmd" &> /dev/null; then
        local version=$("$cmd" --version 2>&1 | head -n1)
        print_msg "$GREEN" "✓ $name found: $version"
        PASSED=$((PASSED + 1))
        return 0
    else
        if [ "$required" = "true" ]; then
            print_msg "$RED" "✗ $name not found (REQUIRED)"
            FAILED=$((FAILED + 1))
        else
            print_msg "$YELLOW" "⚠ $name not found (optional)"
            WARNINGS=$((WARNINGS + 1))
        fi
        return 1
    fi
}

# Detect OS
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    elif [ -f /etc/arch-release ]; then
        OS="arch"
    elif [ "$(uname -s)" = "Darwin" ]; then
        OS="macos"
    else
        OS="unknown"
    fi
}

print_msg "$BLUE" "=============================================="
print_msg "$BLUE" "  Neovim Setup Verification"
print_msg "$BLUE" "=============================================="
echo ""

# Detect OS
detect_os
print_msg "$BLUE" "Detected OS: $OS"
echo ""

print_msg "$BLUE" "Checking required tools..."
echo ""

# Check required tools
check_command "nvim" "Neovim" "true"
check_command "git" "Git" "true"

echo ""
print_msg "$BLUE" "Checking optional tools for full setup..."
echo ""

check_command "node" "Node.js" "false"
check_command "npm" "NPM" "false"
check_command "python3" "Python" "false" || check_command "python" "Python" "false"
check_command "rg" "ripgrep" "false"

echo ""
print_msg "$BLUE" "Checking C/C++ development tools..."
echo ""

check_command "gcc" "GCC" "false" || check_command "clang" "Clang" "false"
check_command "cmake" "CMake" "false"
check_command "gdb" "GDB" "false"

echo ""
print_msg "$BLUE" "Checking configuration..."
echo ""

# Check if config exists
if [ -d "$HOME/.config/nvim" ]; then
    print_msg "$GREEN" "✓ Neovim config directory exists"
    PASSED=$((PASSED + 1))
    
    # Check if init.lua exists
    if [ -f "$HOME/.config/nvim/init.lua" ]; then
        print_msg "$GREEN" "✓ init.lua found"
        PASSED=$((PASSED + 1))
    else
        print_msg "$RED" "✗ init.lua not found"
        FAILED=$((FAILED + 1))
    fi
    
    # Check setup type
    if [ -f "$HOME/.config/nvim/.minimal_setup" ]; then
        print_msg "$BLUE" "  Setup type: MINIMAL"
    else
        print_msg "$BLUE" "  Setup type: FULL"
    fi
else
    print_msg "$YELLOW" "⚠ Neovim config directory not found at ~/.config/nvim"
    print_msg "$YELLOW" "  Run the installer first: ./install.sh"
    WARNINGS=$((WARNINGS + 1))
fi

echo ""
print_msg "$BLUE" "=============================================="
print_msg "$BLUE" "  Verification Summary"
print_msg "$BLUE" "=============================================="
echo ""

print_msg "$GREEN" "Passed: $PASSED"
print_msg "$YELLOW" "Warnings: $WARNINGS"
print_msg "$RED" "Failed: $FAILED"

echo ""

if [ $FAILED -gt 0 ]; then
    print_msg "$RED" "Some required tools are missing!"
    echo ""
    print_msg "$YELLOW" "Install missing tools for $OS:"
    echo ""
    
    case "$OS" in
        arch|archlinux|manjaro)
            print_msg "$YELLOW" "  sudo pacman -S neovim git nodejs npm python python-pip ripgrep"
            ;;
        ubuntu|debian)
            print_msg "$YELLOW" "  sudo apt update && sudo apt install neovim git nodejs npm python3 python3-pip ripgrep"
            ;;
        fedora|rhel|centos)
            print_msg "$YELLOW" "  sudo dnf install neovim git nodejs npm python3 python3-pip ripgrep"
            ;;
        macos|darwin)
            print_msg "$YELLOW" "  brew install neovim git node python ripgrep"
            ;;
        *)
            print_msg "$YELLOW" "  Install using your system package manager"
            ;;
    esac
    
    exit 1
elif [ $WARNINGS -gt 0 ]; then
    print_msg "$YELLOW" "Setup is functional but some optional tools are missing."
    print_msg "$YELLOW" "Install them for full functionality (see above)."
    exit 0
else
    print_msg "$GREEN" "All checks passed! Your setup is ready."
    print_msg "$GREEN" "Start Neovim with: nvim"
    exit 0
fi
