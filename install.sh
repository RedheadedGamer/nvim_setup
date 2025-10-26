#!/bin/bash

# Neovim Configuration Installation Script
# This script installs the Neovim configuration with options for full or minimal setup

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
INSTALL_TYPE=""
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
BACKUP_DIR="${CONFIG_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMP_CLONE_DIR=""

# Print colored message
print_msg() {
    local color=$1
    shift
    echo -e "${color}$@${NC}"
}

# Print header
print_header() {
    echo ""
    print_msg "$BLUE" "================================================"
    print_msg "$BLUE" "  Neovim Configuration Installer"
    print_msg "$BLUE" "================================================"
    echo ""
}

# Show usage
show_usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Install Neovim configuration to ~/.config/nvim

OPTIONS:
    --full          Install full setup with LSP, Mason, linters, and all themes
    --minimal       Install minimal setup without LSP features and fewer themes
    -h, --help      Show this help message

EXAMPLES:
    $0 --full       # Full installation with all features
    $0 --minimal    # Minimal installation without LSP
    $0              # Interactive mode (prompts for choice)

EOF
}

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --full)
                INSTALL_TYPE="full"
                shift
                ;;
            --minimal)
                INSTALL_TYPE="minimal"
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                print_msg "$RED" "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

# Interactive mode to select installation type
select_install_type() {
    if [ -z "$INSTALL_TYPE" ]; then
        print_header
        print_msg "$GREEN" "Please select installation type:"
        echo ""
        echo "1) Full Setup - Complete IDE experience"
        print_msg "$YELLOW" "   • LSP support (Language Server Protocol)"
        print_msg "$YELLOW" "   • Mason for LSP server management"
        print_msg "$YELLOW" "   • Auto-completion with nvim-cmp"
        print_msg "$YELLOW" "   • Linters and formatters"
        print_msg "$YELLOW" "   • C/C++ development tools (clangd, cmake, debugging)"
        print_msg "$YELLOW" "   • 50+ themes"
        print_msg "$YELLOW" "   • All mini.nvim plugins (28 plugins)"
        echo ""
        echo "2) Minimal Setup - Lightweight configuration"
        print_msg "$YELLOW" "   • Basic editing features"
        print_msg "$YELLOW" "   • Syntax highlighting with Treesitter"
        print_msg "$YELLOW" "   • Essential mini.nvim plugins"
        print_msg "$YELLOW" "   • 5 popular themes"
        print_msg "$YELLOW" "   • No LSP, Mason, or linters"
        print_msg "$YELLOW" "   • Faster startup time"
        echo ""
        read -p "Enter your choice (1 or 2): " choice
        
        case $choice in
            1)
                INSTALL_TYPE="full"
                ;;
            2)
                INSTALL_TYPE="minimal"
                ;;
            *)
                print_msg "$RED" "Invalid choice. Exiting."
                exit 1
                ;;
        esac
    fi
}

# Backup existing configuration
backup_existing_config() {
    if [ -d "$CONFIG_DIR" ]; then
        print_msg "$YELLOW" "Existing configuration found at $CONFIG_DIR"
        read -p "Do you want to backup the existing configuration? (y/n): " backup_choice
        
        if [[ $backup_choice =~ ^[Yy]$ ]]; then
            print_msg "$BLUE" "Backing up to $BACKUP_DIR..."
            mv "$CONFIG_DIR" "$BACKUP_DIR"
            print_msg "$GREEN" "✓ Backup created successfully"
        else
            print_msg "$YELLOW" "Removing existing configuration..."
            rm -rf "$CONFIG_DIR"
        fi
    fi
}

# Check if we're running from within the repository
is_running_from_repo() {
    # Check if we're in a git repository and it's the nvim_setup repo
    if git -C "$SCRIPT_DIR" rev-parse --git-dir > /dev/null 2>&1; then
        local repo_url=$(git -C "$SCRIPT_DIR" config --get remote.origin.url 2>/dev/null || echo "")
        if [[ "$repo_url" == *"nvim_setup"* ]]; then
            return 0
        fi
    fi
    return 1
}

