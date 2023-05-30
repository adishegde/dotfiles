" Plugin Installations {{{
call plug#begin('~/.local/share/nvim/plugged')

" color scheme
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'

" Generic fuzzy search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'

" Ranger
Plug 'francoiscabrol/ranger.vim'

" LSP
Plug 'neovim/nvim-lspconfig'

" Auto-completion using language servers
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-calc'

" Tree-sitter configuration
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" Easy commenting
Plug 'tpope/vim-commentary'

" Support for brackets, quotes etc
Plug 'windwp/nvim-autopairs'

" Lightweight status line
Plug 'itchyny/lightline.vim'

" Surround operators
Plug 'machakann/vim-sandwich'

" Helpful text objects like arguements etc
Plug 'wellle/targets.vim'

" Extensive key-chord support
Plug 'kana/vim-arpeggio'

" Automatically set indentation related settings
Plug 'tpope/vim-sleuth'

" Command to rename files correctly
Plug 'danro/rename.vim'

" Basic git integration
Plug 'airblade/vim-gitgutter'

" Snippet support
Plug 'SirVer/ultisnips'

" Icons
Plug 'kyazdani42/nvim-web-devicons'

" Sane buffer close logic
Plug 'rbgrouleff/bclose.vim'

" Smooth tmux and vim split movement
Plug 'christoomey/vim-tmux-navigator'

" Autoformatting
Plug 'sbdchd/neoformat'

" Alignment command
Plug 'godlygeek/tabular'

" Highlight current search result
Plug 'adamheins/vim-highlight-match-under-cursor'

" Jump to any point in the screen
Plug 'ggandor/leap.nvim'

call plug#end()
" Plugin Installations }}}

" Plugin Configurations {{{
lua << EOF
-- Cmp config
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.complete(),
    ['<C-x>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
    { name = 'calc' },
  }
})

cmp.event:on(
  'confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done()
)

-- LSP config
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>lk', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, bufopts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
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

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

require('lspkind').init({})

-- Autopairs config
local npairs = require('nvim-autopairs')

local Rule = require('nvim-autopairs.rule')
npairs.setup({ enable_check_bracket_line = false })
npairs.add_rules({
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col, opts.col + 1)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule("$", "$",{"tex", "latex", "markdown"})
})

-- Tree-sitter config
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
}

-- Devicons setup
require'nvim-web-devicons'.setup {
  default = true;
}

-- Telescope setup
local actions = require("telescope.actions")
require('telescope').setup{
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  }
}
require('telescope').load_extension('fzf')

-- Leap setup
require('leap').add_default_mappings()
EOF

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.active = {
      \ 'right': [
      \   ['lineinfo'],
      \   ['percent'],
      \   ['filetype', 'fileencoding', 'sleuth_info']
      \ ]}
let g:lightline.component_function = {'sleuth_info': 'SleuthIndicator'}

let g:arpeggio_timeoutlen = 200

let g:sandwich_no_default_key_mappings = 1
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_python = ['black', 'docformatter']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_rust = ['rustfmt']

let g:sleuth_automatic = 1

let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

let g:tmux_navigator_no_mappings = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
 " Plugin Configurations }}}
