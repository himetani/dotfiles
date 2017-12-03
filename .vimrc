if !1 | finish | endif

if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'heavenshell/vim-jsdoc'
NeoBundle 'wlangstroth/vim-racket'
NeoBundle 'fatih/vim-go'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'elzr/vim-json'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'tfnico/vim-gradle'
NeoBundle 'vim-scripts/groovy.vim'
NeoBundle 'martinda/Jenkinsfile-vim-syntax'

call neobundle#end()
let mapleader = "\<Space>"

runtime! config/*.vim
runtime! pluginconfig/*.vim

" when filetype change, read plugin and indent config
filetype plugin indent on
