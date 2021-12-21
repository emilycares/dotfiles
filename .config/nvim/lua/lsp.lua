local M = {}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--Enable (broadcasting) snippet capability for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = false
}
)
local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua "..result.."<cr>", {noremap = true, silent = true})
end

local flags = {
  debounce_text_changes = 150,
}

local custom_attach = function(java)
  mapper('n', 'gD', 'vim.lsp.buf.declaration()')
  mapper('n', '<leader>K', 'vim.lsp.buf.signature_help()')
  mapper('n', 'gr', 'vim.lsp.buf.references()')
  mapper('n', '<F2>', 'vim.lsp.buf.rename()')
  mapper('n', 'ü', 'vim.lsp.diagnostic.show_line_diagnostics()')
  mapper('n', 'ö', 'vim.lsp.diagnostic.goto_next()')

  if java ~= nil then
    mapper('n', 'gd', 'vim.lsp.buf.implementation()')
  else
    mapper('n', 'gd', 'vim.lsp.buf.definition()')
  end
end

M.setup = function()

  local lsp = require('lspconfig')
  local home = os.getenv('HOME')



  local servers = {
    'vimls',
    'rust_analyzer',
    'clangd',
    'bashls',
    'intelephense',
    'pyright',
    -- configuration
    'jsonls',
    'yamlls',
    -- web
    'tsserver',
    'html',
    'cssls',
    'svelte',
    'vuels',
    'angularls',
  }

  for _, server in ipairs(servers) do
    lsp[server].setup({
      on_attach = custom_attach(false),
      flags,
      capabilities,
    });
  end

  -- lua
  local sumneko_root_path = home .. "/tools/lua-language-server"
  local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
  lsp.sumneko_lua.setup({
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    custom_attach = custom_attach,
    flags = flags,
    capabilities,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  });
end

-- java
M.jdtls = function ()
  local config = {
    cmd = {
      '/home/michael/devtools/jdk-17.0.1+12/bin/java',

      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xms1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

      '-jar', '/home/michael/tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
      '-configuration', '/home/michael/tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux/',
      '-data', '/tmp/workspace/folder'
    },

    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

    settings = {
      java = {
      }
    },

    init_options = {
      bundles = {}
    },
    on_attach = custom_attach(true),
    capabilities,
    flags
  }

  require('jdtls').start_or_attach(config)
end

return M;
