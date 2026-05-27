# Neovim Theme Refactor Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Refactor the Neovim theme system to use a global transparency override and trim theme plugins to 5 core families (TokyoNight, Kanagawa, OneDark, Catppuccin, Sonokai).

**Architecture:** Centralize transparency logic into a single `ColorScheme` autocmd that forcefully clears background highlight groups, allowing for a lightweight plugin configuration without repetitive boilerplate.

**Tech Stack:** Neovim (Lua), Lazy.nvim (plugin manager).

---

### Task 1: Trim Theme Plugins

**Files:**
- Modify: `lua/plugins/ui/themes.lua`

- [ ] **Step 1: Update `themes.lua` to keep only the requested theme families**

```lua
-- lua/plugins/ui/themes.lua
return {
  -- TokyoNight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("tokyonight").setup({
        -- Minimal config, transparency handled globally
      })
    end,
  },
  -- OneDark
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedarkpro").setup({})
    end,
  },
  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("kanagawa").setup({})
    end,
  },
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      require("catppuccin").setup({})
    end,
  },
  -- Sonokai
  {
    "sainnhe/sonokai",
    lazy = true,
    config = function()
      -- No global variables needed, transparency handled globally
    end,
  },
}
```

- [ ] **Step 2: Commit changes**

```bash
git add lua/plugins/ui/themes.lua
git commit -m "refactor: trim theme plugins to 5 core families"
```

---

### Task 2: Implement Global Transparency Autocmd

**Files:**
- Modify: `lua/config/theme.lua`

- [ ] **Step 1: Add the transparency function and autocmd to `lua/config/theme.lua`**

```lua
-- Add this inside the M.init() or as a local function in lua/config/theme.lua

local function apply_transparency()
  local groups = {
    "Normal", "NormalNC", "SignColumn", "LineNr", "CursorLineNr",
    "EndOfBuffer", "FoldColumn", "NormalFloat", "FloatBorder",
    "FloatTitle", "TelescopeNormal", "TelescopeBorder",
    "TelescopePromptNormal", "TelescopeResultsNormal",
    "Pmenu", "NvimTreeNormal", "NeoTreeNormal", "NeoTreeNormalNC"
  }
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
  end
end

-- In M.init(), add the autocmd
function M.init()
  -- ... existing load logic ...
  
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ThemeTransparency", { clear = true }),
    callback = apply_transparency,
  })
  
  -- Run once on init to catch the initial theme
  apply_transparency()
end
```

- [ ] **Step 2: Commit changes**

```bash
git add lua/config/theme.lua
git commit -m "feat: implement global transparency override"
```

---

### Task 3: Refactor Theme Discovery and Switching

**Files:**
- Modify: `lua/config/theme.lua`

- [ ] **Step 1: Update `M.get_available_themes()` to be dynamic and cleaner**

```lua
function M.get_available_themes()
  local themes = {
    -- TokyoNight
    "tokyonight", "tokyonight-night", "tokyonight-storm", "tokyonight-moon",
    -- Kanagawa
    "kanagawa", "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus",
    -- OneDark
    "onedark", "onedark_vivid", "onedark_dark",
    -- Catppuccin
    "catppuccin", "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha",
    -- Sonokai
    "sonokai",
  }
  table.sort(themes)
  return themes
end
```

- [ ] **Step 2: Remove unneeded helper functions like `get_github_themes` and `cycle_github_themes`**

- [ ] **Step 3: Commit changes**

```bash
git add lua/config/theme.lua
git commit -m "refactor: simplify theme discovery and switching"
```

---

### Task 4: Verification and Cleanup

**Files:**
- Modify: `lua/config/theme.lua`
- Modify: `lua/config/autocmds.lua` (Check if anything conflicts)

- [ ] **Step 1: Verify transparency works by switching themes manually**
Run: `nvim` then `:colorscheme tokyonight`, `:colorscheme kanagawa-dragon`, etc.
Expected: Background remains transparent for all.

- [ ] **Step 2: Final cleanup of `lua/config/theme.lua`**
Ensure `M.save_theme` and `M.load_theme` work with the new reduced set.

- [ ] **Step 3: Commit final changes**

```bash
git add lua/config/theme.lua
git commit -m "refactor: final theme system cleanup"
```
