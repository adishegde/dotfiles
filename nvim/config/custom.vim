" Autocommands {{{
augroup vimrc
  autocmd!

  "Refresh file when vim gets focus
  autocmd FocusGained,BufEnter * checktime

  "Auto-remove trailing spaces for all filetypes except markdown
  autocmd BufWritePre * if &filetype !~? 'markdown' | :call StripTrailingWhitespaces() | endif

  "Indent lines hides quotes in json
  autocmd Filetype json let g:indentLine_enabled = 0

  "Use foldmethod marker in vimscript files
  autocmd FileType vim setlocal foldmethod=marker

  "Enable spell check in tex files
  autocmd FileType tex setlocal spell

  "Add $ to auto-pair set for latex files
  autocmd FileType tex let b:AutoPairs = deepcopy(g:AutoPairs) | let b:AutoPairs["$"] = "$"
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
" END Functions }}}

" Commands {{{
command! Vimconfig :e ~/.config/nvim/init.vim
command! Reloadconfig :source ~/.config/nvim/init.vim
command! -nargs=* Cprun :call CprunWrapper(<f-args>)
" END Commands }}}
