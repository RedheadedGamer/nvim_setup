# Quick Start Guide

Get started with this Neovim configuration in under 5 minutes!

## TL;DR - Just Install It!

```bash
# One command to install (interactive - will ask Full or Minimal)
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash

# Then start Neovim
nvim
```

Wait for plugins to install, restart Neovim, and you're ready to go! 🚀

## Step-by-Step (First Time Users)

### 1. Choose Your Setup

**Full Setup** = Complete IDE (LSP, debugging, C/C++ tools, 50+ themes)
**Minimal Setup** = Lightweight editor (fast, essential features, 5 themes)

**Not sure?** Start with Minimal, upgrade later if needed.

### 2. Run the Installer

```bash
# Option A: Interactive (recommended for first time)
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash

# Option B: Direct Full install
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash -s -- --full

# Option C: Direct Minimal install
curl -fsSL https://raw.githubusercontent.com/RedheadedGamer/nvim_setup/main/install.sh | bash -s -- --minimal
```

The installer will:
- ✅ Backup your existing config (if any)
- ✅ Clone this configuration
- ✅ Set up Full or Minimal mode
- ✅ Show you what to do next

### 3. Start Neovim

```bash
nvim
```

**Wait!** Don't panic when you see plugins installing. This is normal.
- Lazy.nvim will download all plugins automatically
- This takes 1-2 minutes
- You'll see a window with download progress

### 4. Restart Neovim

After plugins finish installing:
```bash
# Exit Neovim
:q

# Start again
nvim
```

### 5. You're Done! 🎉

Now start using your new setup!

## Essential Keybindings

Press `<Space>` (space bar) and wait 1 second to see all available commands!

### Most Used Commands

| Key | What It Does |
|-----|--------------|
| `<Space>` | Wait 1 sec → see all commands! |
| `<Space>ff` | Find files in your project |
| `<Space>fg` | Search text in all files |
| `<Space>e` | Open file explorer |
| `<Space>th` | Change theme (try different colors!) |
| `gcc` | Comment/uncomment a line |
| `<C-h/j/k/l>` | Move between windows |

### For Full Setup Users (LSP Features)

| Key | What It Does |
|-----|--------------|
| `K` | Show documentation (hover over function/variable) |
| `gd` | Go to definition |
| `gr` | Find all references |
| `<Space>ca` | Show code actions (fixes) |
| `<Space>rn` | Rename variable/function |

## What Next?

### Learn More
- **Full docs:** [README.md](README.md) - Complete guide
- **Installation details:** [INSTALL.md](INSTALL.md) - Advanced installation
- **Plugin guide:** [PLUGIN_GUIDE.md](PLUGIN_GUIDE.md) - How to use all features

### Switch Between Setups

**Switch to Minimal:**
```bash
touch ~/.config/nvim/.minimal_setup
nvim +Lazy\ sync
```

**Switch to Full:**
```bash
rm ~/.config/nvim/.minimal_setup
nvim +Lazy\ sync
```

### Change Theme

In Neovim:
```vim
" Press Space then t then h
<Space>th
```

Or manually:
```vim
:colorscheme dracula
:colorscheme gruvbox
:colorscheme tokyonight
```

### Install Dependencies (Full Setup)

If you installed Full setup, install these for best experience:

```bash
# Ubuntu/Debian
sudo apt install nodejs npm python3 python3-pip ripgrep

# macOS
brew install node python ripgrep

# Arch Linux
sudo pacman -S nodejs npm python python-pip ripgrep
```

### Get Help

Having issues? Check:

1. **Health check:**
   ```vim
   :checkhealth
   ```

2. **Plugin status:**
   ```vim
   :Lazy
   ```

3. **Read troubleshooting:** [INSTALL.md - Troubleshooting](INSTALL.md#troubleshooting)

4. **Open an issue:** [GitHub Issues](https://github.com/RedheadedGamer/nvim_setup/issues)

## Common First-Time Questions

### "It's downloading a lot of stuff, is this normal?"

✅ **Yes!** That's lazy.nvim installing all plugins. Wait for it to finish.

### "I see errors about LSP servers"

This is normal if you:
- Chose Minimal setup (no LSP)
- Haven't installed Node.js/Python yet (Full setup needs these)

Solution for Full setup:
```vim
:Mason
" Install servers you need
```

### "How do I exit Neovim?"

```vim
:q          " Quit
:wq         " Save and quit
:q!         " Quit without saving
```

Or use: `<Space>q` (configured in this setup)

### "Where's the mouse support?"

✅ Mouse works by default! Click anywhere, scroll, select text.

### "How do I copy/paste?"

```vim
" Copy (visual mode)
v                   " Enter visual mode
[select text]       " Use hjkl or arrow keys
y                   " Yank (copy)

" Paste
p                   " Paste after cursor

" Copy to system clipboard
<Space>y           " Copy selection

" Paste from system clipboard
<Space>p           " Paste
```

Or just use your mouse with Ctrl+C / Ctrl+V!

### "I want to customize it"

Edit these files:
- `~/.config/nvim/lua/config/options.lua` - Editor settings
- `~/.config/nvim/lua/config/keymaps.lua` - Key bindings
- `~/.config/nvim/lua/plugins/init.lua` - Add/remove plugins

After editing:
```vim
:source %          " Reload current file
" Or restart Neovim
```

### "How do I uninstall?"

```bash
# Backup first (just in case)
mv ~/.config/nvim ~/.config/nvim.backup

# Remove all Neovim data
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

## Tips for Success

1. **Start with basics:** Don't try to learn everything at once
2. **Use which-key:** Press `<Space>` and wait to see commands
3. **Practice motions:** hjkl for movement, ciw to change word, dd to delete line
4. **Read error messages:** They're usually helpful
5. **Check :checkhealth:** When something doesn't work
6. **Ask for help:** GitHub issues are welcome!

## Next Steps

Now that you're set up:

1. **Try opening a file:**
   ```bash
   nvim myfile.txt
   ```

2. **Practice basic editing:**
   - Press `i` to insert text
   - Press `<Esc>` to exit insert mode
   - Type `:w` to save
   - Type `:q` to quit

3. **Explore features:**
   - Press `<Space>ff` to find files
   - Press `<Space>th` to try different themes
   - Press `<Space>e` to open file explorer

4. **Learn as you go:**
   - Use `:help` for built-in help
   - Check [README.md](README.md) for keybindings
   - Read [PLUGIN_GUIDE.md](PLUGIN_GUIDE.md) when you need advanced features

## Welcome to Neovim! 🎉

You're now part of a powerful, extensible editor community. Take your time learning, and enjoy the journey!

**Remember:** Press `<Space>` and wait to see all available commands. This is your friend! 🚀

---

**Need help?** Open an issue at https://github.com/RedheadedGamer/nvim_setup/issues

**Want to learn more?** Check out:
- [README.md](README.md) - Main documentation
- [INSTALL.md](INSTALL.md) - Installation guide
- [PLUGIN_GUIDE.md](PLUGIN_GUIDE.md) - Plugin usage guide
