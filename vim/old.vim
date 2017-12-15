augroup Mygroup
    au!
    au BufRead,BufNewFile *.md set filetype=markdown
    au BufRead,BufNewFile *.scala set filetype=scala
    au BufRead,BufNewFile *.py set filetype=python
    au BufRead,BufNewFile *.rb set filetype=ruby
    au BufRead,BufNewFile *.js set filetype=javascript
    au FileType * setlocal formatoptions-=ro "自動コメントアウトの無効化
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif " ファイルを開いた際に、前回終了時の行で起動
    au FileType css setlocal omnifunc=csscomplete#CompleteCSS
    au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    au FileType python setlocal omnifunc=pythoncomplete#Complete
    "au FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
    "au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    "au FileType html, xml call SetIndentGuide
    au FileType python setl autoindent
    au FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,local 
    au FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
    au FileType python let b:did_ftplugin = 1
    au FileType ruby set tabstop=2 expandtab shiftwidth=2 softtabstop=2
    "au FileType json set foldmethod=syntax
augroup END

let g:neocomplete#enable_at_startup = 1
set completeopt=menuone
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"<C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
