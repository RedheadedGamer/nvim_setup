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
	  local lspconfig = require("lspconfig")

      local capabilities = vim.lsp.protocol.make_client_capabilities()

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
			"jdtls", "bashls", "marksman",
		  },
		  automatic_installation = true,

		  handlers = {
			function(server_name)
			-- ❗ SKIP clangd (handled by clangd_extensions)
			  if server_name == "clangd" then
				return
			  end

			  local opts = lsp_servers.servers[server_name] or {}
			  opts.capabilities = capabilities
			  opts.on_attach = lsp_keymaps.on_attach

			  lspconfig[server_name].setup(opts)
		    end,
		  },
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

      -- ── Diagnostics ──────────────────────────────────────────────────────────
      lsp_diagnostics.setup()
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
