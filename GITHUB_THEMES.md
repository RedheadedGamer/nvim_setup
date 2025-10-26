# GitHub Themes Collection

This Neovim configuration now includes an enhanced GitHub themes collection with **11 different variants** to match your preferences and accessibility needs.

## Available GitHub Themes

### Standard Variants
- **`github_dark`** - GitHub's standard dark theme
- **`github_light`** - GitHub's standard light theme  
- **`github_dark_dimmed`** - Softer dark variant with reduced contrast

### High Contrast Options
- **`github_dark_high_contrast`** - Enhanced dark theme for better readability
- **`github_light_high_contrast`** - Enhanced light theme for better readability

### Accessibility-Focused Variants
- **`github_dark_colorblind`** - Colorblind-friendly dark theme
- **`github_light_colorblind`** - Colorblind-friendly light theme
- **`github_dark_tritanopia`** - Optimized for tritanopia (blue-yellow color blindness)
- **`github_light_tritanopia`** - Light variant optimized for tritanopia

### Default Variants
- **`github_dark_default`** - GitHub's default dark theme
- **`github_light_default`** - GitHub's default light theme

## Usage

### Theme Switching
1. **Interactive Theme Switcher**: `<leader>th` or `<leader>tt`
2. **Quick Theme Selector**: `<leader>ts`
3. **GitHub Theme Cycler**: `<leader>tg` (cycles through all GitHub variants)

### Manual Theme Setting
```lua
vim.cmd("colorscheme github_dark")
```

### Theme Features
- **Full transparency support** - Works seamlessly with terminal transparency
- **Enhanced highlight groups** - Improved readability for all UI elements
- **Telescope integration** - Better visibility in fuzzy finder
- **LSP diagnostics support** - Clear error/warning highlighting
- **Git integration** - Proper colors for diff and blame functionality

## Enhanced Configuration

The GitHub theme plugin is configured with:
- Full transparency support
- Terminal color integration
- Optimized styles for comments and keywords
- Enhanced floating window support
- Better Telescope integration
- Improved completion menu visibility

## Customization

You can modify the GitHub theme configuration in `lua/plugins/init.lua`:

```lua
require("github-theme").setup({
  options = {
    transparent = true,
    terminal_colors = true,
    -- Add your customizations here
  },
})
```

Enjoy your enhanced GitHub-inspired coding experience! 🎨