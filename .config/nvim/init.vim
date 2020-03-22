
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
Plug 'joshdick/onedark.vim'

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Color preview
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" javascipt
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'

" IDE
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" LaTeX
Plug 'lervag/vimtex'

" Tag autoclose
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'

call plug#end()

" simple
colorscheme onedark
set laststatus=2
set encoding=UTF-8
set number

" fuzzy finder
let g:fzf_commands_expect = 'ctrl-x'
map <c-p> :FZF<CR>

" spellcheck
map <F6> :setlocal spell spelllang=de_ch<CR>
" map <F6> :setlocal spell spelllang=en_us<CR>

" IDE
let g:coc_global_extensions = [
	\ 'coc-snippets',
	\ 'coc-pairs',
	\ 'coc-tsserver',
	\ 'coc-eslint', 
	\ 'coc-prettier', 
	\ 'coc-json',
	\ 'coc-java',
	\ 'coc-phpls',
	\ ]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ale
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_fix_on_save = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" Colortheme
let g:Hexokinase_highlighters = ['sign_column']

" Tag autoclose
let g:closetag_filenames = '*.html,*.xhtml,*.php,*.blade.php,*.js,*.vue'
let g:closetag_xhtml_filenames = '*.html,*.xhtml,*.php,*.blade.php,*.js,*.vue'

" filetree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <F3> :NERDTreeToggle<CR>

set guifont=DroidSansMono\ Nerd\ Font\ 11

let g:gitgutter_terminal_reports_focus=0

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


