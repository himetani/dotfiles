function SetIndengGuide()
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
    let g:indent_guides_enable_on_vim_startup=1
    let g:indent_guides_guide_size=1
endfunction

let g:indent_guides_auto_colors=0
