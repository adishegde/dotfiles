" map 'jk' to escape
call arpeggio#map('ixoc', '', 0, 'jk', '<Esc>')

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" line text objects for selecting in and
vnoremap al :normal! 0v$<CR>
vnoremap il :normal! ^vg_<CR>
onoremap al :normal val<CR>
onoremap il :normal vil<CR>

nnoremap <silent> <leader>rr :RangerCurrentDirectory<CR>

inoremap <silent><expr> <CR> compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })

" Use <C-j> and <C-k> for autocomplete menu navigation
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" project wide search/action
nnoremap <Leader>pf <cmd>Telescope find_files<cr>
nnoremap <leader>ps <cmd>Telescope live_grep<cr>
nnoremap <leader>pt <cmd>Telescope lsp_workspace_symbols<cr>

" buffer wide search/action
nnoremap <Leader>bb <cmd>Telescope buffers<CR>
nnoremap <Leader>bt <cmd>Telescope lsp_document_symbols<CR>
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>bn :enew<CR>

nnoremap <silent> <leader>tf :w<CR> :!/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> main.pdf %<CR>
