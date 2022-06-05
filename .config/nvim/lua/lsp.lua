local M = {}
local common = require("util.common")
local home = os.getenv("HOME")
local lsp = require("lspconfig")
local coq = require("coq")

require("specific.rust")
require("fidget").setup(
{
  text = {
    spinner = "arc"
  }
}
)
require("codelens_extensions").setup()

local auto_group = vim.api.nvim_create_augroup("LSP", {clear = true})

--local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = vim.lsp.protocol.make_client_capabilities();
--Enable (broadcasting) snippet capability for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(
vim.lsp.handlers["textDocument/publishDiagnostics"],
  {
    underline = true,
    virtual_text = false
  }
)

local flags = {
  debounce_text_changes = 150,
  allow_incremental_sync = true
}

local on_attach = function(client, bufnr)
  common.mapb("gD", vim.lsp.buf.declaration, bufnr)
  common.mapb("gd", vim.lsp.buf.definition, bufnr)
  common.mapb("gi", vim.lsp.buf.implementation, bufnr)
  common.mapb("<leader>K", vim.lsp.buf.hover, bufnr)
  common.mapb("gr", vim.lsp.buf.references, bufnr)

  -- modify
  common.mapb("<leader>q", vim.lsp.buf.code_action, bufnr)
  common.mapb("<F2>", vim.lsp.buf.rename, bufnr)

  -- diagnostic
  common.map("ü", vim.diagnostic.open_float, bufnr)
  common.map("ö", vim.diagnostic.goto_next, bufnr)
  common.mapb("<leader>q", vim.lsp.buf.code_action, bufnr)

  -- codelense
  common.mapb("<leader>xl", vim.lsp.codelens.refresh, bufnr)
  common.mapb("<leader>xr", vim.lsp.codelens.run, bufnr)
end

M.setup = function()
  local servers = {
    "vimls",
    "rust_analyzer",
    "clangd",
    "bashls",
    "intelephense",
    "pyright",
    "gopls",
    -- configuration
    "jsonls",
    "yamlls",
    -- web
    "tsserver",
    "html",
    "cssls",
    "cssmodules_ls",
    "tailwindcss",
    "svelte",
    "vuels",
    "angularls"
  }

  for _, server in ipairs(servers) do
    lsp[server].setup(
      {
        on_attach = on_attach,
        flags,
        capabilities
      }
    );
    --lsp[server].setup(coq.lsp_ensure_capabilities());
  end

  -- lua
  local sumneko_root_path = home .. "/tools/lua-language-server"
  local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
  lsp.sumneko_lua.setup(
  {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = on_attach,
    flags,
    capabilities,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";")
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {"vim"}
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
          }
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false
        }
      }
    }
  }
  )
end

vim.api.nvim_create_autocmd(
    {"BufEnter"},
    {
        callback = function()
          jdtls();
        end,
        pattern = "*.java",
        group = auto_group
    }
)

-- java
function jdtls()
  local jar_patterns = {
    '/home/michael/tools/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
    '/home/michael/tools/vscode-java-decompiler/server/*.jar',
    '/home/michael/tools/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar',
    '/home/michael/tools/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar',
    '/home/michael/tools/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar',
    '/dev/testforstephen/vscode-pde/server/*.jar'
  }
  -- npm install broke for me: https://github.com/npm/cli/issues/2508
  -- So gather the required jars manually; this is based on the gulpfile.js in the vscode-java-test repo
  local plugin_path = '/home/michael/tools/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/'
  local bundle_list = vim.tbl_map(
  function(x) return require('jdtls.path').join(plugin_path, x) end,
  {
    'org.eclipse.jdt.junit4.runtime_*.jar',
    'org.eclipse.jdt.junit5.runtime_*.jar',
    'org.junit.jupiter.api*.jar',
    'org.junit.jupiter.engine*.jar',
    'org.junit.jupiter.migrationsupport*.jar',
    'org.junit.jupiter.params*.jar',
    'org.junit.vintage.engine*.jar',
    'org.opentest4j*.jar',
    'org.junit.platform.commons*.jar',
    'org.junit.platform.engine*.jar',
    'org.junit.platform.launcher*.jar',
    'org.junit.platform.runner*.jar',
    'org.junit.platform.suite.api*.jar',
    'org.apiguardian*.jar'
  }
  )
  vim.list_extend(jar_patterns, bundle_list)
  local bundles = {}
  for _, jar_pattern in ipairs(jar_patterns) do
    for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
      if not vim.endswith(bundle, 'com.microsoft.java.test.runner-jar-with-dependencies.jar')
        and not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
        table.insert(bundles, bundle)
      end
    end
  end

  local config = {
    cmd = {
      home .. "/devtools/jdk-17.0.1+12/bin/java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "-javaagent:/home/michael/tools/lombok.jar",
      "-Xbootclasspath/a:/home/michael/tools/lombok.jar",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      home ..
      "/tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
      "-configuration",
      home .. "/tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux/",
      "-data",
      "/tmp/workspace/folder"
    },
    root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew"}),
    settings = {
      java = {
        signatureHelp = {enabled = true},
        contentProvider = {preferred = "fernflower"}
      }
    },
    on_attach = on_attach,
    capabilities,
    flags,
    init_options = {
      bundles = {},
      extendedClientCapabilities = {
        resolveAdditionalTextEditsSupport = true
      }
    }
  }

  require("jdtls").start_or_attach(config)
  --require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

return M
