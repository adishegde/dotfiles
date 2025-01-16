-- ===== Summary of custom key maps =====
-- List of additional key maps introduced by the config. Does not include 
-- text objects or keymaps in special buffers like autocomplete window, fuzzy
-- search etc.,

-- == Navigation ==
-- gD: Go to declaration
-- gd: Go to definition
-- gr: Go to references
-- gi: Go to implementation
-- gT: Go to type definition
-- [d: Previous diagnostic
-- ]d: Next diagnostic
-- [c: Previous diff hunk
-- ]c: Next diff hunk
-- [C: First diff hunk
-- ]C: Last diff hunk
-- <CR>: Jump 2D
-- <C-h/j/k/l>: Window movements

-- == Project ==
-- <leader>pf: Find files
-- <leader>ps: Live grep
-- <leader>pe: Explore
-- <leader>pt: Workspace symbols

-- == Buffer ==
-- <leader>bb: Buffers
-- <leader>bd: Close buffer
-- <leader>bn: New buffer
-- <leader>bt: Document symbols

-- == Operators ==
-- ga: Alignment
-- gA: Alignment with preview
-- S: Split-join toggle
-- sa: Surround add
-- sd: Surround delete
-- sr: Surround replace
-- sf: Surround find next
-- sF: Surround find previous
-- sh: Surround highlight

-- == Diff ==
-- -- <leader>ha: Diff hunk apply
-- -- <leader>hu: Diff hunk reset
-- -- <leader>hp: Diff hunk toggle

-- == LSP ==
-- K: Info on hover
-- <leader>lk: Signature help
-- <leader>lr: Rename
-- <leader>lc: Code action
-- <leader>le: Open diagnostics
-- <leader>lq: Populate loclist with diagnostics

-- ===== Package manager ======
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end

-- ===== Plugins =====
require('mini.deps').setup({ path = { package = path_package } })
local add = MiniDeps.add

add({ source = 'kana/vim-arpeggio' })
add({ source = 'neovim/nvim-lspconfig'})
add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  monitor = 'main',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
add({ source = 'alexghergh/nvim-tmux-navigation' })
add({ source = 'tpope/vim-sleuth' })

-- ===== Options =====
require('mini.basics').setup({
  options = {
    basic = true,
    extra_ui = true,
  },

  mappings = {
    basic = false,
    option_toggle_prefix = '',
  },

  autocommands = {
    basic = false,
  },
})

vim.opt.title = true
vim.opt.mouse = ''
vim.opt.spelllang = 'en_us'
vim.opt.fileencoding = 'utf-8'

vim.opt.wrap = true
vim.opt.cursorline = false
vim.opt.colorcolumn = '80'
vim.opt.list = true
vim.opt.listchars = [[tab:\ \,trail:·]]

vim.opt.gdefault = true
vim.opt.inccommand = 'split'

vim.opt.wildmode = 'list:longest,list:full'
vim.opt.wildignore = {
  '*.o', '*.obj', '*~', '*.git*', '*.meteor*', '*vim/backups*', '*sass-cache*',
  '*cache*', '*logs*', '*node_modules/**', '*DS_Store*', '*.gem', 'log/**',
  'tmp/**', '*.png', '*.jpg', '*.gif',
}

vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 5

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.g.tex_no_error = true
vim.g.tex_flavor = 'latex'
vim.g.tex_conceal = ''

-- ===== UI =====
require('mini.icons').setup()
require('mini.base16').setup({
  palette = {
    base00 = '#282828',
    base01 = '#3c3836',
    base02 = '#504945',
    base03 = '#665c54',
    base04 = '#bdae93',
    base05 = '#d5c4a1',
    base06 = '#ebdbb2',
    base07 = '#fbf1c7',
    base08 = '#fb4934',
    base09 = '#fe8019',
    base0A = '#fabd2f',
    base0B = '#b8bb26',
    base0C = '#8ec07c',
    base0D = '#83a598',
    base0E = '#d3869b',
    base0F = '#d65d0e',
  },
})

-- Statusline
function git_branch()
  if vim.b.git_branch_name == '' or MiniStatusline.is_truncated(40) then
    return ''
  else
    return ' ' .. vim.b.git_branch_name
  end
end

require('mini.statusline').setup({
  content = {
    active = function()
      local mode, mode_hl  = MiniStatusline.section_mode({ trunc_width = 120 })
      local git            = git_branch()
      local diff           = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics    = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp            = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename       = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo       = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local sleuth         = vim.fn.SleuthIndicator()

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { sleuth } },
      })
    end
  },
})

-- ===== Text objects =====
local gen_ai_spec = require('mini.extra').gen_ai_spec
require('mini.ai').setup({
  custom_textobjects = {
    B = gen_ai_spec.buffer(),
    L = gen_ai_spec.line(),
    I = gen_ai_spec.indent(),
    N = gen_ai_spec.number(),
  },
  mappings = {
    around = 'a',
    inside = 'i',
    around_next = '',
    inside_next = '',
    around_last = '',
    inside_last = '',
    goto_left = '',
    goto_right = '',
  },
})

-- ===== Operators =====
require('mini.align').setup({
  mapping = {
    start = '<leader>a',
    start_with_preview = '<leader>ap'
  }
})

require('mini.splitjoin').setup({
  mappings = {
    toggle = 'S',
    split = '',
    join = '',
  },
})

require('mini.surround').setup({
  mappings = {
    add = 'sa',
    delete = 'sd',
    find = 'sf',
    find_left = 'sF',
    highlight = 'sh',
    replace = 'sr',
    update_n_lines = '',

    suffix_last = 'l',
    suffix_next = 'n',
  },
})

-- ===== Autocompletion and Diagnostics =====
require('mini.pairs').setup()

