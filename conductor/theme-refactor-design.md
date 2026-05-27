# Theme Refactor Design Spec

## Architecture & Goals
Refactor Neovim's theme management to ensure a lightweight footprint with 100% reliable global transparency. By moving away from plugin-specific transparency flags and relying on a forceful Neovim `autocmd`, we eliminate boilerplate configuration and make adding future themes trivial.

## 1. Trimming the Core Plugin List
The existing `lua/plugins/ui/themes.lua` contains 14 theme packages with extensive repetitive configuration. We will simplify this to strictly the 5 requested families:

*   **TokyoNight** (`folke/tokyonight.nvim`) - Including variants like `tokyonight-night`, `tokyonight-storm`.
*   **Kanagawa** (`rebelot/kanagawa.nvim`) - Specifically requested `kanagawa-dragon`, plus variants.
*   **OneDark** (`olimorris/onedarkpro.nvim`)
*   **Catppuccin** (`catppuccin/nvim`)
*   **Sonokai** (`sainnhe/sonokai`) - Including all variants (`default`, `atlantis`, `andromeda`, `shusia`, `maia`, `espresso`).

**All other theme plugins will be uninstalled/removed from the configuration.** All specific transparency arguments (e.g., `transparent_background = 1`) will be deleted from these remaining setups.

## 2. Global Transparency Autocmd
We will centralize transparency into a robust `autocmd` inside `lua/config/theme.lua` (or `autocmds.lua`).

This command will trigger on the `ColorScheme` event. It will iterate through a comprehensive list of highlight groups and forcefully set their background (`bg`) to `NONE`.

**Targeted Groups:**
*   **Core Editor:** `Normal`, `NormalNC`, `SignColumn`, `LineNr`, `CursorLineNr`, `EndOfBuffer`, `FoldColumn`
*   **Floating Elements:** `NormalFloat`, `FloatBorder`, `FloatTitle`
*   **Pickers (Telescope):** `TelescopeNormal`, `TelescopeBorder`, `TelescopePromptNormal`, `TelescopeResultsNormal`
*   **Menus:** `Pmenu`, `PmenuSel` (ensuring readability while maintaining a clean look)
*   **Panels:** `NvimTreeNormal`, `NeoTreeNormal`, `NeoTreeNormalNC`

## 3. Simplifying Theme Switching/Saving
We will refactor `lua/config/theme.lua` to remove the hardcoded list of ~40+ themes.
*   The `M.get_available_themes()` function will be dynamic based on installed plugins.
*   The auto-saving feature (`theme_config.lua`) will remain but will be simplified to ensure it correctly handles the remaining high-quality themes without the massive fallback lists.
