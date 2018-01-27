set noexpandtab

nmap <leader>r <Plug>(go-rename)
nmap <leader>b <Plug>(go-build)
nmap <leader>t <Plug>(go-test)
nmap <leader>c <Plug>(go-coverage)
nmap <leader>d <Plug>(go-doc)
nmap <leader>i <Plug>(go-imports)

command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

let g:go_fmt_command = "goimports"

let g:go_metalinter_autosave = 1

set rtp+=/usr/local/opt/fzf
nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>
