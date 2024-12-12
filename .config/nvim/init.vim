lua require('emilycares.plugins')
lua require('emilycares.set')
lua require('emilycares.remaps')
"lua require('emilycares.dev')

" theme
" truecolor
if (has("termguicolors"))
  set termguicolors
endif

" jump to last line
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


au FileType qf call AdjustWindowHeight(0, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
