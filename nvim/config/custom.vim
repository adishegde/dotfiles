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

  "Show markdown files as is, without hiding characters
  autocmd FileType markdown :set conceallevel=0

  " Show signature help on moving to next placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
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

"Function to insert time stamp
function! InsertTimeStamp()
  execute ":normal iWritten on: " . strftime("\%Y-\%m-\%d \%H:\%M:\%S")
  call NERDComment(1, 'sexy')
endfunction

" END Functions }}}

" Commands {{{
command! TimeStamp :call InsertTimeStamp()
command! Vimconfig :e ~/.config/nvim/init.vim
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" END Commands }}}