# Copy files from source to destination, excluding .git and .github
do_copy() {
    local src="$1"
    local dest="$2"
    
    mkdir -p "$dest"
    
    if ! rsync -av --exclude='.git' --exclude='.github' "$src/" "$dest/"; then
        # Fallback to cp if rsync is not available
        print_msg "$YELLOW" "rsync not found, using cp instead..."
        if ! cp -r "$src/." "$dest/"; then
            print_msg "$RED" "✗ Failed to copy files"
            return 1
        fi
        # Remove .git directory if it was copied
        rm -rf "$dest/.git" "$dest/.github"
    fi
    return 0
}

# Copy files from the current directory to config directory
copy_files() {
    print_msg "$BLUE" "Copying Neovim configuration files..."
    
    if ! do_copy "$SCRIPT_DIR" "$CONFIG_DIR"; then
        exit 1
    fi
    
    print_msg "$GREEN" "✓ Files copied successfully"
}

# Clone the repository or copy files
install_files() {
    if is_running_from_repo; then
        print_msg "$BLUE" "Detected script running from repository..."
        copy_files
        # Mark for cleanup if running from a temporary directory
        # Check common temp directory patterns
        if [[ "$SCRIPT_DIR" == /tmp/* ]] || [[ "$SCRIPT_DIR" == /var/tmp/* ]] || [[ "$SCRIPT_DIR" == "$TMPDIR"/* ]]; then
            TEMP_CLONE_DIR="$SCRIPT_DIR"
        fi
    else
        print_msg "$BLUE" "Cloning Neovim configuration..."
        
        # Create a temporary directory for cloning
        TEMP_CLONE_DIR=$(mktemp -d)
        
        if ! git clone git@github.com:RedheadedGamer/nvim_setup.git "$TEMP_CLONE_DIR"; then
            print_msg "$RED" "✗ Failed to clone repository"
            echo ""
            print_msg "$YELLOW" "Note: This script uses SSH for cloning. If you don't have SSH keys configured,"
            print_msg "$YELLOW" "you can clone manually using HTTPS instead:"
            print_msg "$BLUE" "  git clone https://github.com/RedheadedGamer/nvim_setup.git \"$CONFIG_DIR\""
            echo ""
            print_msg "$YELLOW" "For SSH setup instructions, see:"
            print_msg "$BLUE" "  https://docs.github.com/en/authentication/connecting-to-github-with-ssh"
            rm -rf "$TEMP_CLONE_DIR"
            exit 1
        fi
        
        print_msg "$GREEN" "✓ Repository cloned successfully"
        
        # Now copy files from temp directory to config directory
        print_msg "$BLUE" "Installing configuration files..."
        
        if ! do_copy "$TEMP_CLONE_DIR" "$CONFIG_DIR"; then
            rm -rf "$TEMP_CLONE_DIR"
            exit 1
        fi
        
        print_msg "$GREEN" "✓ Configuration installed successfully"
    fi
}

# Configure for minimal setup
configure_minimal() {
    print_msg "$BLUE" "Configuring minimal setup..."
    
    # Create a marker file to indicate minimal setup
    touch "$CONFIG_DIR/.minimal_setup"
    
    # Replace the plugins loading in init.lua
    if [ -f "$CONFIG_DIR/init.lua" ]; then
        # Backup original init.lua
        cp "$CONFIG_DIR/init.lua" "$CONFIG_DIR/init.lua.full"
        
        # Modify the plugin loading line
        sed -i 's/require("lazy").setup(require("plugins"),/-- Check for minimal setup\nlocal plugins_module = vim.fn.filereadable(vim.fn.stdpath("config") .. "\/.minimal_setup") == 1 and "plugins.minimal" or "plugins"\nrequire("lazy").setup(require(plugins_module),/' "$CONFIG_DIR/init.lua"
    fi
    
    print_msg "$GREEN" "✓ Minimal setup configured"
}

# Configure for full setup
configure_full() {
    print_msg "$BLUE" "Configuring full setup..."
    
    # Remove minimal marker if it exists
    rm -f "$CONFIG_DIR/.minimal_setup"
    
    # Ensure we're using the full plugins
    if [ -f "$CONFIG_DIR/init.lua.full" ]; then
        mv "$CONFIG_DIR/init.lua.full" "$CONFIG_DIR/init.lua"
    fi
    
    print_msg "$GREEN" "✓ Full setup configured"
}

# Print post-installation instructions
print_instructions() {
    echo ""
    print_msg "$GREEN" "================================================"
    print_msg "$GREEN" "  Installation Complete!"
    print_msg "$GREEN" "================================================"
    echo ""
    
    if [ "$INSTALL_TYPE" = "full" ]; then
        print_msg "$BLUE" "Next steps for FULL setup:"
        echo ""
        echo "1. Start Neovim:"
        print_msg "$YELLOW" "   nvim"
        echo ""
        echo "2. The configuration will automatically:"
        print_msg "$YELLOW" "   • Install lazy.nvim plugin manager"
        print_msg "$YELLOW" "   • Download and install all plugins"
        print_msg "$YELLOW" "   • Set up LSP servers through Mason"
        echo ""
        echo "3. Wait for installation to complete, then restart Neovim"
        echo ""
        echo "4. Optional dependencies for full features:"
        print_msg "$YELLOW" "   • Node.js (for LSP servers)"
        print_msg "$YELLOW" "   • Python (for Python LSP)"
        print_msg "$YELLOW" "   • ripgrep (for better search)"
        print_msg "$YELLOW" "   • C/C++ tools: clang, cmake, gdb (for C/C++ development)"
        echo ""
        echo "5. Key bindings:"
        print_msg "$YELLOW" "   • <Space>ff - Find files"
        print_msg "$YELLOW" "   • <Space>fg - Live grep"
        print_msg "$YELLOW" "   • <Space>th - Theme switcher"
        print_msg "$YELLOW" "   • K - Hover documentation (LSP)"
        print_msg "$YELLOW" "   • gd - Go to definition (LSP)"
    else
        print_msg "$BLUE" "Next steps for MINIMAL setup:"
        echo ""
        echo "1. Start Neovim:"
        print_msg "$YELLOW" "   nvim"
        echo ""
        echo "2. The configuration will automatically:"
        print_msg "$YELLOW" "   • Install lazy.nvim plugin manager"
        print_msg "$YELLOW" "   • Download and install minimal plugins"
        print_msg "$YELLOW" "   • Set up basic editing features"
        echo ""
        echo "3. Wait for installation to complete, then restart Neovim"
        echo ""
        echo "4. Key bindings:"
        print_msg "$YELLOW" "   • <Space>e - File explorer"
        print_msg "$YELLOW" "   • <Space>ff - Find files"
        print_msg "$YELLOW" "   • <Space>th - Theme switcher"
        print_msg "$YELLOW" "   • gcc - Comment line"
    fi
    
    echo ""
    echo "For more information, see:"
    print_msg "$BLUE" "   $CONFIG_DIR/README.md"
    echo ""
    
    if [ -d "$BACKUP_DIR" ]; then
        print_msg "$YELLOW" "Your old configuration is backed up at:"
        print_msg "$YELLOW" "   $BACKUP_DIR"
        echo ""
    fi
}

# Clean up temporary files
cleanup() {
    if [ -n "$TEMP_CLONE_DIR" ] && [ -d "$TEMP_CLONE_DIR" ]; then
        print_msg "$BLUE" "Cleaning up temporary files..."
        rm -rf "$TEMP_CLONE_DIR"
        print_msg "$GREEN" "✓ Cleanup complete"
    fi
}

# Main installation flow
main() {
    parse_args "$@"
    select_install_type
    
    print_header
    print_msg "$GREEN" "Installing ${INSTALL_TYPE^^} setup to $CONFIG_DIR"
    echo ""
    
    backup_existing_config
    install_files
    
    if [ "$INSTALL_TYPE" = "minimal" ]; then
        configure_minimal
    else
        configure_full
    fi
    
    cleanup
    print_instructions
}

# Run main function
main "$@"
