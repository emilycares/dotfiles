lua require('micmine.plugins')

lua require('micmine.set')

" system clipboard
set clipboard+=unnamedplus

" simple
"lua require('micmine.color')

" theme
" truecolor
if (has("termguicolors"))
  set termguicolors
endif
" color preview
" gruvbox lsp error
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lum"
endif

" jump to last line
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" replace
noremap <leader>r :%s//gI<Left><Left><Left>

" movement
"lua require('micmine.movement')

" quickfix map - and center
nnoremap <C-k> :cprevious<CR>zzzv
nnoremap <C-j> :cnext<CR>zzzv
nnoremap <leader>k :lprevious<CR>zzzv
nnoremap <leader>j :lnext<CR>zzzv

" spellcheck
noremap <leader><F6>g :setlocal spell spelllang=de_ch<CR>
noremap <leader><F6>e :setlocal spell spelllang=en_us<CR>

" paste but keep same thing copyed
lua << END
vim.keymap.set("x", "<M-p>", "\"_dP", { noremap = true })
END

" undotree
nnoremap <F8> :UndotreeToggle<CR>

" exit terminal
tnoremap <F1> <C-\><C-n>

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

lua vim.api.nvim_set_keymap('n', '<leader>z', "<cmd>lua require'centerpad'.toggle{ leftpad = 30, rightpad = 30 }<cr>", { silent = true, noremap = true })
