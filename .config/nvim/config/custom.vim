" Autocommands {{{
augroup vimrc
  autocmd!
  "Refresh file when vim gets focus.
  autocmd FocusGained,BufEnter * checktime

  "Auto-remove trailing spaces for all filetypes except markdown.
  autocmd BufWritePre * if &filetype !~? 'markdown' | :call StripTrailingWhitespaces() | endif

  " Write servername into file for tex files.
  autocmd FileType tex call s:WriteServerName()
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

" Write server name into a file for use with nvr.
" Reference: https://jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/
function! s:WriteServerName() abort
  let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/nvim_tex_server.txt'
  call writefile([v:servername], nvim_server_file)
endfunction
" END Functions }}}

" Commands {{{
command! Vimconfig :e ~/.config/nvim/init.vim
command! Reloadconfig :source ~/.config/nvim/init.vim
command! -nargs=* Cprun :call CprunWrapper(<f-args>)
" END Commands }}}
