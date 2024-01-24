lua require('micmine.plugins')
lua require('micmine.set')
"lua require('micmine.dev')

" system clipboard
set clipboard+=unnamedplus

" theme
" truecolor
if (has("termguicolors"))
  set termguicolors
endif

" jump to last line
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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

-- replace
vim.keymap.set("n", "<leader>r", ":%s//gI<Left><Left><Left>", { noremap = true })
vim.keymap.set("v", "<leader>r", ":s//g<Left><Left>", { noremap = true })

-- disable zig autoformat
vim.g.zig_fmt_autosave = 0
END

" terminal
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

au FileType qf call AdjustWindowHeight(0, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
