local M = {}

local lsp = require('lspconfig')
local home = os.getenv('HOME')
--local completion = require('completion')

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

local custom_attach = function(overlap)
  -- maps
  mapper('n', 'gD', 'vim.lsp.buf.declaration()')
  mapper('n', 'gd', 'vim.lsp.buf.definition()')
  mapper('n', '<leader>K', 'vim.lsp.buf.signature_help()')
  mapper('n', 'gi', 'vim.lsp.buf.implementation()')
  mapper('n', 'gr', 'vim.lsp.buf.references()')
  mapper('n', '<F2>', 'vim.lsp.buf.rename()')
  mapper('n', 'ü', 'vim.lsp.diagnostic.show_line_diagnostics()')
  mapper('n', 'ö', 'vim.lsp.diagnostic.goto_next()')

  if overlap ~= nil  then
    mapper('n', '<leader>q', 'vim.lsp.buf.code_action()')
  end
end

lsp.vimls.setup({
  on_attach = custom_attach,
  flags = flags,
})

local sumneko_root_path = home .. "/tools/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
lsp.sumneko_lua.setup({
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  on_attach = custom_attach,
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
    },}
  })

  lsp.rust_analyzer.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })

  -- shell
  lsp.bashls.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })

  -- web
  lsp.tsserver.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })

  lsp.html.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities = capabilities
  })

  lsp.cssls.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities = capabilities
  })

  lsp.jsonls.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })

  lsp.yamlls.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })

  lsp.svelte.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })

  lsp.vuels.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })

  lsp.angularls.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })

  -- php
  lsp.intelephense.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })

  -- python
  lsp.pyright.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })


  -- jwm
  lsp.kotlin_language_server.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
  })

  lsp.groovyls.setup({
    on_attach = custom_attach,
    flags = flags,
    capabilities,
    cmd = { "java", "-jar", home .. "/tools/groovy-language-server/build/libs/groovy-language-server-all.jar" },
    filetypes = { "groovy", "gradle" }
  })

  M.jdtls = function ()
    local root_markers = {'gradlew', 'pom.xml'}
    local root_dir = require('jdtls.setup').find_root(root_markers)
    local workspace_folder = home .. "/.workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local on_attach_java = function()
      custom_attach(true)

      -- java actions
      mapper('n', '<leader>q', 'require"jdtls".code_action()')
    end

    require('jdtls').start_or_attach({
      cmd = {'launch-jdtls', workspace_folder},
      root_dir,
      on_attach = on_attach_java,
      capabilities,
    })
  end

  local autocmds = {
    lsp = {
      {"FileType",     "java",   "lua require('lsp').jdtls()"};
    };
  }

  function Nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
      vim.api.nvim_command('augroup '..group_name)
      vim.api.nvim_command('autocmd!')
      for _, def in ipairs(definition) do
        local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
        vim.api.nvim_command(command)
      end
      vim.api.nvim_command('augroup END')
    end
  end

  Nvim_create_augroups(autocmds)

  return M
