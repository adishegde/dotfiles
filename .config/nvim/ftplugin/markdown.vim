setlocal spell
setlocal shiftwidth=2
setlocal tabstop=2

lua << EOF
if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
  local opts = { noremap=true, silent=false }
  map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  map("n", "gf", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  map('n', "<leader>nb", '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  map("n", "<leader>nl", "<Cmd>ZkLinks<CR>", opts)
end
EOF
