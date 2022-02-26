call plug#begin('~/.vim/plugged')
" lib
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Movment
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'

" theme
Plug 'joshdick/onedark.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" git
Plug 'tpope/vim-fugitive'
"Plug 'junegunn/gv.vim'
"Plug 'sindrets/diffview.nvim'
"Plug 'ThePrimeagen/git-worktree.nvim'

" syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" respect editor config
Plug 'editorconfig/editorconfig-vim'

call plug#end()

" leader
let mapleader=" "

" system clipboard
set clipboard+=unnamedplus

" simple
colorscheme tokyonight
set background=dark
syntax on
set laststatus=2
set encoding=UTF-8
set number
set tabpagemax=15
set mouse=a
"set scrolloff=8
set hidden
set cursorline
set updatetime=50
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" theme
" truecolor
if (has("termguicolors"))
  set termguicolors
endif

" movement
lua require('movement')

" quickfix map - and center
nnoremap <C-k> :cprevious
nnoremap <C-j> :cnext

" exit terminal with excape
tnoremap <Esc> <C-\><C-n>

" syntax
lua require('syntax')

" filetree
lua require('nvim-tree').setup()
noremap <C-b> :NvimTreeFindFileToggle<CR>

let g:netrw_browse_split = 0
let g:netrw_banner = 0
let g:netrw_winsize = 60
