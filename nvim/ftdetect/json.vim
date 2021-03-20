augroup json 
  autocmd! *
  autocmd! BufRead,BufNewFile *.json map <buffer> ff :call JSONFormat()<cr>
augroup END
function JSONFormat()
  %!jq '.'
  normal gg=G
endfunction
