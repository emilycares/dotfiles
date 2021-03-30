vim.lsp.set_log_level("debug")

local lsp = require('lspconfig')
local completion = require('completion')

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

local custom_attach = function()
  set_lsp_icons()
  completion.on_attach()

  -- maps
  mapper('n', 'gD', 'vim.lsp.buf.declaration()')
  mapper('n', 'gd', 'vim.lsp.buf.definition()')
  mapper('n', '<leader>K', 'vim.lsp.buf.hover()')
  mapper('n', '<leader>k', 'vim.lsp.buf.signature_help()')
  mapper('n', '<leader>q', 'vim.lsp.buf.code_action()')
  mapper('n', 'gi', 'vim.lsp.buf.implementation()')
  mapper('n', 'gr', 'vim.lsp.buf.references()')
  mapper('n', '<F2>', 'vim.lsp.buf.rename()')
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

-- web
lsp.tsserver.setup({
    on_attach = custom_attach
  })

lsp.html.setup({
    on_attach = custom_attach
  })

lsp.cssls.setup({
    on_attach = custom_attach
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

lsp.angularls.setup({
    on_attach = custom_attach
  })

-- jwm

lsp.kotlin_language_server.setup({
    on_attach = custom_attach
  })

function start_jdt()
  local on_attach_java = function(client)
    custom_attach()

    -- java actions
    mapper('n', '<leader>t', 'require"jdtls".code_action()')
  end

  require('jdtls').start_or_attach({
      cmd = {'launch-jdtls'},
      root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'}),
      on_attach = on_attach_java
    })
end

local autocmds = {
  lsp = {
    {"FileType",     "java",   "lua start_jdt()"};
  };
}

function nvim_create_augroups(definitions)
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

nvim_create_augroups(autocmds)
