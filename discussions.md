# Discussions and Improvement Proposals

Deep dive notes on where this Neovim setup shines today and how it could evolve. Suggestions span plugin alternatives, architectural tweaks, performance, testing, and documentation. File paths refer to the current repo layout for quick cross-reference.

## Baseline Snapshot (Today)
- Plugin stack is centered on `lazy.nvim` bootstrap in `init.lua` with modular specs under `lua/plugins/**/*.lua`.
- UI/UX relies heavily on the full snacks.nvim surface plus the mini.nvim ecosystem (27 plugins) and Telescope (`lua/plugins/ui/*`, `lua/plugins/editor/*`).
- LSP/completion pipeline is built on Mason + `nvim-lspconfig`, `nvim-cmp`, fidget, and lazydev (`lua/plugins/lsp/lspconfig.lua`, `lua/config/lsp/servers.lua`); clangd is handled via `clangd_extensions` (`lua/plugins/lang/c-cpp.lua`).
- Formatting/linting/debugging handled by conform.nvim, nvim-lint, and nvim-dap with Mason installers (`lua/plugins/dev/*.lua`).
- Language extras exist for C/C++, Java (ftplugin-driven), LaTeX, Markdown (`lua/plugins/lang/*`, `ftplugin/java.lua`).
- Two installation modes (full/minimal) are gated by `.minimal_setup` marker (`init.lua`, `README.md`).

## Plugin Alternatives & Optional Swaps
- **Plugin management & reproducibility**
  - Add `lazy-lock.json` (not currently tracked) to pin versions and reduce upgrade drift; keep `lazy restore` docs updated.
  - Consider `lazy.nvim` local mirrors for CI or corporate networks; document `LAZY_STDPATH` overrides for sandboxed machines.
- **UI/Notifications**
  - snacks.nvim is all-in; consider disabling unused modules or swapping message routing to `noice.nvim` for fine-grained LSP/cmdline UIs.
  - For statusline/tabline, mini.statusline is lightweight; alternatives include `heirline.nvim` (full control) or `lualine.nvim` (rich ecosystem) if more segment logic is needed.
- **File explorer**
  - Current: mini.files/snacks picker. Alternatives: `oil.nvim` (buffer-as-directory, minimal deps) or `neo-tree.nvim` (multi-source git/LSP diagnostics), each with better remote/SSH handling than `:edit`-based flows.
- **Fuzzy finding**
  - Telescope core is present; add `telescope-fzf-native.nvim` or swap to `fzf-lua` for lower latency on large repos. For structural search, `aerial.nvim` or `outline.nvim` integrates well with LSP symbols.
- **Completion/snippets**
  - nvim-cmp is standard; consider `blink.cmp` for lower overhead and VS Code-like UX, or `cmp-git`/`cmp-dap` sources to widen contexts. If AI completions are desired, keep them as optional specs (e.g., `codeium.nvim`, `supermaven-nvim`) behind `enabled` flags to avoid hard dependencies.
  - Snippets: LuaSnip is fine; `friendly-snippets` is loaded. If startup size matters, gate snippet loading per filetype.
- **LSP/tooling**
  - Mason-centric flow works; offer non-Mason path for Nix/Brew/asdf users by honoring `$PATH` before install prompts and documenting `:MasonUpdate` cadence.
  - TypeScript: `ts_ls` could be upgraded to `typescript-tools.nvim` for better inlay hints/organize-imports. Python: consider `ruff_lsp` alongside/over `pyright` for lint+format speed.
  - Lua: add `neodev.nvim` (or ensure lazydev’s coverage) plus `luacheck` integration for stricter diagnostics.
  - Diagnostics UI: Trouble is present; alternatives include snacks’ diagnostics drawer or `lspsaga.nvim` if users want hover/code action popups.
- **Formatting & linting**
  - conform.nvim is configured with smart defaults; add `none-ls.nvim` (ex-null-ls) only if you need non-CLI providers (e.g., eslint language service, spell). For shell, `shellcheck` LSP could complement `nvim-lint`.
  - For project-specific defaults, add `.editorconfig` examples and mention how conform detects config files (`lua/plugins/dev/formatting.lua` already has `has_config` helper).
- **Testing & coverage**
  - Not currently installed: add `neotest` with adapters for Python/Jest/Go and `nvim-coverage` for quick feedback (called out in README “Possible Improvements”).
- **Git**
  - Current: gitsigns + fugitive + mini.diff. Optional: `neogit` (Magit-like), `gitlinker.nvim` (shareable URLs), `git-messenger.vim` (inline blame popups).
- **Debugging**
  - nvim-dap + dap-ui are present; `one-small-step-for-vimkind` adds Lua debugging, `dap-go`/`dap-python` adapters give language-aware defaults. Use `nvim-dap-virtual-text` for inline values if desired.
- **Terminal & tasks**
  - snacks terminal works; `toggleterm.nvim` remains a battle-tested alternative with session persistence and direction presets.
- **Docs/notes/PKM**
  - Markdown preview uses `markdown-preview.nvim`; for in-editor rendering consider `render-markdown.nvim` or `marksman` + `glow.nvim` in terminal.
  - If personal knowledge base is desired, `obsidian.nvim` or `neorg` can be layered behind an opt-in spec.

