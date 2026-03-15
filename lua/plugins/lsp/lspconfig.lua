-- plugins/lsp/lspconfig.lua
-- LSP configuration with Mason, nvim-lspconfig, nvim-cmp, fidget, and lspkind

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      -- Completion engine and sources
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help", -- signature help inside the completion menu
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      -- LSP UI improvements
      "onsails/lspkind.nvim",         -- completion item kind icons
      "j-hui/fidget.nvim",            -- LSP progress notifications (bottom-right spinner)
      -- Neovim Lua support (enables lazydev completions in cmp)
      "folke/lazydev.nvim",
    },
    config = function()
      -- Load LSP configuration modules
      local lsp_servers = require("config.lsp.servers")
      local lsp_keymaps = require("config.lsp.keymaps")
      local lsp_diagnostics = require("config.lsp.diagnostics")

      -- ── fidget.nvim: LSP progress spinner ───────────────────────────────────
      local ok_fidget, fidget = pcall(require, "fidget")
      if ok_fidget then
        fidget.setup({
          progress = {
            display = {
              render_limit = 16,
              done_ttl = 3,
              done_icon = "✓",
              progress_icon = { pattern = "dots", period = 1 },
            },
          },
          notification = {
            window = {
              winblend = 0,
              border = "none",
            },
          },
        })
      end

      -- ── Mason ────────────────────────────────────────────────────────────────
      local ok_mason, mason = pcall(require, "mason")
      if not ok_mason then
        vim.notify("Failed to load mason: " .. tostring(mason), vim.log.levels.ERROR)
        return
      end

      mason.setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        max_concurrent_installers = 5,
      })

      -- ── mason-tool-installer ─────────────────────────────────────────────────
      local ok_installer, installer = pcall(require, "mason-tool-installer")
      if ok_installer then
        installer.setup({
          ensure_installed = {
            -- LSP servers
            "clangd", "lua_ls", "pyright", "ts_ls", "html", "cssls", "jsonls",
            "marksman",
            -- Formatters
            "stylua", "black", "isort", "prettier", "clang-format", "asmfmt", "shfmt",
            -- Linters
            "pylint", "eslint_d", "markdownlint", "shellcheck",
          },
          auto_update = false,
          run_on_start = true,
          start_delay = 3000,
          debounce_hours = 5,
        })
      end

      -- ── mason-lspconfig ──────────────────────────────────────────────────────
      local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
      if ok_mason_lsp then
        mason_lspconfig.setup({
          ensure_installed = {
            "clangd", "lua_ls", "pyright", "ts_ls", "html", "cssls", "jsonls",
            "jdtls", "cmake", "bashls", "marksman",
          },
          automatic_installation = true,
        })
      end

      -- ── mason-nvim-dap ───────────────────────────────────────────────────────
      local ok_dap, dap_mason = pcall(require, "mason-nvim-dap")
      if ok_dap then
        dap_mason.setup({
          ensure_installed = { "codelldb", "debugpy", "js-debug-adapter" },
          automatic_installation = true,
          handlers = {
            function(config)
              require("mason-nvim-dap").default_setup(config)
            end,
            codelldb = function(config)
              config.configurations = {
                {
                  name = "Launch file",
                  type = "codelldb",
                  request = "launch",
                  program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                  end,
                  cwd = "${workspaceFolder}",
                  stopOnEntry = false,
                },
              }
              require("mason-nvim-dap").default_setup(config)
            end,
          },
        })
      end

      -- ── LSP capabilities (cmp integration) ──────────────────────────────────
      local ok_cmp_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if not ok_cmp_lsp then
        vim.notify("Failed to load cmp_nvim_lsp: " .. tostring(cmp_nvim_lsp), vim.log.levels.ERROR)
        return
      end

      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- ── Configure LSP servers ────────────────────────────────────────────────
      -- Servers managed by dedicated language plugins (to avoid duplicate instances)
      local externally_managed = {
        clangd = true,  -- managed by clangd_extensions.nvim in plugins/lang/c-cpp.lua
      }

      local lspconfig = require("lspconfig")
      for server, config in pairs(lsp_servers.servers) do
        if externally_managed[server] then
          goto continue
        end

        local server_cmd = config.cmd and config.cmd[1] or server
        if vim.fn.executable(server_cmd) == 0 then
          vim.notify(
            string.format("LSP server '%s' not found. Install via :Mason", server),
            vim.log.levels.WARN
          )
          goto continue
        end

        config.capabilities = capabilities
        config.on_attach = lsp_keymaps.on_attach
        lspconfig[server].setup(config)

        ::continue::
      end

      -- ── Diagnostics ──────────────────────────────────────────────────────────
      lsp_diagnostics.setup()

      -- ── nvim-cmp completion ──────────────────────────────────────────────────
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"]     = cmp.mapping.select_prev_item(),
          ["<C-j>"]     = cmp.mapping.select_next_item(),
          ["<C-b>"]     = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"]     = cmp.mapping(cmp.mapping.scroll_docs(1),  { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(),       { "i", "c" }),
          ["<C-e>"]     = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ["<CR>"]      = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "lazydev",                  group_index = 0 }, -- give lazydev highest priority
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" }, -- function signature help in completion menu
          { name = "luasnip" },
        }, {
          { name = "buffer",  keyword_length = 3 },
          { name = "path" },
        }),
        -- De-duplicate completion entries from multiple sources
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        formatting = {
          -- lspkind adds VS Code-style kind icons to completion items
          format = lspkind.cmp_format({
            mode = "symbol_text",   -- show icon + text label
            maxwidth = 50,
            ellipsis_char = "…",
            menu = {
              lazydev                  = "[Nvim]",
              nvim_lsp                 = "[LSP]",
              nvim_lsp_signature_help  = "[Sig]",
              luasnip                  = "[Snip]",
              buffer                   = "[Buf]",
              path                     = "[Path]",
            },
          }),
        },
      })
    end,
  },

  -- ── Trouble.nvim: structured diagnostics/references viewer ──────────────────
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        auto_close = false,
        auto_open = false,
        auto_preview = true,
        auto_refresh = true,
        use_diagnostic_signs = true,
      })

      local keymap = vim.keymap
      keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                          { desc = "Toggle Trouble" })
      keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",             { desc = "Buffer Diagnostics" })
      keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                              { desc = "Location List" })
      keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                               { desc = "Quickfix List" })
      keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                  { desc = "Symbols" })
      keymap.set("n", "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",   { desc = "LSP References" })
    end,
  },
}
