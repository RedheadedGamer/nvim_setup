# 📚 Comprehensive Plugin Usage Guide

This guide provides detailed instructions on how to use the plugins in this Neovim configuration, including specific keybindings and configuration details.

---

## 🔬 C/C++ Development Guide

### Core Features
- **Enhanced clangd LSP**: Duplicate prevention and advanced background indexing.
- **CMake Integration**: Seamless project building and management.
- **Advanced Debugging**: DAP (Debug Adapter Protocol) support via `codelldb` or `gdb`.
- **Static Analysis**: Integrated `cppcheck` and `clang-tidy`.

### 🛠️ C/C++ Specific Keybindings

#### Project Management (CMake)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cg` | CMakeGenerate | Generate CMake build files |
| `<leader>cb` | CMakeBuild | Build the project |
| `<leader>cr` | CMakeRun | Run the project |
| `<leader>cd` | CMakeDebug | Debug the project |
| `<leader>cc` | CMakeClean | Clean build artifacts |

#### Debugging (nvim-dap)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>db` | ToggleBreakpoint | Toggle breakpoint at current line |
| `<leader>dc` | Continue | Continue execution |
| `<leader>di` | StepInto | Step into function |
| `<leader>do` | StepOver | Step over function |
| `<leader>du` | ToggleUI | Toggle debug UI |
| `<leader>dx` | Terminate | Terminate debug session |

#### Code Navigation & Analysis
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ch` | SwitchHeaderSource | Switch between header and source |
| `<leader>cH` | ToggleInlayHints | Toggle inlay hints |
| `<leader>cA` | ShowAST | Show Abstract Syntax Tree |
| `<leader>cS` | SymbolInfo | Show symbol information |
| `<leader>cl` | LintFile | Lint current C/C++ file |

---

## ☕ Java Development Guide

### Core Features
- **nvim-jdtls**: Full-featured Java LSP with Eclipse JDT support.
- **Workspace Management**: Per-project isolated workspaces.
- **Maven/Gradle**: Automatic project detection and config.
- **Refactoring**: Extract method, variable, constant, and organize imports.

### 🛠️ Java-Specific Keybindings

#### Java Refactoring
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>jo` | OrganizeImports | Organize and clean up imports |
| `<leader>jv` | ExtractVariable | Extract selection to variable |
| `<leader>jc` | ExtractConstant | Extract selection to constant |
| `<leader>jm` | ExtractMethod | Extract selection to method (visual mode) |

#### Java Testing
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>jt` | TestClass | Run all tests in current class |
| `<leader>jn` | TestNearest | Run test method at cursor |

---

## ⌨️ Discovery & Navigation

### Discovery System
This setup uses `which-key` for visual command discovery.
- **Global Keymaps**: `<leader><leader>?`
- **Buffer Keymaps**: `<leader>?`
- **Search Keymaps**: `<leader>fk`

### Navigation (Telescope)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep |
| `<leader>fb` | Find Buffers |
| `<leader>fr` | Recent Files |

---

## ✨ Quality of Life Features

### Text Manipulation (Mini)
- **Surround**: `sa` (add), `sd` (delete), `sr` (replace).
- **Move**: `<M-h/j/k/l>` to move lines or selections.
- **Align**: `ga` to align text.
- **SplitJoin**: `gS` to toggle between split and joined form.

### Git Integration
- **Hunks**: `]c` (next), `[c` (prev), `<leader>hs` (stage), `<leader>hp` (preview).
- **Blame**: `<leader>hb` (line blame), `<leader>tb` (toggle toggle).
- **Diff**: `<leader>hd` (diff this).

### Visual Aids
- **Rainbow Brackets**: Color-coded nested delimiters.
- **Minimap**: `<leader>mm` to toggle the side map.
- **Zen Mode**: `<leader>z` for distraction-free editing.

---

## 🔧 Feature Management

### Disabling Plugins
To disable a plugin, set `enabled = false` in its definition within `lua/plugins/`:
```lua
{
  "author/plugin-name",
  enabled = false,
}
```

### Auto-formatting Toggle
- `<leader>tf`: Toggle for current buffer.
- `<leader>tF`: Toggle globally.

---

*For design rationale and troubleshooting, see [DISCUSSIONS.md](DISCUSSIONS.md).*