## Codebase & Architecture Improvements
- **Version pinning & release process**: Track `lazy-lock.json`, add a short “upgrade playbook” describing when to run `:Lazy sync` vs `:Lazy restore`.
- **Spec composition**: Use `enabled = not is_minimal` guards inside plugin specs instead of module-level branching to keep single source of truth and reduce duplication between `lua/plugins/init.lua` and `lua/plugins/minimal.lua`.
- **Common helpers**: The repeated `pcall(require, ...)` and `vim.notify` patterns (e.g., in `lua/plugins/lsp/lspconfig.lua`) could live in `lua/config/utils.lua` to keep specs declarative and cut noise.
- **Treesitter config**: switch to `require("nvim-treesitter.configs").setup` (currently calling `require("nvim-treesitter").setup` in `lua/plugins/editor/treesitter.lua`) to align with upstream API and avoid future deprecation warnings.
- **LSP defaults**: Centralize capabilities/on_attach in `lua/config/lsp/servers.lua` and export helpers so language-specific modules (clangd, jdtls) share consistent keymaps and inlay-hint toggles.
- **OS detection**: `init.lua` sets globals for `is_windows/is_mac/is_linux`; moving this into a module (e.g., `config.platform`) would avoid globals and allow reuse in installers, formatters, and ftplugins.
- **Error handling & logging**: Introduce a thin logging wrapper (e.g., `config.log`) to route errors to `vim.notify` with levels, useful for Mason failures or formatter availability checks.
- **Modular toggles**: Use `cond` fields in lazy specs for modules like snacks’ optional pieces or heavy language servers; improves minimal/full UX without separate code paths.
- **Docs alignment**: Keep README feature lists in sync with actual specs (e.g., mention that clangd is skipped in `mason-lspconfig` because `clangd_extensions` owns it, per `lua/plugins/lsp/lspconfig.lua`).

## Performance & Startup Tuning
- **Profile regularly**: Use `:Lazy profile` and snacks’ profiler to identify slow modules; consider deferring rarely-used snacks modules to command triggers.
- **Treesitter footprint**: `ensure_installed` is a fixed list; move to `ensure_installed = "maintained"` or gate uncommon parsers behind project detection to cut install time for minimal users.
- **Telescope speed**: Add `telescope-fzf-native` or `ripgrep`-powered `vimgrep_arguments` tuning; disable devicons in headless/SSH for speed.
- **Snacks scaling**: Disable animations/backdrop effects for low-resource machines; expose a simple `NVIM_LIGHT_MODE=1` env toggle.
- **Cache/compilation**: lazy.nvim cache is on; optionally add `hot-reload` of compiled Lua via `vim.loader.enable()` (Neovim 0.9+) if not already set.

## LSP, Completion, and Formatting Pipeline
- **Capabilities**: Extend `capabilities` with foldingRange and semanticTokens to improve server features; ensure cmp sources include `path`/`buffer` only when relevant to reduce noise.
- **TypeScript/JS**: Offer `typescript-tools.nvim` (or `vtsls`) with project-local tsserver binary detection; map organize-imports and file-wide fixes.
- **Python**: Add optional `ruff_lsp` and `pylance` paths; document how to prefer `ruff_format` over `black` in `lua/plugins/dev/formatting.lua`.
- **Lua**: Add `workspace.checkThirdParty = false` and `hint.enable = true` for `lua_ls` to reduce diagnostics noise; expose a `stylua.toml` template matching conform defaults.
- **Shell**: Consider `bash-language-server` config tweaks (globPattern, shellcheck path) and add fish/zsh ft detection if needed.
- **Diagnostics surfacing**: Offer inline virtual text toggles and Trouble/loclist sync so users can pick light/heavy UIs.

## Language-Specific Ideas
- **C/C++**: Document recommended `.clangd` with project-specific flags and `compile_commands.json` integration; add a helper command to run `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON` and symlink outputs. Provide presets for CUDA/OpenMP if those flags are common (`lua/config/lsp/servers.lua` currently passes `--extra-arg=-fopenmp` globally).
- **Java**: Package java-debug and java-test bundles with Mason and auto-attach in `ftplugin/java.lua`; add workspace-per-project cache cleanup and `jdtls` formatter profile selection per repo.
- **Markdown/Docs**: Offer in-buffer rendering (`render-markdown.nvim`) and a lint path via `marksman`/`markdownlint` hooked into nvim-lint.
- **LaTeX**: Document forward/inverse search setups (zathura/skim/sumatra) and latexmk config; consider `ltex-ls` for grammar checking.

## Testing, CI, and Quality Gates
- **Headless smoke tests**: Add a `just`/Make target that runs `nvim --headless "+Lazy! sync" "+qa"` and `:checkhealth` subsets to ensure boot correctness on CI.
- **Lint/format**: Add stylua/luacheck config and a GitHub Action to run them; align conform defaults with stylua.toml to avoid drift.
- **Installer verification**: Extend `verify_setup.sh`/`.ps1` to check for Neovim version >= required, and optionally perform a dry-run `nvim --headless -c "lua print('ok')" +q`.
- **Docs freshness**: Add a short checklist to PR template (e.g., “updated screenshots? updated keybind tables?”) so README/QUICKSTART stay in sync with config changes.

## Documentation & Onboarding
- Provide a “full vs minimal” delta table sourced from code (generated from plugin specs) to reduce manual drift.
- Add short “common tasks” snippets (format toggle, theme persistence, project switching) linked back to their implementations (`lua/plugins/dev/formatting.lua`, `lua/config/theme.lua`, `plugins/editor/navigation.lua`).
- Include guidance for corporate/proxy environments (offline Mason install, git protocol changes, mirror registries).
- Add troubleshooting for Windows paths in `ftplugin/java.lua` and clangd driver queries (already enumerated) with examples of overriding via local `.nvim.lua`.

## Quick Wins (Low Effort, High Value)
- Commit `lazy-lock.json` for reproducible installs.
- Swap Treesitter setup call to `nvim-treesitter.configs` to silence future API warnings.
- Add `telescope-fzf-native` for instant search responsiveness.
- Provide a starter `stylua.toml` matching conform’s tab-width defaults for consistency across editors.
