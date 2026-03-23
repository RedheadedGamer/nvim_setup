-- plugins/lang/c-cpp.lua
-- C/C++ development tools

return {
	-- CMake integration
	{
		"Civitasv/cmake-tools.nvim",
		ft = { "c", "cpp", "cmake" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("cmake-tools").setup({
				cmake_command = "cmake",
				cmake_build_directory = "build",
				cmake_build_directory_prefix = "cmake_build_",
				cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
				cmake_build_options = {},
				cmake_console_size = 10,
				cmake_show_console = "always",
				cmake_dap_configuration = {
					name = "cpp",
					type = "codelldb",
					request = "launch",
				},
			})

			-- CMake keybindings
			local keymap = vim.keymap
			keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
			keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
			keymap.set("n", "<leader>cr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })
			keymap.set("n", "<leader>cd", "<cmd>CMakeDebug<cr>", { desc = "CMake Debug" })
			keymap.set("n", "<leader>cc", "<cmd>CMakeClean<cr>", { desc = "CMake Clean" })
			keymap.set("n", "<leader>ct", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake Select Target" })
			keymap.set("n", "<leader>cT", "<cmd>CMakeSelectBuildType<cr>", { desc = "CMake Select Build Type" })
		end,
	},

	-- Enhanced clangd features
	-- Note: vim-lsp-cxx-highlight is no longer needed as Neovim's built-in LSP
	-- semantic tokens handle C/C++ syntax highlighting natively (Neovim 0.9+).
	-- CurtineIncSw.vim is superseded by clangd_extensions' ClangdSwitchSourceHeader.
	--
	-- clangd is set up HERE (not in the generic lspconfig loop) to avoid
	-- duplicate LSP instances which cause double completions/warnings/hover.
	{
		"p00f/clangd_extensions.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local lsp_servers = require("config.lsp.servers")
			local lsp_keymaps = require("config.lsp.keymaps")
			local lspconfig = require("lspconfig")

			local opts = vim.deepcopy(lsp_servers.servers.clangd or {})

			opts.on_attach = lsp_keymaps.on_attach

			local ok_cmp_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			opts.capabilities = ok_cmp_lsp and cmp_nvim_lsp.default_capabilities()
				or vim.lsp.protocol.make_client_capabilities()

			opts.capabilities.offsetEncoding = { "utf-16" }

			-- ✅ Register clangd with lspconfig directly using your full cmd + opts
			lspconfig.clangd.setup(opts)

			-- ✅ Then set up clangd_extensions for the extra UI features only
			require("clangd_extensions").setup({
				extensions = {
					autoSetHints = true,
					inlay_hints = {
						inline = true,
						only_current_line = false,
						show_parameter_hints = true,
						parameter_hints_prefix = "<- ",
						other_hints_prefix = "=> ",
					},
				},
			})

			vim.keymap.set("n", "<leader>cI", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch Source/Header" })
			vim.keymap.set("n", "<leader>cH", "<cmd>ClangdSetInlayHints<cr>", { desc = "Toggle Inlay Hints" })
			vim.keymap.set("n", "<leader>cA", "<cmd>ClangdAST<cr>", { desc = "Show AST" })
			vim.keymap.set("n", "<leader>cS", "<cmd>ClangdSymbolInfo<cr>", { desc = "Symbol Info" })
			vim.keymap.set("n", "<leader>cM", "<cmd>ClangdMemoryUsage<cr>", { desc = "Memory Usage" })
		end,
	},
}
