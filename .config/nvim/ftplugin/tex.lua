vim.opt_local.spell = true
vim.opt_local.colorcolumn = nil

local move_to_skim = function()
  vim.api.nvim_command("write")

  local line = vim.fn.line('.')
  local file = vim.fn.expand('%')
  local command = {
    '/Applications/Skim.app/Contents/SharedSupport/displayline',
    line,
    'main.pdf',
    file,
  }

  vim.system(command)
end

vim.keymap.set('n', '<leader>tf', move_to_skim, { silent = true })

MiniPairs.map_buf(0, 'i', '$', { action = 'closeopen', pair = '$$' })
MiniPairs.map_buf(0, 'i', '`', { action = 'open', pair = "`'" })

vim.api.nvim_buf_create_user_command(
  0, 'Wordcount', ':<line1>,<line2> w !detex - | wc -w', {}
)
