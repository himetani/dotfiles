function! s:init_fern() abort
  nmap <buffer> <cr> <Plug>(fern-action-open-or-expand)
  nmap <buffer> s <Plug>(fern-action-open:side)<C-w>p<C-o><C-w>w
endfunction

augroup fern-custom
  autocmd!
  autocmd FileType fern call s:init_fern()
  autocmd FileType fern call glyph_palette#apply()
augroup END

noremap <silent> <Leader>. :call OpenProjectRoot()<CR>
noremap <silent> <Leader>, :Fern %:h -reveal=% <CR><C-w>=

function!Debug() abort
  echo expand('%')
  Fern . -reveal=%
endfunction

function! OpenProjectRoot() abort
  let git = trim(system('git rev-parse --is-inside-work-tree'))
  if git == 'true'
    let root = trim(system('git rev-parse --show-superproject-working-tree --show-toplevel'))
    let file = expand('%:p')
    let reveal_path = substitute(file, root."/", "", 'g')
    execute 'Fern '.root.' -reveal='.reveal_path
  else 
    Fern . -reveal=%
  endif
endfunction
