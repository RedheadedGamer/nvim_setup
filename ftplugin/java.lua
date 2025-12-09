-- ftplugin/java.lua
-- Java Language Server configuration using nvim-jdtls
-- This file is automatically sourced when a Java file is opened

-- Ensure jdtls is available
local status, jdtls = pcall(require, "jdtls")
if not status then
  vim.notify("nvim-jdtls not found. Install via :Lazy", vim.log.levels.ERROR)
  return
end

-- Determine the OS for path separators and jdtls locations
local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
local home = os.getenv("HOME") or os.getenv("USERPROFILE")
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

-- Cross-platform workspace directory (using vim.fn.fnamemodify for proper path handling)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/eclipse/" .. project_name

-- Get the platform-specific configuration
local config_dir = is_windows and "config_win" or (vim.fn.has("mac") == 1 and "config_mac" or "config_linux")

-- Find the jdtls launcher jar
local function find_jar(pattern)
  local jars = vim.fn.glob(jdtls_path .. "/" .. pattern, false, true)
  if #jars > 0 then
    return jars[1]
  end
  return nil
end

local launcher_jar = find_jar("plugins/org.eclipse.equinox.launcher_*.jar")
if not launcher_jar then
  vim.notify("jdtls launcher jar not found. Install jdtls via :Mason", vim.log.levels.ERROR)
  return
end

-- Get capabilities for cmp integration
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Extended capabilities for jdtls
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- jdtls configuration
local config = {
  -- Command to start jdtls
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher_jar,
    "-configuration", jdtls_path .. "/" .. config_dir,
    "-data", workspace_dir,
  },

  -- This is the root directory for a Java project
  -- jdtls will look for markers like .git, pom.xml, build.gradle, etc.
  root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew", "pom.xml", "build.gradle"}),

  -- Settings for jdtls
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        -- Only set custom formatter if the file exists
        settings = vim.fn.filereadable(vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml") == 1 and {
          url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        } or {},
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
  },

  -- Capabilities for completion
  capabilities = capabilities,

  -- Language server initialization options
  init_options = {
    bundles = {},
    extendedClientCapabilities = extendedClientCapabilities,
  },

  -- Keybindings and other options
  on_attach = function(client, bufnr)
    -- Enable jdtls commands
    jdtls.setup_dap({ hotcodereplace = "auto" })

    local keymap = vim.keymap
    local opts = { buffer = bufnr, silent = true }

    -- Java-specific keybindings (standard LSP bindings are already set in main config)
    keymap.set("n", "<leader>jo", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Organize imports" }))
    keymap.set("n", "<leader>jv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
    keymap.set("v", "<leader>jv", function()
      jdtls.extract_variable(true)
    end, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
    keymap.set("n", "<leader>jc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "Extract constant" }))
    keymap.set("v", "<leader>jc", function()
      jdtls.extract_constant(true)
    end, vim.tbl_extend("force", opts, { desc = "Extract constant" }))
    keymap.set("v", "<leader>jm", function()
      jdtls.extract_method(true)
    end, vim.tbl_extend("force", opts, { desc = "Extract method" }))

    -- Java test commands (requires java-test and java-debug-adapter)
    keymap.set("n", "<leader>jt", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "Test class" }))
    keymap.set("n", "<leader>jn", jdtls.test_nearest_method, vim.tbl_extend("force", opts, { desc = "Test nearest method" }))

    vim.notify("Java LSP (jdtls) attached successfully", vim.log.levels.INFO)
  end,
}

-- Start or attach jdtls
jdtls.start_or_attach(config)
