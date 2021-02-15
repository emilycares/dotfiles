local lsp = require('lspconfig')
local completion = require('completion')

local mapper = function(mode, key, result)
  vim.api.nvim_buf_set_keymap(0, mode, key, "<cmd>lua "..result.."<cr>", {noremap = true, silent = true})
end

local custom_attach = function()
  completion.on_attach()
  -- Move cursor to the next and previous diagnostic
  mapper('n', 'gD', 'vim.lsp.buf.declaration()')
  mapper('n', 'gd', 'vim.lsp.buf.definition()')
  mapper('n', '<leader>K', 'vim.lsp.buf.hover()')
  mapper('n', 'gi', 'vim.lsp.buf.implementation()')
  mapper('n', 'gr', 'vim.lsp.buf.references()')
  mapper('n', '<F2>', 'vim.lsp.buf.rename()')
  -- java actions
  mapper('n', '<leader>t', 'require"jdtls".code_action()')
end

lsp.vimls.setup({
    on_attach = custom_attach
  })

-- backend
--require('jdtls').start_or_attach({cmd = {'launch-jdtls'}, on_attach = custom_attach})

lsp.kotlin_language_server.setup({
    on_attach = custom_attach
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

-- spesific
lsp.vuels.setup({
    on_attach = custom_attach
  })

lsp.angularls.setup({
    on_attach = custom_attach
  })

require('jdtls').start_or_attach({
	cmd = {'launch-jdtls'},
	root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'}),
  on_attach = custom_attach
	})

--lsp.jdtls.setup({
--cmd = {'launch-jdtls'},
--start_or_attach = {
--root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'}),
--},
--on_attach = custom_attach
--})
--require('jdtls')
--.start_or_attach({
--cmd = {'launch-jdtls'},
--root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'}),
--on_attach = custom_attach
--})
