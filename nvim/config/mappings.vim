" map 'jk' to escape
call arpeggio#map('ixoc', '', 0, 'jk', '<Esc>')

" remap L and H to go to beginning and end of line
nnoremap L $
nnoremap H 0
onoremap L $
onoremap H 0

" ranger
nnoremap <leader>rr :RangerEdit<cr>
nnoremap <leader>ra :RangerAppend<cr>
nnoremap <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
nnoremap <leader>rd :RangerCD<cr>

" project wide search/action
nnoremap <silent> <Leader>pf :Files<CR>
nnoremap <leader>ps :Ag<Space>

" buffer wide search/action
nnoremap <silent> <Leader>bb :Buffers<CR>
nnoremap <silent> <Leader>bc :BCommits<CR>
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>bn :enew<CR>

" remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

" formatting
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" codeaction
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <C-j> and <C-k> for navigation
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm. Force select before
" confirm
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
