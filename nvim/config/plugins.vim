" Plugin Installations {{{
call plug#begin('~/.local/share/nvim/plugged')

" color scheme
Plug 'morhetz/gruvbox'

" generic fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" file browser
Plug 'rafaqz/ranger.vim'

" auto-completion using language servers
Plug 'neoclide/coc.nvim', {'do': 'yarn install'}

" easy commenting
Plug 'tyru/caw.vim'

" support for brackets, quotes etc
Plug 'jiangmiao/auto-pairs'

Plug 'Yggdroot/indentLine'

" status line and associated themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'machakann/vim-sandwich'

" helpful text objects like arguements etc
Plug 'wellle/targets.vim'

" incremental search
Plug 'haya14busa/is.vim'

" extensive key-chord support
Plug 'kana/vim-arpeggio'

" automatically set indentation related settings
Plug 'tpope/vim-sleuth'

" command to rename files correctly
Plug 'danro/rename.vim'

" basic git integration
Plug 'airblade/vim-gitgutter'

" snippet support
Plug 'SirVer/ultisnips'

" icons
Plug 'ryanoasis/vim-devicons'

" sane buffer close logic
Plug 'rbgrouleff/bclose.vim'

" smooth tmux and vim split movement
Plug 'christoomey/vim-tmux-navigator'

" tagbar using LSP
Plug 'liuchengxu/vista.vim'

" autoformatting
Plug 'sbdchd/neoformat'

" TOML syntax support
Plug 'cespare/vim-toml'

" Run commands asynchronously
Plug 'skywind3000/asyncrun.vim'

" Documentation
Plug 'kkoomen/vim-doge'

" Smooth repl interaction from vim
Plug 'rhysd/reply.vim', { 'on': ['Repl', 'ReplAuto'] }

call plug#end()
" END Plugin Installations }}}

" Plugin Configurations {{{

let g:polyglot_disabled = ['latex']

let g:indentLine_fileTypeExclude = ['json', 'tex', 'markdown']

"Good looking multiline comments
let g:NERDCompactSexyComs = 1

"Force insert closing braces
let g:AutoPairsFlyMode = 0
"To override/remove FlyMode inserted char
let g:AutoPairsShortcutBackInsert = '<M-b>'

"Show buffers if only one tab
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox'
let g:airline_section_z='%p%% : %{SleuthIndicator()} : %l/%L : %c'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:arpeggio_timeoutlen=200

let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'javascript.jsx' : 1,
    \}

let g:UltiSnipsSnippetsDir = expand("$HOME/.local/share/nvim/UltiSnips")
let g:UltiSnipsSnippetDirectories = [expand("$HOME/.local/share/nvim/UltiSnips")]
let g:UltiSnipsJumpForwardTrigger = "<c-d>"
let g:UltiSnipsJumpBackwardTrigger = "<c-u>"

let g:tex_flavor = 'latex'
let g:tex_conceal = ''

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_python = ['black', 'docformatter']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_cpp = ['uncrustify']
let g:neoformat_enabled_java = ['uncrustify']

" Use only coc.nvim for LSP support
let g:vista_default_executive = 'coc'
let g:vista_executive_for = {
    \ 'markdown': 'toc',
    \ }

let g:doge_enable_mappings = 1
let g:doge_mapping_comment_jump_forward = "<c-d>"
let g:doge_mapping_comment_jump_backward = "<c-u>"

let g:caw_operator_keymappings = 1
 "END Plugin Configurations }}}
