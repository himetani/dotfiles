filetype plugin indent on

function Format()
  %s/></>\r</g
  normal gg=G
endfunction

command! -bang F call Format()
