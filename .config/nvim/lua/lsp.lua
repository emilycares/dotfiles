local M = {}
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

local lsp = require('lspconfig')
--local completion = require('completion')

local set_lsp_icons = function()
  require'vim.lsp.protocol'.CompletionItemKind = {
    ' Text',
    ' Method',
    'ƒ Function',
    ' Constructor',
    '識 Field',
    ' Variable',
    ' Class',
    'ﰮ Interface',
    ' Module',
    ' Property',
    ' Unit',
    ' Value',
    '了 Enum',
    ' Keyword',
    '﬌ Snippet',
    ' Color',
    ' File',
    '渚 Reference',
    ' Folder',
    ' EnumMember',
    ' Constant',
    ' Struct',
    '鬒 Event',
    'Ψ Operator',
    ' TypeParameter'
  }
end

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua "..result.."<cr>", {noremap = true, silent = true})
end

local custom_attach = function(overlap)
  set_lsp_icons()
  --completion.on_attach()

  -- maps
  mapper('n', 'gD', 'vim.lsp.buf.declaration()')
  mapper('n', 'gd', 'vim.lsp.buf.definition()')
  mapper('n', '<leader>K', 'vim.lsp.buf.signature_help()')
  mapper('n', 'gi', 'vim.lsp.buf.implementation()')
  mapper('n', 'gr', 'vim.lsp.buf.references()')
  mapper('n', '<F2>', 'vim.lsp.buf.rename()')

  if overlap ~= nil  then
  	mapper('n', '<leader>q', 'vim.lsp.buf.code_action()')
  end
end

lsp.vimls.setup({
    on_attach = custom_attach
  })

local sumneko_root_path = "/data/home/michael/tools/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
lsp.sumneko_lua.setup({
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = custom_attach,
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
    on_attach = custom_attach
  })

-- shell
lsp.bashls.setup({
    on_attach = custom_attach
  })

-- web
lsp.tsserver.setup({
    on_attach = custom_attach
  })

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp.html.setup({
    on_attach = custom_attach,
    capabilities = capabilities
  })

lsp.cssls.setup({
    on_attach = custom_attach,
    capabilities = capabilities
  })

lsp.jsonls.setup({
    on_attach = custom_attach
  })

lsp.yamlls.setup({
    on_attach = custom_attach
  })

lsp.vuels.setup({
    on_attach = custom_attach
  })

--lsp.angularls.setup({
    --on_attach = custom_attach
  --})

-- jwm

lsp.kotlin_language_server.setup({
    on_attach = custom_attach
  })

lsp.groovyls.setup({
    on_attach = custom_attach,
    cmd = { "java", "-jar", "/home/michael/tools/groovy-language-server/build/libs/groovy-language-server-all.jar" },
    filetypes = { "groovy", "gradle" }
  })

M.jdtls = function ()
  local on_attach_java = function()
    custom_attach(true)

    -- java actions
    mapper('n', '<leader>q', 'require"jdtls".code_action()')
  end

  require('jdtls').start_or_attach({
      cmd = {'launch-jdtls'},
      root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'}),
      on_attach = on_attach_java
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
