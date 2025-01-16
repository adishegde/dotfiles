vim.opt_local.spell = true
vim.opt_local.colorcolumn = ''

-- Forward search to PDF
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

-- Wordcount ignoring latex commands and comments
vim.api.nvim_buf_create_user_command(
  0, 'Wordcount', ':<line1>,<line2> w !detex - | wc -w', {}
)

-- Textobjects
vim.b.miniai_config = {
  custom_textobjects = {
    ['$'] = { '%$[^%$]*%$', '^%$()[^%$]*()%$$' },
    ['`'] = { "`[^']*'", "^`()[^']*()'$" },
  },
}

-- Pairs
MiniPairs.map_buf(0, 'i', '$', { action = 'closeopen', pair = '$$' })
MiniPairs.map_buf(0, 'i', '`', { action = 'open', pair = "`'" })

-- Surrounds
vim.b.minisurround_config = {
  custom_surroundings = {
    c = {
      input = { '\\%a+%b{}', '^\\%a+{().*()}$' },
      output = function()
        local command = vim.fn.input('Enter command: ')
        return { left = '\\' .. command .. '{', right = '}' }
      end,
    },
    e = {
      input = {
        '\\begin{([^}]*)}.-\\end{%1}',
        '^\\begin{[^}]*}\n?().-()\n?\\end{[^}]*}$'
      },
      output = function()
        local env = vim.fn.input('Enter environment name: ')
        return {
          left = '\\begin{' .. env .. '}\n',
          right = '\n\\end{' .. env .. '}' 
        }
      end
    },
    ['`'] = {
      input = {"`()[^']*()'"},
      output = {left = '`', right = "'"}
    }
  }
}
