map <buffer> F :call JSONFormat()<cr>
function JSONFormat()
  %!jq '.'
  normal gg=G
endfunction
