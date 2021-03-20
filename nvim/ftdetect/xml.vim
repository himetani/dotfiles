augroup xml
  autocmd! *
  au BufRead,BufNewFile *.xml map <buffer> f :call XMLFormat()<cr>
augroup END
function XMLFormat()
  %s/></>\r</g
  normal gg=G
endfunction
