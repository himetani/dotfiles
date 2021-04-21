setl expandtab shiftwidth=4 tabstop=4
map <buffer> F :call JSONFormat()<cr>
function JSONFormat()
  %!jq '.'
  normal gg=G
endfunction
