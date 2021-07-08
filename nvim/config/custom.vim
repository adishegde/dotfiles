" Autocommands {{{
augroup vimrc
  autocmd!
  "Refresh file when vim gets focus
  autocmd FocusGained,BufEnter * checktime

  "Auto-remove trailing spaces for all filetypes except markdown
  autocmd BufWritePre * if &filetype !~? 'markdown' | :call StripTrailingWhitespaces() | endif
augroup END
" END Autocommands }}}

" Functions {{{
function! StripTrailingWhitespaces()
  if &modifiable
    let l:l = line(".")
    let l:c = col(".")
    %s/\s\+$//e
    call cursor(l:l, l:c)
  endif
endfunction

function! CprunWrapper(...)
  if a:0 == 0
    AsyncRun cp_run --no_pretty_print "%"
  else
    exec "AsyncRun cp_run --no_pretty_print -t " . a:1 . " " . @%
  endif
  copen
endfunction

let s:soft_wrap_enabled = 0
function! ToggleSoftWrap()
  if s:soft_wrap_enabled
    nunmap <silent> j
    nunmap <silent> k
    nunmap <silent> 0
    nunmap <silent> $
    let s:soft_wrap_enabled = 0
  else
    nnoremap <silent> j gj
    nnoremap <silent> k gk
    nnoremap <silent> 0 g0
    nnoremap <silent> $ g$
    let s:soft_wrap_enabled = 1
  endif
endfunction
" END Functions }}}

" Commands {{{
command! Vimconfig :e ~/.config/nvim/init.vim
command! Reloadconfig :source ~/.config/nvim/init.vim
command! -nargs=* Cprun :call CprunWrapper(<f-args>)
command! ToggleSoftWrap :call ToggleSoftWrap()
" END Commands }}}
