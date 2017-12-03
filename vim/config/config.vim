"Display
let mapleader = "\<Space>"
set number "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示
set cursorline
set cursorcolumn

syntax on "カラー表示
set smartindent "オートインデント
set autoindent "改行の継続
set expandtab "タブの代わりに空白文字挿入
set ts=4 "tabstop display tab spaces
set sw=4 "shiftwidth insert tab spaces
set sts=0 "softtabstop insert spaces pressing tab key
set backspace=indent,eol,start
set notitle
let &titleold=getcwd()
noremap! ¥ \

"Serach
set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set noincsearch "検索文字列入力時に順次対象文字列にヒットさせない
set nohlsearch "検索結果文字列の非ハイライト表示

set clipboard=unnamed
