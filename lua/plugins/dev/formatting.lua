-- plugins/dev/formatting.lua
-- Code formatting with conform.nvim

-- Global auto-format state (off by default; toggle with <leader>tf / <leader>tF)
vim.g.autoformat_enabled = false

return {
  {
    "stevearc/conform.nvim",
    -- Load early so auto-format is ready before the first save.
    -- BufReadPre ensures the plugin is initialised when a file is opened;
    -- BufWritePre is kept as a safety net for new (unsaved) buffers.
    event = { "BufReadPre", "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>fm", desc = "Format buffer manually" },
      { "<leader>fi", desc = "Formatter info" },
      { "<leader>tf", desc = "Toggle auto-format (buffer)" },
      { "<leader>tF", desc = "Toggle auto-format (global)" },
    },
    config = function()
      -- vim.uv is the preferred name since Neovim 0.10; fall back to vim.loop.
      local uv = vim.uv or vim.loop

      -- ── Config-file detection ────────────────────────────────────────────────
      -- Walk up from `dir` (the buffer's directory) and return true when any of
      -- the given file names is found.  The search stops at HOME so it never
      -- escapes the user's project tree.
      local function has_config(names, ctx)
        local dir = (ctx and ctx.dirname) or vim.fn.getcwd()
        local found = vim.fs.find(names, {
          upward = true,
          path   = dir,
          stop   = uv.os_homedir(),
          type   = "file",
          limit  = 1,
        })
        return #found > 0
      end

      -- Config files recognised by each formatter.
      local CONFIG_FILES = {
        ["clang-format"] = { ".clang-format", "_clang-format" },
        prettier = {
          ".prettierrc", ".prettierrc.json", ".prettierrc.js", ".prettierrc.cjs",
          ".prettierrc.mjs", ".prettierrc.yaml", ".prettierrc.yml", ".prettierrc.toml",
          "prettier.config.js", "prettier.config.cjs", "prettier.config.mjs",
          "prettier.config.ts",
        },
        stylua   = { "stylua.toml", ".stylua.toml" },
        shfmt    = { ".editorconfig", ".shfmt" },
        black    = { "pyproject.toml", ".black", "setup.cfg" },
        ruff     = { "ruff.toml", ".ruff.toml", "pyproject.toml" },
      }

      -- ── Formatter availability ───────────────────────────────────────────────
      -- Cache formatter availability checks
      local formatter_cache = {}
      local function is_formatter_available(formatter)
        if formatter_cache[formatter] ~= nil then
          return formatter_cache[formatter]
        end

        if vim.fn.executable(formatter) == 1 then
          formatter_cache[formatter] = true
          return true
        end

        local mason_path = vim.fn.stdpath("data") .. "/mason/bin/" .. formatter
        if vim.fn.executable(mason_path) == 1 then
          formatter_cache[formatter] = true
          return true
        end

        formatter_cache[formatter] = false
        return false
      end

      -- ── formatters_by_ft ─────────────────────────────────────────────────────
      local formatters_by_ft = {}

      if is_formatter_available("stylua") then
        formatters_by_ft.lua = { "stylua" }
      end

      if is_formatter_available("ruff") then
        -- ruff is faster than black for formatting; it can also sort imports.
        formatters_by_ft.python = { "ruff_organize_imports", "ruff_format" }
      elseif is_formatter_available("black") then
        formatters_by_ft.python = { "black" }
        if is_formatter_available("isort") then
          formatters_by_ft.python = { "isort", "black" }
        end
      end

      if is_formatter_available("prettier") then
        for _, ft in ipairs({
          "javascript", "javascriptreact", "typescript", "typescriptreact",
          "html", "css", "scss", "less",
          "json", "jsonc", "yaml", "yml", "markdown", "graphql",
          "vue", "svelte",
        }) do
          formatters_by_ft[ft] = { "prettier" }
        end
      end

      if is_formatter_available("clang-format") then
        for _, ft in ipairs({ "c", "cpp", "objc", "objcpp", "cuda", "proto" }) do
          formatters_by_ft[ft] = { "clang-format" }
        end
      end

      if is_formatter_available("google-java-format") then
        formatters_by_ft.java = { "google-java-format" }
      end

      if is_formatter_available("shfmt") then
        formatters_by_ft.sh   = { "shfmt" }
        formatters_by_ft.bash = { "shfmt" }
        formatters_by_ft.zsh  = { "shfmt" }
      end

      if is_formatter_available("gofmt") then
        formatters_by_ft.go = { "gofmt" }
      end

      if is_formatter_available("asmfmt") then
        formatters_by_ft.asm  = { "asmfmt" }
        formatters_by_ft.nasm = { "asmfmt" }
        formatters_by_ft.s    = { "asmfmt" }
      end

      -- ── Per-formatter settings ───────────────────────────────────────────────
      -- Each formatter's prepend_args is a *function* so it can inspect the
      -- buffer context at format-time.  When a project config file is present
      -- the formatter is invoked without extra flags (the config file wins).
      -- When no config file exists we fall back to tabs of width 4.
      require("conform").setup({
        formatters_by_ft = formatters_by_ft,
        notify_on_error  = false,
        formatters = {
          stylua = {
            prepend_args = function(_, ctx)
              if has_config(CONFIG_FILES.stylua, ctx) then
                return {}
              end
              -- Default: tabs, width 4
              return { "--indent-type", "Tabs", "--indent-width", "4" }
            end,
          },

          ["clang-format"] = {
            prepend_args = function(_, ctx)
              if has_config(CONFIG_FILES["clang-format"], ctx) then
                return {}
              end
              -- Default: LLVM base style overridden to use tabs of width 4
              return {
                "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, "
                  .. "UseTab: ForIndentation, ColumnLimit: 0}",
              }
            end,
          },

          prettier = {
            prepend_args = function(_, ctx)
              if has_config(CONFIG_FILES.prettier, ctx) then
                return {}
              end
              -- Default: tabs, width 4
              return { "--use-tabs", "--tab-width", "4" }
            end,
          },

          black = {
            prepend_args = function(_, ctx)
              if has_config(CONFIG_FILES.black, ctx) then
                return {}
              end
              -- black enforces PEP 8 (4 spaces); tabs are not supported.
              return { "--fast" }
            end,
          },

          shfmt = {
            prepend_args = function(_, ctx)
              if has_config(CONFIG_FILES.shfmt, ctx) then
                return {}
              end
              -- Default: tabs (-i 0 means tabs in shfmt)
              return { "-i", "0" }
            end,
          },

          gofmt = {
            -- gofmt always uses tabs — nothing to override.
          },
        },
        -- Auto-format on save is driven by the autocmd below rather than
        -- conform's built-in format_on_save, so we can honour per-buffer flags.
        format_on_save = false,
      })

      -- ── Helpers ──────────────────────────────────────────────────────────────

      -- Returns true when auto-format is enabled for the current buffer.
      -- Buffer-local flag (vim.b.autoformat_enabled) overrides the global one.
      local function autoformat_enabled_for_buf()
        if vim.b.autoformat_enabled ~= nil then
          return vim.b.autoformat_enabled
        end
        return vim.g.autoformat_enabled
      end

      -- ── Auto-format on save ───────────────────────────────────────────────────
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("ConformAutoFormat", { clear = true }),
        callback = function()
          if autoformat_enabled_for_buf() then
            require("conform").format({ lsp_fallback = true, timeout_ms = 500 })
          end
        end,
      })

      -- ── Keymaps ───────────────────────────────────────────────────────────────

      -- Manual format (higher timeout than auto-save to handle large/complex files)
      vim.keymap.set("n", "<leader>fm", function()
        local ok, err = pcall(function()
          require("conform").format({ lsp_fallback = true, timeout_ms = 3000 })
        end)
        if ok then
          vim.notify("Buffer formatted successfully", vim.log.levels.INFO)
        else
          vim.notify("Format failed: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, { desc = "Format buffer manually" })

      -- Toggle auto-format for the current buffer only
      vim.keymap.set("n", "<leader>tf", function()
        -- Determine current effective state and invert it for this buffer
        local current = autoformat_enabled_for_buf()
        vim.b.autoformat_enabled = not current
        if vim.b.autoformat_enabled then
          vim.notify("Auto-format ENABLED for this buffer", vim.log.levels.INFO)
        else
          vim.notify("Auto-format DISABLED for this buffer", vim.log.levels.WARN)
        end
      end, { desc = "Toggle auto-format (buffer)" })

      -- Toggle auto-format globally (affects all buffers without a local override)
      vim.keymap.set("n", "<leader>tF", function()
        vim.g.autoformat_enabled = not vim.g.autoformat_enabled
        if vim.g.autoformat_enabled then
          vim.notify("Auto-format ENABLED globally", vim.log.levels.INFO)
        else
          vim.notify("Auto-format DISABLED globally", vim.log.levels.WARN)
        end
      end, { desc = "Toggle auto-format (global)" })

      -- Show current formatter info
      vim.keymap.set("n", "<leader>fi", "<cmd>ConformInfo<cr>", { desc = "Formatter info" })
    end,
  },
}
