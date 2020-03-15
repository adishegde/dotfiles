" Plugin Installations {{{
call plug#begin('~/.local/share/nvim/plugged')

" color scheme
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'

" generic fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" ranger
Plug 'francoiscabrol/ranger.vim'

" auto-completion using language servers
Plug 'neoclide/coc.nvim', {'do': 'yarn install'}

" easy commenting
Plug 'tpope/vim-commentary'

" support for brackets, quotes etc
Plug 'jiangmiao/auto-pairs'

Plug 'Yggdroot/indentLine'

" status line
Plug 'itchyny/lightline.vim'

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

" Smooth repl interaction from vim
Plug 'rhysd/reply.vim', { 'on': ['Repl', 'ReplAuto'] }

" Alignment command
Plug 'godlygeek/tabular'

" Jinja syntax support
Plug 'lepture/vim-jinja'

call plug#end()
" END Plugin Installations }}}

" Plugin Configurations {{{
let g:indentLine_bufTypeExclude = ['json', 'tex', 'markdown']

"Force insert closing braces
let g:AutoPairsFlyMode = 0

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline.active = {
      \ 'right': [
      \   ['lineinfo'],
      \   ['percent'],
      \   ['filetype', 'fileencoding', 'sleuth_info']
      \ ]}
let g:lightline.component_function = {'sleuth_info': 'SleuthIndicator'}

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

let g:UltiSnipsSnippetsDir = expand("$HOME/.local/share/nvim/UltiSnips")
let g:UltiSnipsSnippetDirectories = [expand("$HOME/.local/share/nvim/UltiSnips")]
let g:UltiSnipsJumpForwardTrigger = "<c-d>"
let g:UltiSnipsJumpBackwardTrigger = "<c-u>"

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_python = ['black', 'docformatter']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_cpp = ['clangformat']

" Use only coc.nvim for LSP support
let g:vista_default_executive = 'coc'
let g:vista_executive_for = {
    \ 'markdown': 'toc',
    \ }

let g:sleuth_automatic = 1

let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

let g:tmux_navigator_no_mappings = 1
 "END Plugin Configurations }}}
