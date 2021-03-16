"display
set relativenumber
set number
set ruler
set showcmd
set showmode
set laststatus=2 
set cursorline
set cursorcolumn

"indent
set autoindent
set smartindent
set cindent

"() {}
set showmatch
set matchtime=1
set iskeyword+=-
set inccommand=nosplit

"search
set ignorecase
set smartcase
set wrapscan
set hlsearch

" preserve buffer
autocmd BufWritePost * mkview
autocmd BufReadPost * silent! loadview
" prevent from auto indent of comment
autocmd FileType * setlocal formatoptions-=ro

" Don't save options.
set viewoptions-=options

"colorscheme
set termguicolors
colorscheme nord


" other
syntax on
set encoding=utf-8
set clipboard=unnamedplus
noremap! ¥ \
set backspace=indent,eol,start
set ff=unix
nmap <C-r> :set relativenumber!<CR>
set belloff=all
set dictionary=/usr/share/dict/words
