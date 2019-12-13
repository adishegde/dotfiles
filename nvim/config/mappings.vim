" map 'jk' to escape
call arpeggio#map('ixoc', '', 0, 'jk', '<Esc>')

" remap L and H to go to beginning and end of line
nnoremap L $
nnoremap H 0
onoremap L $
onoremap H 0

" line text objects for selecting in and
vnoremap al :normal! 0v$<CR>
vnoremap il :normal! ^vg_<CR>
onoremap al :normal val<CR>
onoremap il :normal vil<CR>

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

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" mappings for tags
nmap <leader>tt :Vista coc<CR>
nmap <leader>tf :Vista finder coc<CR>

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
