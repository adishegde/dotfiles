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
" Plug 'ray-x/lsp_signature.nvim'

" Tree-sitter configuration
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' }

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

" Organization and notes
" Requires plenary.nvim
Plug 'nvim-neorg/neorg'

Plug 'phaazon/hop.nvim'

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
    { name = 'neorg' },
    { name = 'calc' },
  }
})

cmp.event:on(
  'confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done()
)

-- LSP config
local nvim_lsp = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

nvim_lsp.pyright.setup{capabilities = capabilities}
nvim_lsp.texlab.setup{capabilities = capabilities}
nvim_lsp.gopls.setup{capabilities = capabilities}
nvim_lsp.clangd.setup{
  capabilities = capabilities,
  cmd = {"clangd", "--background-index", "--clang-tidy"},
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = {"clangd", "--background-index", "--clang-tidy"}
  end,
}
nvim_lsp.rust_analyzer.setup{capabilities = capabilities}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>lk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>lc', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>le', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "texlab", "gopls", "clangd", "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

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
  Rule("$", "$",{"tex", "latex"})
})

-- Neorg setup
require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          main = "~/icloud/neorg"
        }
      }
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp"
      }
    }
  },
  hook = function()
    local neorg_leader = "<leader>o" -- You may also want to set this to <Leader>o for "organization"
    local neorg_callbacks = require('neorg.callbacks')

    neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
      keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode
          { "<leader>td", "core.norg.qol.todo_items.todo.task_done" },
          { "<leader>tu", "core.norg.qol.todo_items.todo.task_undone" },
          { "<leader>tp", "core.norg.qol.todo_items.todo.task_pending" },
          { "<leader>tc", "core.norg.qol.todo_items.todo.task_cycle" }
        },
      }, { silent = true, noremap = true })
    end)
  end
}

-- Tree-sitter config
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
}

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

-- LSP Signature setup
-- require('lsp_signature').setup()

-- Hop setup
require('hop').setup()
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
