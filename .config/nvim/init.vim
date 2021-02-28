call plug#begin('~/.vim/plugged')
" General
Plug 'junegunn/goyo.vim'

" line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File tree
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" startscreen
Plug 'mhinz/vim-startify'

" theme
Plug 'joshdick/onedark.vim'
"Plug 'gruvbox-community/gruvbox'
Plug 'pineapplegiant/spaceduck'
Plug 'ayu-theme/ayu-vim'
Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'

" fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" git
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'junegunn/gv.vim'
Plug 'APZelos/blamer.nvim'

" preview
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" javascipt
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" IDE
Plug 'prettier/vim-prettier'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'chiel92/vim-autoformat'
Plug 'luchermitte/vim-refactor'
Plug 'vim-syntastic/syntastic'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'steelsojka/completion-buffers'

" syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sheerun/vim-polyglot'
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'

Plug 'ThePrimeagen/vim-be-good'

" react
"Plug 'tasn/vim-tsx'

" flutter
Plug 'hankchiutw/flutter-reload.vim'

" LaTeX
Plug 'lervag/vimtex'

" Tag autoclose
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'

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
set tabpagemax=15
set mouse=a
set relativenumber
set scrolloff=8
set hidden

" truecolor
if (has("termguicolors"))
	set termguicolors
endif

" highlight selected line
set cursorline

" jump to last line
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" replace
noremap <leader>r :%s//gI<Left><Left><Left>

" fuzzy finder
nnoremap <c-p> <cmd>lua require('telescope.builtin').find_files()<cr>

" search file names
noremap <leader><C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>

" search buffers
noremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>

" spellcheck
noremap <leader><F6>g :setlocal spell spelllang=de_ch<CR>
noremap <leader><F6>e :setlocal spell spelllang=en_us<CR>

" file switcher
filetype plugin on
autocmd BufReadPre,FileReadPre *.ts set ft=typescript
autocmd BufReadPre,FileReadPre *.html set ft=html
autocmd BufReadPre,FileReadPre *.scss set ft=scss

" goyo
nmap <leader>g :Goyo<CR>

" latex
let g:tex_flavor = 'latex'

" IDE
noremap <C-_> <plug>NERDCommenterToggle
" gruvbox lsp error
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lum"
endif
lua << EOF
vim.lsp.set_log_level("debug")
EOF
lua require('lsp')
set completeopt=menuone,noinsert
let g:completion_chain_complete_list = [
			\{'complete_items': ['path', 'buffers', 'lsp']}
			\]

" syntax
lua require('syntax')

" format
autocmd BufWritePre *.ts,*.js,*.json,*.html,*.vue :PrettierAsync
noremap <leader>f :Autoformat<CR>

" preview
let g:Hexokinase_highlighters = ['sign_column']

" Tag autoclose
let g:closetag_filenames = '*.html,*.xhtml,*.php,*.blade.php,*.js,*.vue'
let g:closetag_xhtml_filenames = '*.html,*.xhtml,*.php,*.blade.php,*.js,*.vue'

" filetree

let g:nerdtree_is_open = 0
function! ToggleNerdTree()
	if g:nerdtree_is_open
		NERDTreeClose
		let g:nerdtree_is_open = 0
	else
		if @% == ""
			NERDTreeToggle
		else
			NERDTreeFind
		endif
		let g:nerdtree_is_open = 1
	endif
endfunction
noremap <C-b> :call ToggleNerdTree()<CR>

let NERDTreeWinSize = 40
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" git
let g:gitgutter_terminal_reports_focus=0
