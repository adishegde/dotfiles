" map 'jk' to escape
call arpeggio#map('ixoc', '', 0, 'jk', '<Esc>')

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" line text objects for selecting in and
vnoremap al :normal! 0v$<cr>
vnoremap il :normal! ^vg_<cr>
onoremap al :normal val<cr>
onoremap il :normal vil<cr>

nnoremap <silent> <leader>rr :RangerCurrentDirectory<cr>

" project wide search/action
nnoremap <leader>pf <cmd>Telescope find_files<cr>
nnoremap <leader>ps <cmd>Telescope live_grep<cr>
nnoremap <leader>pt <cmd>Telescope lsp_workspace_symbols<cr>

" buffer wide search/action
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>bt <cmd>Telescope lsp_document_symbols<cr>
nnoremap <silent> <leader>bd :bd<cr>
nnoremap <silent> <leader>bn :enew<cr>

" vim-sandwich
" add
nnoremap <leader>sa <Plug>(sandwich-add)
xnoremap <leader>sa <Plug>(sandwich-add)
" delete
nnoremap <leader>sd <Plug>(sandwich-delete)
xnoremap <leader>sd <Plug>(sandwich-delete)
nnoremap <leader>sdb <Plug>(sandwich-delete-auto)
" replace
nnoremap <leader>sr <Plug>(sandwich-replace)
xnoremap <leader>sr <Plug>(sandwich-replace)
nnoremap <leader>srb <Plug>(sandwich-replace-auto)

lua << EOF
-- diagnostics
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, opts)

local opts = { noremap=true, silent=false }
vim.api.nvim_set_keymap("n", "<leader>nn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>nf", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ns", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)
EOF

" increment/decrement using dial
nnoremap  <C-a>  <Plug>(dial-increment)
nnoremap  <C-x>  <Plug>(dial-decrement)
vnoremap  <C-a>  <Plug>(dial-increment)
vnoremap  <C-x>  <Plug>(dial-decrement)
vnoremap g<C-a> g<Plug>(dial-increment)
vnoremap g<C-x> g<Plug>(dial-decrement)
