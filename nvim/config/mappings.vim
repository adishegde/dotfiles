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

" project wide search/action
nnoremap <leader>pf <cmd>Telescope find_files<cr>
nnoremap <leader>ps <cmd>Telescope live_grep<cr>
nnoremap <leader>pt <cmd>Telescope lsp_workspace_symbols<cr>

" buffer wide search/action
nnoremap <leader>bb <cmd>Telescope buffers<CR>
nnoremap <leader>bt <cmd>Telescope lsp_document_symbols<CR>
nnoremap <silent> <leader>bd :bd<CR>
nnoremap <silent> <leader>bn :enew<CR>

" org mode mappings
nnoremap <silent> <leader>os <cmd>Telescope find_files search_dirs={"~/icloud/neorg"}<CR>
nnoremap <silent> <leader>od <cmd>Neorg workspace main<CR>
