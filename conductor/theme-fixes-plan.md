# Theme Switcher & Notification Fixes Plan

## Overview
Restore the professional look of floating windows (Telescope, Notifications, WhichKey) by removing them from the forceful "NONE" transparency list, allowing `winblend` to provide a clean semi-transparent frosted effect instead of raw text-on-text bleeding. Upgrade the Theme Switcher to feature a live preview, and restore the missing Sonokai style variants.

## Tasks

### Task 1: Fix Floating Window Transparency (Text Bleed & Black Boxes)
**Files to modify:** `lua/config/theme.lua`

**Instructions:**
1. In `apply_transparency()`, remove all floating window highlight groups from the `groups` array. This includes:
   - `NormalFloat`, `FloatBorder`, `FloatTitle`
   - `TelescopeNormal`, `TelescopeBorder`, `TelescopePromptNormal`, `TelescopeResultsNormal`
   - `Pmenu`, `PmenuSel`
   - `NoiceNormal`, `NoiceBorder`, `NotifyBackground`, `NotifyBorder`
   - Any `Mini*` or `WhichKey*` groups related to floats or borders.
2. Keep only the core editor and sidebar groups: `Normal`, `NormalNC`, `SignColumn`, `LineNr`, `CursorLineNr`, `EndOfBuffer`, `FoldColumn`, `NvimTreeNormal`, `NeoTreeNormal`, `NeoTreeNormalNC`.

*Why:* Setting floating window backgrounds to `NONE` disables `winblend` and causes the buffer text behind the float to bleed through, making it unreadable. By letting themes provide a solid background for floats, `winblend` (which is already configured in the UI plugins) will create a professional, semi-transparent frosted glass effect without text bleed. This also fixes the "black boxes" in Noice markdown rendering.

### Task 2: Add Sonokai Style Categories
**Files to modify:** `lua/config/theme.lua`

**Instructions:**
1. Update `M.get_available_themes()` to explicitly include the Sonokai variants:
   `sonokai-default`, `sonokai-atlantis`, `sonokai-andromeda`, `sonokai-shusia`, `sonokai-maia`, `sonokai-espresso`.
2. Update `M.apply_theme(theme_name)` to intercept Sonokai variants before calling `vim.cmd`:
   ```lua
   if theme_name:match("^sonokai%-") then
     local style = theme_name:match("^sonokai%-(.+)$")
     vim.g.sonokai_style = style
     theme_name = "sonokai"
   end
   ```

### Task 3: Upgrade Theme Switcher with Live Preview
**Files to modify:** `lua/plugins/ui/utilities.lua`

**Instructions:**
1. In the `telescope.nvim` config block, replace the custom `theme_switcher` implementation with a new one that features a live preview.
2. Create a Telescope picker using `require("telescope.pickers")`, `require("telescope.finders")`, and a custom `previewer`.
3. The previewer should:
   - Call `theme_config.apply_theme(entry.value)` to apply the theme live.
   - Load a sample file (like `init.lua`) into the preview buffer so the user can see syntax highlighting.
4. On `select_default` (Enter): Call `theme_config.save_theme` to persist the choice.
5. On `close` (Esc/q): Restore the `original_theme`.