require('mini.completion').setup({
  mappings = {
    force_twostep = '',
    force_fallback = '',
  }
})

vim.keymap.set(
  'i',
  '<C-j>',
  function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-j>' end,
  {silent = true, expr = true}
)

vim.keymap.set(
  'i',
  '<C-k>',
  function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-k>' end,
  {silent = true, expr = true}
)


-- LSP
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>lk', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, bufopts)
end

local servers = { "pyright", "texlab", "gopls", "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end

nvim_lsp["rust_analyzer"].setup {
  on_attach = on_attach,
  cmd = {"rustup", "run", "stable", "rust-analyzer"},
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        allFeatures = true,
        overrideCommand = {
          'cargo', 'clippy', '--workspace', '--message-format=json',
          '--all-targets', '--all-features'
        }
      }
    }
  }
}

nvim_lsp["clangd"].setup {
  cmd = {"clangd", "--background-index", "--clang-tidy"},
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = {"clangd", "--background-index", "--clang-tidy"}
  end,
  on_attach = on_attach
}

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false
})

vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Tree sitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" },
  },
  incremental_selection = {
    enable = false,
  },
  indent = {
    enable = true,
  },
})

-- ===== Git =====
-- Also allows setting references other than git index
require('mini.diff').setup({
  mappings = {
    apply = '<leader>ha',
    reset = '<leader>hu',
    textobject = 'gh',
    goto_first = '[C',
    goto_prev = '[c',
    goto_next = ']c',
    goto_last = ']C',
  }
})

vim.keymap.set('n', '<leader>hp', MiniDiff.toggle_overlay)

-- ===== Snippets =====
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    gen_loader.from_lang(),
  },
  mappings = {
    expand = '<C-e>',
    jump_next = '<C-l>',
    jump_prev = '<C-h>',
    stop = '<C-c>',
  },
})

-- ===== Navigation =====
require('mini.jump').setup()
require('mini.jump2d').setup({ mappings = { start_jumping = '<cr>' }})

require('nvim-tmux-navigation').setup({})
vim.keymap.set('n', '<C-h>', '<cmd>NvimTmuxNavigateLeft<cr>')
vim.keymap.set('n', '<C-j>', '<cmd>NvimTmuxNavigateDown<cr>')
vim.keymap.set('n', '<C-k>', '<cmd>NvimTmuxNavigateUp<cr>')
vim.keymap.set('n', '<C-l>', '<cmd>NvimTmuxNavigateRight<cr>')

-- ===== Fuzzy search =====
require('mini.extra').setup()
require('mini.pick').setup({
  mappings = {
    caret_left  = '<Left>',
    caret_right = '<Right>',

    choose            = '<CR>',
    choose_in_split   = '<C-s>',
    choose_in_tabpage = '<C-t>',
    choose_in_vsplit  = '<C-v>',
    choose_marked     = '<M-CR>',

    delete_char       = '<BS>',
    delete_char_right = '<Del>',
    delete_left       = '<C-u>',
    delete_word       = '<C-w>',

    mark     = '<C-x>',
    mark_all = '<C-a>',

    move_down  = '<C-j>',
    move_start = '<C-K>',
    move_up    = '<C-k>',

    paste = '<C-r>',

    refine        = '<C-Space>',
    refine_marked = '<M-Space>',

    scroll_down  = '<C-d>',
    scroll_left  = '<C-h>',
    scroll_right = '<C-l>',
    scroll_up    = '<C-u>',

    stop = '<esc>',

    toggle_info    = '<S-Tab>',
    toggle_preview = '<Tab>',
  },
})

vim.keymap.set('n', '<leader>pf', MiniPick.builtin.files)
vim.keymap.set('n', '<leader>ps', MiniPick.builtin.grep_live)
vim.keymap.set(
  'n',
  '<leader>pe',
  function() MiniExtra.pickers.explorer({ cwd = vim.fn.expand('%:p:h') }) end
)
vim.keymap.set(
  'n',
  '<leader>pt',
  function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol' }) end
)

vim.keymap.set('n', '<leader>bb', MiniPick.builtin.buffers)
vim.keymap.set(
  'n',
  '<leader>bt',
  function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end
)

-- ===== Misc mappings and commands =====
-- Open config
vim.api.nvim_create_user_command(
  'Vimconfig',
  function() vim.cmd('e ' .. vim.fn.expand('~/.config/nvim/init.lua')) end,
  {}
)

-- Remap escape
vim.g.arpeggio_timeoutlen = 150
vim.fn['arpeggio#map']('ixoc', '', 0, 'jk', '<Esc>')

--- Buffer related mappings
require('mini.bufremove').setup()
vim.keymap.set('n', '<leader>bd', ':bd<cr>', { silent = true })
vim.keymap.set('n', '<leader>bn', ':enew<cr>', { silent = true })

--- ===== Autocommands ======
--- Refresh buffer when editor gets focus
vim.api.nvim_create_autocmd({'BufEnter', 'FocusGained'}, {
  command = 'checktime'
})

-- Write server name into tmp file for latex backward search
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  callback = function()
    vim.fn.writefile({ vim.v.servername }, '/tmp/nvim_tex_server.txt')
  end
})

-- Unhilight search automatically
vim.api.nvim_create_autocmd('CursorMoved', {
  group = vim.api.nvim_create_augroup('auto-hlsearch', { clear = true }),
  callback = function ()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function () vim.cmd.nohlsearch() end)
    end
  end
})

-- Track git branch
local function branch_name()
  local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  if branch ~= "" then
    return branch
  else
    return ""
  end
end

vim.api.nvim_create_autocmd({"FileType", "BufEnter", "FocusGained"}, {
  callback = function()
    vim.b.git_branch_name = branch_name()
  end
})
