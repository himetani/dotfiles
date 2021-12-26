silent! if plug#begin('~/.local/share/nvim/plugged')
  Plug 'arcticicestudio/nord-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
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
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'iberianpig/tig-explorer.vim'
  Plug 'lambdalisue/gina.vim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'TimUntersberger/neogit'
  Plug 'sindrets/diffview.nvim'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
call plug#end() 
endif

let mapleader = "\<Space>"

runtime! settings/*.vim
lua require('lsp')
lua require('plugins')
lua require('treesitter')
lua require('telescope')
lua require('ng')

"lua << EOF
"require("neogit").setup {}
"EOF

augroup custom-group
  au QuickfixCmdPost make,grep,grepadd,vimgrep copen
augroup END
