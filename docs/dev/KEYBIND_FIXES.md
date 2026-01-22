# Keybind Clash Fixes

## Date: 2025-12-08
## Status: All Conflicts Resolved ✅

---

## Summary

Fixed 4 keybind clashes in the which-key configuration where multiple features were mapped to the same key combination. All conflicting keybindings have been remapped to unique keys, and documentation has been updated.

---

## Conflicts Found and Fixed

### 1. `<leader>tt` Clash ✅

**Conflict:**
- **Snacks Terminal:** Toggle terminal (line 235)
- **Telescope:** Theme switcher (line 1362)

**Resolution:**
- **Terminal toggle:** Changed `<leader>tt` → `<leader>t;`
- **Theme switcher:** Kept `<leader>th` as primary (existing secondary binding)
- **Rationale:** Terminal uses semicolon which is more intuitive for a terminal toggle, theme switcher uses 'h' for 'theme'

**Files Updated:**
- `lua/plugins/init.lua` (lines 235, 1362)
- `lua/plugins/init.lua` which-key spec (line 988)
- `README.md` (lines 844, 911, 993-994)

---

### 2. `<leader>tw` Clash ✅

**Conflict:**
- **Snacks:** Toggle wrap (line 273)
- **Mini.trailspace:** Trim trailing whitespace (line 826)

**Resolution:**
- **Toggle wrap:** Changed `<leader>tw` → `<leader>tp` (for 'toggle paragraph')
- **Trim whitespace:** Kept `<leader>tw` (more commonly used feature)
- **Rationale:** Trim whitespace is more frequently used, wrap toggle uses 'p' for paragraph/wrap

**Files Updated:**
- `lua/plugins/init.lua` (lines 273, 826)
- `lua/plugins/init.lua` which-key spec (lines 966, 982)
- `README.md` (line 995 added tp entry)

---

### 3. `<leader>sd` Clash ✅

**Conflict:**
- **Snacks:** Dashboard (line 224)
- **Mini.sessions:** Delete session (line 901)

**Resolution:**
- **Dashboard:** Kept `<leader>sd` (more important primary feature)
- **Session delete:** Changed `<leader>sd` → `<leader>sD` (capital D)
- **Rationale:** Dashboard is accessed more frequently, capital D differentiates delete operation

**Files Updated:**
- `lua/plugins/init.lua` (line 904)
- `README.md` (line 1002)

---

### 4. `<leader>z` Clash ✅

**Conflict:**
- **Snacks:** Zen Mode (line 260)
- **Mini.misc:** Zoom window (line 2108)

**Resolution:**
- **Zen mode:** Kept `<leader>z` (more commonly used feature)
- **Window zoom:** Changed `<leader>z` → `<leader>mz` (in minimap group)
- **Rationale:** Zen mode is a primary feature, window zoom fits logically under minimap/window group

**Files Updated:**
- `lua/plugins/init.lua` (line 2108)
- `README.md` (lines 440, 1010)

---

## Which-Key Spec Updates

All which-key spec entries have been updated to reflect the new keybindings:

### Updated Entries:
- `<leader>t;` - Toggle terminal (was Open terminal)
- `<leader>th` - Theme switcher (was <leader>tt)
- `<leader>tp` - Toggle wrap (new entry, was <leader>tw)
- `<leader>tw` - Trim trailing whitespace (kept, no longer conflicts)
- `<leader>sD` - Delete session (was <leader>sd)
- `<leader>mz` - Zoom window (was <leader>z)

### Group Mappings:
- `<leader>t` - theme/toggle/terminal ✅
- `<leader>s` - session/snacks ✅
- `<leader>m` - map/minimap ✅
- `<leader>z` - zen/snacks ✅

---

## README Updates

All keybinding tables in README.md have been updated to reflect the new mappings:

### Updated Sections:
1. **Mini Plugins (Quality of Life)** - Updated session keybindings
2. **Key Bindings Reference / Theme & Toggles** - Updated terminal, theme, wrap keybindings
3. **Key Bindings Reference / Session Management** - Updated delete session keybinding
4. **Key Bindings Reference / Minimap & Navigation** - Updated zoom keybinding

---

## Verification

### Conflicts Resolved:
- [x] No duplicate `<leader>tt` keybindings
- [x] No duplicate `<leader>tw` keybindings
- [x] No duplicate `<leader>sd` keybindings
- [x] No duplicate `<leader>z` keybindings

### New Keybindings Verified:
- [x] `<leader>t;` - Terminal toggle (unique)
- [x] `<leader>th` - Theme switcher (unique)
- [x] `<leader>tp` - Toggle wrap (unique)
- [x] `<leader>tw` - Trim whitespace (unique)
- [x] `<leader>sD` - Session delete (unique)
- [x] `<leader>mz` - Window zoom (unique)

### Documentation Updated:
- [x] All which-key spec entries updated
- [x] All README tables updated
- [x] All inline comments added explaining changes

---

## Migration Guide for Users

If you have muscle memory for the old keybindings:

### Old → New Mappings:
| Old Key | Old Function | New Key | Status |
|---------|--------------|---------|--------|
| `<leader>tt` | Terminal toggle | `<leader>t;` | **Changed** |
| `<leader>tt` | Theme switcher | `<leader>th` | **Use this** |
| `<leader>tw` | Toggle wrap | `<leader>tp` | **Changed** |
| `<leader>sd` | Session delete | `<leader>sD` | **Changed** |
| `<leader>z` | Window zoom | `<leader>mz` | **Changed** |

### Recommendations:
1. Use `<leader>?` to see which-key popup with all available keybindings
2. Theme switcher is now consistently `<leader>th` (think "theme")
3. Terminal toggle uses `<leader>t;` (semicolon for terminal)
4. Session delete uses capital D (`<leader>sD`) to distinguish from dashboard

---

## Testing Checklist

- [x] Lua syntax verification (file structure valid)
- [x] Which-key spec syntax verified
- [x] README markdown syntax verified
- [x] All keybinding conflicts resolved
- [x] No new conflicts introduced
- [x] Comments added for all changes

---

## Impact

**Before:**
- 4 keybind clashes causing unpredictable behavior
- Users couldn't access some features due to conflicts
- Which-key would show ambiguous mappings

**After:**
- All keybindings unique and accessible
- Clear, logical grouping of related features
- Better discoverability through which-key
- Improved user experience

---

**Status:** Production Ready ✅
**Breaking Changes:** Yes (keybindings changed, but well-documented)
**User Action Required:** Update muscle memory for 5 changed keybindings
