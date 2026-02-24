-- plugins/lsp/lspconfig.lua
-- LSP configuration with Mason, nvim-lspconfig, and nvim-cmp

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      -- Load LSP configuration modules
      local lsp_servers = require("config.lsp.servers")
      local lsp_keymaps = require("config.lsp.keymaps")
      local lsp_diagnostics = require("config.lsp.diagnostics")
      
      -- Setup Mason
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
            package_uninstalled = "✗"
          }
        },
        max_concurrent_installers = 5,
      })
      
      -- Setup mason-tool-installer
      local ok_installer, installer = pcall(require, "mason-tool-installer")
      if ok_installer then
        installer.setup({
          ensure_installed = {
            "clangd", "lua_ls", "pyright", "ts_ls", "html", "cssls", "jsonls",
            "stylua", "black", "isort", "prettier", "clang-format", "asmfmt",
            "pylint", "eslint_d", "cpplint",
            "markdownlint", "shellcheck", "shfmt",
          },
          auto_update = false,
          run_on_start = true,
          start_delay = 3000,
          debounce_hours = 5,
        })
      end
      
      -- Setup mason-lspconfig
      local ok_lspconfig, lspconfig = pcall(require, "mason-lspconfig")
      if ok_lspconfig then
        lspconfig.setup({
          ensure_installed = {
            "clangd", "lua_ls", "pyright", "ts_ls", "html", "cssls", "jsonls",
            "jdtls", "cmake", "bashls", "marksman",
          },
          automatic_installation = true,
        })
      end

      -- Setup mason-nvim-dap
      local ok_dap, dap_mason = pcall(require, "mason-nvim-dap")
      if ok_dap then
        dap_mason.setup({
          ensure_installed = {
            "codelldb", "debugpy", "js-debug-adapter",
          },
          automatic_installation = true,
          handlers = {
            function(config)
              require('mason-nvim-dap').default_setup(config)
            end,
            codelldb = function(config)
              config.configurations = {
                {
                  name = "Launch file",
                  type = "codelldb",
                  request = "launch",
                  program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                  end,
                  cwd = '${workspaceFolder}',
                  stopOnEntry = false,
                },
              }
              require('mason-nvim-dap').default_setup(config)
            end,
          },
        })
      end

      -- Get capabilities for cmp integration
      local ok_cmp_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if not ok_cmp_lsp then
        vim.notify("Failed to load cmp_nvim_lsp: " .. tostring(cmp_nvim_lsp), vim.log.levels.ERROR)
        return
      end
      
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Configure LSP servers
      -- NOTE: Uses vim.lsp.config API (Neovim 0.11+)
      -- This is the recommended modern approach for LSP configuration
      -- For older Neovim versions, use require('lspconfig')[server].setup(config)
      for server, config in pairs(lsp_servers.servers) do
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
        vim.lsp.config[server] = config
        
        ::continue::
      end

      -- Setup diagnostics
      lsp_diagnostics.setup()

      -- Setup completion (nvim-cmp)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      require("luasnip.loaders.from_vscode").lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  },
  
  -- Trouble.nvim for diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      require("trouble").setup({
        auto_close = false,
        auto_open = false,
        auto_preview = true,
        auto_refresh = true,
      })
      
      local keymap = vim.keymap
      keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Trouble" })
      keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
      keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
      keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List" })
      keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols" })
      keymap.set("n", "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP References" })
    end,
  },
}
