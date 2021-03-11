au BufRead,BufNewFile *.xml command! -bang F call XMLFormat()
function XMLFormat()
      %s/></>\r</g
      normal gg=G
endfunction
