" ============================================================================
" VIM-PLUG BLOCK
" ============================================================================

silent! if plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
autocmd VimEnter * execute 'wincmd w'
nnoremap <C-e> :NERDTreeToggle

Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
Plug 'altercation/vim-colors-solarized', {'set': 'all'}
Plug 'itchyny/lightline.vim'
let g:lightline = {
    \'colorscheme': 'solarized',
    \}

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'majutsushi/tagbar'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'

call plug#end()
endif

" ============================================================================
" " BASIC SETTINGS 
" ============================================================================
let mapleader = "\<Space>"

"display
"set relativenumber
set number
set ruler
set showcmd
set showmode
set laststatus=2 
set cursorline
set cursorcolumn

"indent
set smartindent
set autoindent


"() {}
set showmatch
set matchtime=1

"search
set ignorecase
set smartcase
set wrapscan
set hlsearch

" preserve buffer
autocmd BufWritePost * mkview
autocmd BufReadPost * silent! loadview

" Don't save options.
set viewoptions-=options

" other
syntax on
set clipboard=unnamed
noremap! ¥ \
set backspace=indent,eol,start
set encoding=utf-8
set ff=unix
map <C-n> :set relativenumber!<CR>
set belloff=all
set dictionary=/usr/share/dict/words

" ----------------------------------------------------------------------------
" indentLine
" ----------------------------------------------------------------------------
let g:indentLine_color_term = 231

" ----------------------------------------------------------------------------
" colors-solarized
" ----------------------------------------------------------------------------
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_visibility="low" 
set background=dark
colorscheme solarized

" ----------------------------------------------------------------------------
" filetype
" ----------------------------------------------------------------------------
augroup filetypedetect
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead vimrc*,.vimrc* setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
  
  autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.html setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.groovy setf groovy
  autocmd BufNewFile,BufRead Jenkinsfile*,*Jenkinsfile setf groovy
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.zsh setlocal expandtab shiftwidth=4 tabstop=4
  
  autocmd FileType json setlocal expandtab shiftwidth=4 tabstop=4
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4
  autocmd FileType xml setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType dockerfile setlocal expandtab shiftwidth=4 tabstop=4
  autocmd FileType groovy setlocal expandtab shiftwidth=4 tabstop=4
  autocmd FileType sshconfig setlocal expandtab shiftwidth=4 tabstop=4
  autocmd FileType proto setlocal noet shiftwidth=2 tabstop=2
  autocmd FileType sql setlocal expandtab shiftwidth=4 tabstop=4
augroup END

" ----------------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------------
let g:go_def_mode = "gopls"
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
set updatetime=1000
let g:go_echo_command_info = 1
let g:go_metalinter_autosave = 1
let g:go_addtags_transform = 'camelcase'
let g:go_fold_enable = []

nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>
nmap <C-c> :GoDoc<cr>
imap <C-c> <esc>:<C-u>GoDoc<cr>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup go
  autocmd!

  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)

  autocmd FileType go nmap <silent> <Leader>x <Plug>(go-doc-vertical)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)

  autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <silent> <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <silent> <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <silent> <leader>e  <Plug>(go-install)

  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)

  " I like these more!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
  inoremap <Leader><Tab> <C-x><C-o>
augroup END

" ----------------------------------------------------------------------------
" xml
" ----------------------------------------------------------------------------
augroup xml 
  autocmd!

  function XMLFormat()
      %s/></>\r</g
      normal gg=G
  endfunction

  command! -bang F call XMLFormat()
augroup END

" ----------------------------------------------------------------------------
" JSON
" ----------------------------------------------------------------------------
augroup json
  autocmd!
  function JSONFormat()
      %!jq '.'
      normal gg=G
  endfunction

  command! -bang JSON call JSONFormat()
augroup END

" ============================================================================
" " fzf {{{
" "
" ============================================================================

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang Json <esc>:%!jq '.'
