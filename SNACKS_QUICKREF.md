# snacks.nvim Quick Reference Card

## All 31 Modules - At a Glance

### Core Features (1-10)
| # | Module | Description | Key Feature |
|---|--------|-------------|-------------|
| 1 | dashboard | Start screen | Quick actions on startup |
| 2 | notifier | Notifications | `<leader>nh` history |
| 3 | scroll | Smooth scrolling | Automatic animations |
| 4 | indent | Indent guides | Visual structure |
| 5 | terminal | Terminal | `<leader>t;` toggle |
| 6 | statuscolumn | Status column | Git integration |
| 7 | words | Word navigation | `]]` / `[[` navigate |
| 8 | bigfile | Large files | Auto-optimization |
| 9 | quickfile | Fast loading | Performance boost |
| 10 | animate | Animations | UI smoothness |

### Git & LSP (11-15)
| # | Module | Description | Key Feature |
|---|--------|-------------|-------------|
| 11 | git | Git utilities | `<leader>gb` blame |
| 12 | gitbrowse | Git browse | `<leader>gB` open URL |
| 13 | lazygit | LazyGit | `<leader>gg` open |
| 14 | rename | LSP rename | `<leader>rn` preview |
| 15 | bufdelete | Buffer delete | `<leader>bd` smart |

### UI & Productivity (16-21)
| # | Module | Description | Key Feature |
|---|--------|-------------|-------------|
| 16 | toggle | Toggle options | `<leader>t*` various |
| 17 | zen | Zen mode | `<leader>z` focus |
| 18 | dim | Dim inactive | `<leader>tD` toggle |
| 19 | scratch | Scratch buffer | `<leader>.` create |
| 20 | win | Window utils | Internal utilities |
| 21 | picker | Fuzzy finder | Alternative to Telescope |

### Additional Features (22-27) ⭐ NEW
| # | Module | Description | Key Feature |
|---|--------|-------------|-------------|
| 22 | input | Input UI | Automatic styling |
| 23 | scope | Scope nav | `<leader>sj/sk` jump |
| 24 | profiler | Performance | `<leader>dp` profile |
| 25 | debug | Debug tools | `<leader>di` inspect |
| 26 | styles | UI styling | Consistent theme |
| 27 | backdrop | Backdrop | `<leader>tB` dim |

### Internal/Utility (28-31)
| # | Module | Description | Access |
|---|--------|-------------|--------|
| 28 | util | Utilities | Auto-enabled |
| 29 | config | Config mgmt | Auto-enabled |
| 30 | health | Health check | `:checkhealth snacks` |
| 31 | Internal | Core APIs | Auto-enabled |

---

## Essential Keybindings

### Dashboard & Notifications
```
<leader>sd   Dashboard
<leader>nh   Notification history
<leader>nd   Dismiss all notifications
```

### Terminal
```
<leader>t;   Toggle terminal
<leader>tg   LazyGit in terminal
<C-/>        Quick terminal toggle
<Esc><Esc>   Close terminal
```

### Git Operations
```
<leader>gb   Git blame line
<leader>gB   Open in git browser
<leader>gf   Git file history
<leader>gl   Git log
<leader>gg   Open LazyGit
```

### Navigation
```
]]           Next reference (words)
[[           Previous reference (words)
<leader>sj   Next scope (NEW)
<leader>sk   Previous scope (NEW)
```

### Focus & Productivity
```
<leader>z    Zen mode
<leader>Z    Zen zoom
<leader>.    Scratch buffer
<leader>S    Select scratch buffer
```

### Toggles
```
<leader>tz   Toggle zen mode
<leader>tZ   Toggle zoom
<leader>tD   Toggle dim
<leader>tB   Toggle backdrop (NEW)
<leader>ts   Toggle spell check
<leader>tp   Toggle wrap
<leader>tG   Toggle sign column
```

### Development Tools (NEW)
```
<leader>dp   Toggle profiler
<leader>dP   Show profiler report
<leader>di   Inspect object
<leader>dh   Debug health check
```

### Editing
```
<leader>rn   Rename with preview
<leader>bd   Delete buffer
<leader>bD   Force delete buffer
```

---

## Quick Tips

### Performance Profiling
```vim
" Start profiling
<leader>dp

" Do some work...

" View report
<leader>dP
```

### Scope Navigation
```vim
" In a code file with functions:
<leader>sj    " Jump to next function/scope
<leader>sk    " Jump to previous function/scope
```

### Debug Object
```vim
" Place cursor on variable/object
<leader>di    " Inspect it
```

### Focus Mode Combo
```vim
<leader>z     " Enable zen mode
<leader>tD    " Dim inactive windows
<leader>tB    " Enable backdrop
" Now you have maximum focus!
```

### Check Health
```vim
:checkhealth snacks
```

---

## Module Categories Summary

**Visual Enhancements (8):**
dashboard, notifier, scroll, indent, statuscolumn, animate, styles, backdrop

**Editing & Navigation (4):**
words, rename, bufdelete, scope

**Terminal & Git (4):**
terminal, git, gitbrowse, lazygit

**Focus & Productivity (5):**
zen, dim, scratch, toggle, backdrop

**Performance (2):**
bigfile, quickfile

**Development Tools (3):**
profiler, debug, input

**Utilities (3):**
win, picker, styles

**Internal/Infrastructure (4):**
util, config, health, internal APIs

---

## Color Legend

⭐ NEW - Recently implemented modules (22-27)
🏠 Core - Essential features (1-10)
📦 Git - Git integration (11-13)
🧘 Focus - Productivity & focus (17-19, 27)
⚡ Dev - Development tools (24-25)

---

## Configuration Location

All configuration in: `lua/plugins/init.lua`

- Lines 14-277: Main configuration
- Lines 280-356: Keybindings
- Lines 1000-1050: which-key integration

Full documentation: `SNACKS_GUIDE.md`
Implementation details: `SNACKS_IMPLEMENTATION.md`

---

## Statistics

- **Total Modules:** 31
- **User-Facing Modules:** 27
- **Internal Modules:** 4
- **Total Keybindings:** 39
- **New Keybindings:** 7
- **Feature Coverage:** 100%

---

## Quick Access

Type `<leader>` in Neovim to see all available commands via which-key.

Navigate through groups:
- `<leader>t` - Toggles and terminal
- `<leader>g` - Git operations
- `<leader>s` - Session, scratch, and scope
- `<leader>d` - Debug, diagnostics, and profiler
- `<leader>n` - Notifications

---

© 2024 - Complete snacks.nvim implementation
