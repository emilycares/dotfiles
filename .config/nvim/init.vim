call plug#begin('~/.vim/plugged')
" General
Plug 'itchyny/lightline.vim'
Plug 'webberwu/vim-fugitive'
Plug 'lokaltog/vim-powerline'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'altercation/vim-colors-solarized'
Plug 'jreybert/vimagit'
Plug 'junegunn/goyo.vim'

" startscreen
Plug 'mhinz/vim-startify'

" theme
Plug 'joshdick/onedark.vim'

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" preview
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" javascipt
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" IDE
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'chiel92/vim-autoformat'
Plug 'luchermitte/vim-refactor'

" syntax
Plug 'sheerun/vim-polyglot'

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
colorscheme onedark
syntax on
set laststatus=2
set encoding=UTF-8
set number
set tabpagemax=15
set mouse=a

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
nmap <leader>r :%s//gI<Left><Left><Left>

" fuzzy finder
let g:fzf_commands_expect = 'ctrl-x'
map <c-p> :FZF<CR>

" spellcheck
map <F6>g :setlocal spell spelllang=de_ch<CR>
map <F6>e :setlocal spell spelllang=en_us<CR>

" goyo
map g :Goyo<CR>

" IDE
let g:coc_global_extensions = [
			\ 'coc-snippets',
			\ 'coc-pairs',
			\ 'coc-tsserver',
			\ 'coc-vetur',
			\ 'coc-eslint',
			\ 'coc-prettier',
			\ 'coc-json',
			\ 'coc-java',
			\ 'coc-phpls',
			\ 'coc-css',
			\ ]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)
nmap <C-_> <plug>NERDCommenterToggle

" autoformat
command! -nargs=0 Prettier :CocCommand prettier.formatFile
autocmd BufWritePre * :Autoformat

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
map <C-b> :call ToggleNerdTree()<CR>

let NERDTreeWinSize = 40
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" git
let g:gitgutter_terminal_reports_focus=0

" line
let g:lightline = {
			\ 'colorscheme': 'onedark',
			\   'active': {
			\     'left':[ [ 'mode', 'paste' ],
			\              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
			\     ]
			\   },
			\   'component': {
			\     'lineinfo': ' %3l:%-2v',
			\   },
			\   'component_function': {
			\     'gitbranch': 'fugitive#head',
			\   }
			\ }
let g:lightline.separator = {
			\   'left': '', 'right': ''
			\}
let g:lightline.subseparator = {
			\   'left': '', 'right': ''
			\}
