silent! if plug#begin('~/.local/share/nvim/plugged')
  Plug 'arcticicestudio/nord-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'majutsushi/tagbar'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'antoinemadec/FixCursorHold.nvim'
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/fern-hijack.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  Plug 'lambdalisue/fern-mapping-project-top.vim'
  Plug 'mhinz/vim-startify'
  Plug 'tommcdo/vim-fubitive'
  Plug 'vim-test/vim-test'
  Plug 'mattn/vim-goimports'
  Plug 'kyazdani42/nvim-web-devicons' " devicons plugin for telescope
  Plug 'martinda/Jenkinsfile-vim-syntax'
  Plug 'vim-scripts/groovyindent-unix'
  Plug 'buoto/gotests-vim'
call plug#end() 
endif

let mapleader = "\<Space>"

runtime! settings/*.vim
lua require('lsp')
lua require('plugins')

augroup custom-group
  au QuickfixCmdPost make,grep,grepadd,vimgrep copen
augroup END
