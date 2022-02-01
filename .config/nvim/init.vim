call plug#begin('~/.vim/plugged')
" lib
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'hrsh7th/cmp-nvim-lsp' " cmp
Plug 'hrsh7th/cmp-buffer' " cmp
Plug 'hrsh7th/cmp-path' " cmp
Plug 'rktjmp/lush.nvim' " gruvbox

" General
Plug 'hoob3rt/lualine.nvim'
Plug 'mbbill/undotree'

" Movment
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'micmine/jumpwire.nvim'
Plug 'ThePrimeagen/harpoon'

" theme
Plug 'joshdick/onedark.vim'
Plug 'pineapplegiant/spaceduck'
Plug 'ayu-theme/ayu-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'shaunsingh/nord.nvim'

" git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'sindrets/diffview.nvim'
Plug 'ThePrimeagen/git-worktree.nvim'

" preview
Plug 'norcalli/nvim-colorizer.lua'

" IDE
Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install --frozen-lockfile --production'
      \ }
Plug 'scrooloose/nerdcommenter'
Plug 'chiel92/vim-autoformat'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'j-hui/fidget.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'mfussenegger/nvim-jdtls'
Plug 'ericpubu/lsp_codelens_extensions.nvim' " plenary, nvim-dap

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" snipet
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'

" syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'

" clean buffers
Plug 'Asheq/close-buffers.vim'

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

" quickfix map - and center
nnoremap <C-k> :cprevious<CR>zzzv
nnoremap <C-j> :cnext<CR>zzzv
nnoremap <leader>k :lprevious<CR>zzzv
nnoremap <leader>j :lnext<CR>zzzv

" spellcheck
noremap <leader><F6>g :setlocal spell spelllang=de_ch<CR>
noremap <leader><F6>e :setlocal spell spelllang=en_us<CR>

" undotree
nnoremap <F8> :UndotreeToggle<CR>

" snipet
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

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

" IDE
lua require('lsp').setup()
lua require('completion')
lua require('debugging')

augroup LSP
  autocmd!
  autocmd! BufWrite,BufEnter *.ts,*.js,*.json,*.html,*.vue,*.java :lua vim.diagnostic.setloclist({open = false, severity = vim.diagnostic.severity.ERROR})
  autocmd! BufEnter *.java :lua require('lsp').jdtls()
augroup END

" Wrire
set completeopt=menuone,noselect

" syntax
lua require('syntax')

" format
augroup FORMAT
  autocmd!
  autocmd! BufWritePre *.ts,*.js,*.json,*.html,*.vue,*.svelte :PrettierAsync
augroup END
noremap <leader>f :Autoformat<CR>

" filetree
lua require('nvim-tree').setup()
noremap <C-b> :NvimTreeFindFileToggle<CR>

let g:netrw_browse_split = 0
let g:netrw_banner = 0
let g:netrw_winsize = 60
