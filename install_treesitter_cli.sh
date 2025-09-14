#!/bin/bash
# Installation script for tree-sitter CLI
# This resolves the "tree-sitter CLI not found" error

echo "🌳 Tree-sitter CLI Installation Script"
echo "======================================"

# Check if tree-sitter is already installed
if command -v tree-sitter >/dev/null 2>&1; then
    echo "✅ tree-sitter CLI is already installed: $(tree-sitter --version)"
    exit 0
fi

echo "📦 Installing tree-sitter CLI..."

# Try different installation methods
if command -v npm >/dev/null 2>&1; then
    echo "Using npm to install tree-sitter-cli..."
    npm install -g tree-sitter-cli
    if [ $? -eq 0 ]; then
        echo "✅ Successfully installed tree-sitter CLI via npm"
        echo "Version: $(tree-sitter --version)"
        exit 0
    fi
fi

if command -v cargo >/dev/null 2>&1; then
    echo "Using cargo to install tree-sitter-cli..."
    cargo install tree-sitter-cli
    if [ $? -eq 0 ]; then
        echo "✅ Successfully installed tree-sitter CLI via cargo"
        echo "Version: $(tree-sitter --version)"
        exit 0
    fi
fi

# Check if installation was successful
if command -v tree-sitter >/dev/null 2>&1; then
    echo "✅ tree-sitter CLI installed successfully!"
    echo "Version: $(tree-sitter --version)"
    echo ""
    echo "🎉 You can now restart Neovim to enable auto-install for tree-sitter parsers."
else
    echo "❌ Failed to install tree-sitter CLI"
    echo ""
    echo "Manual installation options:"
    echo "1. Via npm: npm install -g tree-sitter-cli"
    echo "2. Via cargo: cargo install tree-sitter-cli"
    echo "3. Download binary from: https://github.com/tree-sitter/tree-sitter/releases"
    echo ""
    echo "Note: The CLI is optional - basic syntax highlighting works without it."
    exit 1
fi