" Plugin Installations {{{
call plug#begin('~/.local/share/nvim/plugged')

" color scheme
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'

" Generic fuzzy search
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Ranger
Plug 'francoiscabrol/ranger.vim'

" Auto-completion using language servers
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'GoldsteinE/compe-latex-symbols'
Plug 'onsails/lspkind-nvim'

" Tree-sitter configuration
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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

call plug#end()
" Plugin Installations }}}

" Plugin Configurations {{{
lua << EOF
-- LSP config
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require'lspconfig'.rust_analyzer.setup{capabilities = capabilities}
require'lspconfig'.pyright.setup{}
require'lspconfig'.texlab.setup{}
require'lspconfig'.clangd.setup{
  cmd = {"clangd", "--background-index", "--clang-tidy"},
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = {"clangd", "--background-index", "--clang-tidy"}
  end,
}

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

require('lspkind').init({})

-- Autopairs config
local npairs = require'nvim-autopairs'
local Rule = require('nvim-autopairs.rule')
npairs.setup({
  enable_check_bracket_line = false
})
npairs.add_rules({
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col, opts.col + 1)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule("$", "$",{"tex", "latex"})
})
require("nvim-autopairs.completion.compe").setup({
  map_cr = true,
  map_complete = true
})

-- Compe config
require'compe'.setup {
  source = {
    path = true;
    buffer = true;
    spell = true;
    nvim_lsp = true;
    nvim_lua = true;
    ultisnips = true;
    latex_symbols = true;
  };
}

-- Tree-sitter config
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
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
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  }
}
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

let g:arpeggio_timeoutlen=200

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_python = ['black', 'docformatter']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_cpp = ['clangformat']

let g:sleuth_automatic = 1

let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

let g:tmux_navigator_no_mappings = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
 " Plugin Configurations }}}
