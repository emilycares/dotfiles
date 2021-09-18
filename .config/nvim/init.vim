call plug#begin('~/.vim/plugged')
" lib
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'tami5/sql.nvim' " nvim-telescope/telescope-frecency.nvim

" General
Plug 'hoob3rt/lualine.nvim'

" Movment
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'micmine/jumpwire.nvim'
Plug 'ThePrimeagen/harpoon'

" startscreen
Plug 'mhinz/vim-startify'

" theme
Plug 'joshdick/onedark.vim'
Plug 'pineapplegiant/spaceduck'
Plug 'ayu-theme/ayu-vim'
Plug 'rktjmp/lush.nvim'
Plug 'gruvbox-community/gruvbox'

" git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'ThePrimeagen/git-worktree.nvim'

" preview
Plug 'norcalli/nvim-colorizer.lua'

" IDE
Plug 'prettier/vim-prettier'
Plug 'scrooloose/nerdcommenter'
Plug 'chiel92/vim-autoformat'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'mfussenegger/nvim-jdtls'

" syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'

" Tag autoclose
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'

" clean buffers
Plug 'Asheq/close-buffers.vim'

call plug#end()

" leader
let mapleader=" "

" system clipboard
set clipboard+=unnamedplus

" simple
colorscheme gruvbox
set background=dark
syntax on
set laststatus=2
set encoding=UTF-8
set number
set relativenumber
set tabpagemax=15
set mouse=a
set scrolloff=8
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
" color preview
lua require('colorizer').setup()
" gruvbox lsp error
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lum"
endif
lua require('statusline')

" jump to last line
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" replace
noremap <leader>r :%s//gI<Left><Left><Left>

" movement
lua require('movement')
" fuzzy finder
nnoremap <c-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader><c-d> <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader><C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>o <cmd>lua require('telescope').extensions.frecency.frecency()<cr>
nnoremap <leader><C-b> <cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>
" jumpwire
noremap <leader>mt :lua require('jumpwire').jump('test')<CR>
noremap <leader>mi :lua require('jumpwire').jump('implementation')<CR>
noremap <leader>mm :lua require('jumpwire').jump('markup')<CR>
noremap <leader>ms :lua require('jumpwire').jump('style')<CR>
" harpoon
nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <C-n> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <C-m> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <C-t> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <C-g> :lua require("harpoon.ui").nav_file(4)<CR>

" quickfix map - and center
nnoremap <C-k> :cprevious<CR>zzzv
nnoremap <C-j> :cnext<CR>zzzv
nnoremap <leader>k :lprevious<CR>zzzv
nnoremap <leader>j :lnext<CR>zzzv

" spellcheck
noremap <leader><F6>g :setlocal spell spelllang=de_ch<CR>
noremap <leader><F6>e :setlocal spell spelllang=en_us<CR>

" exit terminal
tnoremap <Esc> <C-\><C-n>

" remaps
" center search
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
" Add undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u

" clean buffers
nnoremap <leader>dcb :Bdelete hidden<CR>

" latex
let g:tex_flavor = 'latex'

" IDE
lua require('lsp')

augroup LSP
	autocmd!
	autocmd! BufWrite,BufEnter *.ts,*.js,*.json,*.html,*.vue,*.java :lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
augroup END

" Wrire
set completeopt=menuone,noselect
lua << EOF
require('nvim-autopairs').setup({
check_ts = true
})
EOF
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" syntax
lua require('syntax')

" format
augroup FORMAT
	autocmd!
	autocmd! BufWritePre *.ts,*.js,*.json,*.html,*.vue :PrettierAsync
augroup END
noremap <leader>f :Autoformat<CR>

" filetree
noremap <C-b> :NvimTreeToggle<CR>

let NERDTreeWinSize = 40
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let g:netrw_browse_split = 0
let g:netrw_banner = 0
let g:netrw_winsize = 40
