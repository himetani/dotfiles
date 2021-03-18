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
call plug#end() 
endif

runtime! settings/*.vim
lua require('lsp')
lua require('plugins')

augroup my-glyph-palette
  autocmd! *
  autocmd! FileType fern call glyph_palette#apply()
augroup END

" Fern
function! s:init_fern() abort 
  nmap <buffer> <cr> <Plug>(fern-action-open-or-expand)
  nmap <buffer> s <Plug>(fern-action-open:side)<C-w>p<C-o><C-w>w
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
