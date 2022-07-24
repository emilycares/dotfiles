vim.opt.background = 'dark'
vim.cmd('colorscheme ayu')

require('ayu').setup({ mirage = false, overrides = {}})

require('colorizer').setup()
