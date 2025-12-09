-- plugins/ui/snacks.lua
-- Snacks.nvim - Modern all-in-one plugin by folke

-- Utility: Detect appropriate shell for terminal
local function detect_shell()
  local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
  
  if is_windows then
    -- Prefer PowerShell Core; fall back to Windows PowerShell
    if vim.fn.executable("pwsh") == 1 then
      return { "pwsh", "-NoLogo" }
    else
      return { "powershell.exe", "-NoLogo" }
    end
  else
    -- Prefer fish; fall back to user's default shell
    if vim.fn.executable("fish") == 1 then
      return { "fish", "-i" }
    else
      return vim.env.SHELL or vim.o.shell or "sh"
    end
  end
end

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- Enable/disable features globally
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      
      -- Dashboard replacing mini.starter
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
            { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
            { icon = " ", key = "c", desc = "Config", action = function() 
              -- SECURITY FIX: Use safe API instead of concatenating into vim.cmd
              vim.api.nvim_cmd({ cmd = 'edit', args = { vim.fn.stdpath("config") .. "/init.lua" } }, {})
            end },
            { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('mini.sessions').select()" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = [[
██████╗  ██████╗  ██████╗ ██╗██╗  ██╗ █████╗ ████████╗
██╔══██╗██╔═══██╗██╔═══██╗██║██║ ██╔╝██╔══██╗╚══██╔══╝
██████╔╝██║   ██║██║   ██║██║█████╔╝ ███████║   ██║   
██╔══██╗██║   ██║██║   ██║██║██╔═██╗ ██╔══██║   ██║   
██║  ██║╚██████╔╝╚██████╔╝██║██║  ██╗██║  ██║   ██║   
╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   
          ]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      
      -- Notifier replacing basic vim.notify
      notifier = {
        enabled = true,
        timeout = 3000, -- MAGIC NUMBER: 3 seconds notification display time
        width = { min = 40, max = 0.4 }, -- min chars, max 40% of screen
        height = { min = 1, max = 0.6 }, -- min lines, max 60% of screen
        margin = { top = 0, right = 1, bottom = 0 },
        padding = true,
        sort = { "level", "added" },
        icons = {
          error = " ",
          warn = " ",
          info = " ",
          debug = " ",
          trace = " ",
        },
        style = "compact",
      },
      
      -- Scroll animations replacing mini.animate
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 250 }, -- MAGIC: 15ms per step, 250ms total scroll time
          easing = "linear",
        },
        spamming = 10, -- MAGIC: Ignore rapid scroll events within 10ms
        filter = function(buf)
          return vim.bo[buf].buftype ~= "terminal"
        end,
      },
      
      -- Enhanced indent guides
      indent = {
        enabled = true,
        char = "│",
        blank = "│",
        only_scope = false,
        only_current = false,
        scope = {
          enabled = true,
          char = "│",
          underline = false,
        },
        -- Disable indent guides in specific buffer types
        filter = function(buf)
          local buftype = vim.bo[buf].buftype
          local filetype = vim.bo[buf].filetype
          -- Disable for terminal, dashboard, and special buffers
          return buftype ~= "terminal" 
            and filetype ~= "snacks_dashboard"
            and filetype ~= "dashboard"
            and buftype ~= "nofile"
        end,
      },
      
      -- Terminal management
      terminal = {
        enabled = true,
        shell = detect_shell(),
        win = {
          style = "terminal",
          position = "bottom",
          width = 1.0,
          height = 0.4,
          border = "single",
          title = " Terminal ",
          title_pos = "center",
        },
      },

      -- Enhanced statuscolumn
      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" },
        right = { "fold", "git" },
        folds = {
          open = true,
          git_hl = true,
        },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
      },
      
      -- Enhanced word motions
      words = {
        enabled = true,
        debounce = 200,
        notify_jump = false,
        notify_end = true,
        foldopen = true,
        jumplist = true,
        modes = { "n", "i", "c" },
      },
      
      -- General animation framework
      animate = {
        enabled = true,
        duration = 20, -- MAGIC: 20ms animation duration for UI elements
        easing = "linear",
        fps = 60, -- MAGIC: 60 frames per second for smooth animations
      },
      
      -- Git utilities
      git = {
        enabled = true,
      },
      
      -- Git browse - open URLs in browser
      gitbrowse = {
        enabled = true,
      },
      
      -- LazyGit integration
      lazygit = {
        enabled = true,
        configure = true,
      },
      
      -- LSP rename with preview
      rename = {
        enabled = true,
      },
      
      -- Smart buffer deletion
      bufdelete = {
        enabled = true,
      },
      
      -- Toggle utilities
      toggle = {
        enabled = true,
      },
      
      -- Zen mode for distraction-free coding
      zen = {
        enabled = true,
        zoom = {
          width = 0.85,
          height = 0.9,
        },
        toggles = {
          dim = true,
          git_signs = false,
          mini_diff = false,
          diagnostics = false,
          inlay_hints = false,
        },
      },
      
      -- Dim inactive windows
      dim = {
        enabled = true,
      },
      
      -- Scratch buffer for quick notes
      scratch = {
        enabled = true,
      },
      
      -- Window utilities
      win = {
        enabled = true,
      },
      
      -- ============================================================================
      -- ADDITIONAL SNACKS MODULES (22-31)
      -- ============================================================================
      
      -- Input - Enhanced vim.ui.input replacement
      input = {
        enabled = true,
        icon = " ",
        icon_pos = "left",
        prompt_pos = "title",
      },
      
      -- Scope - Scope highlighting and management
      scope = {
        enabled = true,
        -- Automatically enable scope for supported buffers
        filter = function(buf)
          return vim.bo[buf].buftype == ""
        end,
      },
      
      -- Profiler - Performance profiling utilities
      profiler = {
        enabled = true,
        -- Runtime profiling for performance analysis
      },
      
      -- Debug - Debug utilities and helpers
      debug = {
        enabled = true,
        -- Debug tools for plugin development
      },
      
      -- Styles - UI styling and theming utilities
      styles = {
        enabled = true,
        -- Consistent styling across snacks components
      },
      
      -- Backdrop - Background dimming for focused windows
      backdrop = {
        enabled = true,
        transparent = true,
        blend = 60,
      },
      
      -- Explorer - File explorer (alternative to mini.files)
      explorer = {
        enabled = true,
        -- File explorer with tree view
      },
    },
    
    -- Keybindings for all snacks features
    keys = {
      -- Dashboard
      { "<leader>sd", function() require("snacks").dashboard.open() end, desc = "Dashboard" },
      
      -- Notifications
      { "<leader>nh", function() require("snacks").notifier.show_history() end, desc = "Notification History" },
      { "<leader>nd", function() require("snacks").notifier.dismiss() end, desc = "Dismiss Notifications" },
      
      -- Terminal
      { "<leader>t;", function() require("snacks").terminal.toggle() end, desc = "Toggle Terminal" },
      { "<leader>tg", function() require("snacks").terminal("lazygit") end, desc = "LazyGit" },
      { "<C-/>", function() require("snacks").terminal.toggle() end, desc = "Toggle Terminal", mode = { "n", "t" } },
      { "<C-_>", function() require("snacks").terminal.toggle() end, desc = "Toggle Terminal", mode = { "n", "t" } },
      
      -- Word navigation
      { "]]", function() require("snacks").words.jump(vim.v.count1) end, desc = "Next Reference" },
      { "[[", function() require("snacks").words.jump(-vim.v.count1) end, desc = "Previous Reference" },
      
      -- Git utilities
      { "<leader>gb", function() require("snacks").git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gB", function() require("snacks").gitbrowse() end, desc = "Git Browse" },
      { "<leader>gf", function() require("snacks").lazygit.log_file() end, desc = "LazyGit File History" },
      { "<leader>gl", function() require("snacks").lazygit.log() end, desc = "LazyGit Log" },
      { "<leader>gg", function() require("snacks").lazygit() end, desc = "LazyGit" },
      
      -- LSP rename with preview
      { "<leader>rn", function() require("snacks").rename() end, desc = "Rename (with preview)" },
      
      -- Buffer delete
      { "<leader>bd", function() require("snacks").bufdelete() end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("snacks").bufdelete({ force = true }) end, desc = "Delete Buffer (force)" },
      
      -- Zen mode
      { "<leader>z", function() require("snacks").zen() end, desc = "Zen Mode" },
      { "<leader>Z", function() require("snacks").zen.zoom() end, desc = "Zen Zoom" },
      
      -- Scratch buffer
      { "<leader>.", function() require("snacks").scratch() end, desc = "Scratch Buffer" },
      { "<leader>S", function() require("snacks").scratch.select() end, desc = "Select Scratch" },
      
      -- Toggles
      { "<leader>tz", function() require("snacks").toggle.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>tZ", function() require("snacks").toggle.zoom() end, desc = "Toggle Zoom" },
      { "<leader>tD", function() require("snacks").toggle.dim() end, desc = "Toggle Dim" },
      { "<leader>tG", function() require("snacks").toggle.option("signcolumn", { on = "yes", off = "no" }) end, desc = "Toggle Sign Column" },
      { "<leader>ts", function() require("snacks").toggle.option("spell") end, desc = "Toggle Spell Check" },
      { "<leader>tp", function() require("snacks").toggle.option("wrap") end, desc = "Toggle Wrap" },
      
      -- Profiler keybindings
      { "<leader>dp", function() require("snacks").profiler.toggle() end, desc = "Toggle Profiler" },
      { "<leader>dP", function() require("snacks").profiler.report() end, desc = "Profiler Report" },
      
      -- Debug utilities
      { "<leader>di", function() require("snacks").debug.inspect() end, desc = "Inspect Object" },
      { "<leader>dh", function() require("snacks").debug.health() end, desc = "Debug Health" },
      
      -- Backdrop toggle
      { "<leader>tB", function() require("snacks").toggle.backdrop() end, desc = "Toggle Backdrop" },
      
      -- Scope navigation
      { "<leader>sj", function() require("snacks").scope.jump_next() end, desc = "Next Scope" },
      { "<leader>sk", function() require("snacks").scope.jump_prev() end, desc = "Previous Scope" },
      
      -- Explorer
      { "<leader>E", function() require("snacks").explorer() end, desc = "Explorer (snacks)" },
    },
    
    -- Init function for additional setup
    init = function()
      -- SECURITY FIX: Replace vim.notify with fallback protection
      local ok, snacks = pcall(require, "snacks")
      if ok and snacks.notifier then
        local original_notify = vim.notify
        vim.notify = function(msg, level, opts)
          -- Try snacks notifier first, fallback to original if it fails
          local success = pcall(snacks.notifier.notify, msg, level, opts)
          if not success then
            original_notify(msg, level, opts)
          end
        end
      end
      
      -- Setup snacks autocmds
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Enable dim by default on startup
          local ok_snacks, snacks_module = pcall(require, "snacks")
          if ok_snacks and snacks_module.dim then
            vim.schedule(function()
              snacks_module.dim.enable()
            end)
          end
        end,
      })
    end,
  },
}
