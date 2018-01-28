set noexpandtab

nmap <silent> <leader>r <Plug>(go-rename)
nmap <silent> <leader>b <Plug>(go-build)
nmap <silent> <leader>t <Plug>(go-test)
nmap <silent> <leader>c <Plug>(go-coverage)
nmap <silent> <leader>d <Plug>(go-doc)

command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

let g:go_fmt_command = "goimports"

let g:go_metalinter_autosave = 1

set rtp+=/usr/local/opt/fzf
nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>

nmap <silent> <Tab> <Nop>
imap <silent> <Tab> <Tab>
