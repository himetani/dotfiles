map <buffer> F :call XMLFormat()<cr>
function XMLFormat()
  %s/></>\r</g
  normal gg=G
endfunction
