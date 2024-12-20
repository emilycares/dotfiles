local home = os.getenv("HOME")

--vim.opt.laststatus = 3
vim.opt.encoding = "UTF-8"
vim.opt.clipboard = 'unnamedplus'
--vim.opt.number = true
--vim.opt.relativenumber = true
vim.opt.tabpagemax = 15
vim.opt.mouse = "a"
vim.opt.scrolloff = 8
vim.opt.hidden = true
vim.opt.cursorline = true
vim.opt.updatetime = 50
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = home .. "/.vim/undodir"
vim.opt.undofile = true
--vim.opt.cmdheight = 0
--vim.opt.laststatus = 0

vim.opt.inccommand = "split"
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.g.mapleader = " "

vim.g.mouse = ""
vim.opt.mouse = ""
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 60
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Don't have `o` add a comment
-- vim.opt.formatoptions:remove "o"

-- remove bars
--vim.o.ls = 0
--vim.o.ch = 0
