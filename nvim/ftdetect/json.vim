au BufRead,BufNewFile *.json command! -bang F call JSONFormat()
function JSONFormat()
	%!jq '.'
	normal gg=G
endfunction
