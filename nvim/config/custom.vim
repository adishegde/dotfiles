" Autocommands {{{
augroup vimrc
    autocmd!

    "Refresh file when vim gets focus
    autocmd FocusGained,BufEnter * checktime

    "Auto-remove trailing spaces
    autocmd BufWritePre * :call StripTrailingWhitespaces()

    "Indent lines hides quotes in json
    autocmd Filetype json let g:indentLine_enabled = 0

    "Spell checking in tex files
    autocmd FileType tex setlocal spell spelllang=en_gb
    autocmd FileType tex syntax spell toplevel

    "Use foldmethod marker in vimscript files
    autocmd FileType vim setlocal foldmethod=marker

    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif

    "Set foldmethod to indent when support not available
    autocmd FileType ocaml :set foldmethod=indent

    "Show markdown files as is, without hiding characters
    autocmd FileType markdown :set conceallevel=0
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

function! InsertTimeStamp()                                                     "Function to insert time stamp
  execute ":normal iWritten on: " . strftime("\%Y-\%m-\%d \%H:\%M:\%S")
  call NERDComment(1, 'sexy')
endfunction
" END Functions }}}

" Commands {{{
command! TimeStamp :call InsertTimeStamp()
command! Vimconfig :e ~/.config/nvim/init.vim
" END Commands }}}
