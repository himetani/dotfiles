let mapleader = "\<Space>"
noremap <silent> <Leader>. :Fern . -reveal=% <CR><C-w>=
noremap <silent> <Leader>, :Fern %:h -reveal=% <CR><C-w>=

nnoremap tig :<C-u>w<CR>:te tig<CR>
tnoremap <silent> <ESC> <C-\><C-n>