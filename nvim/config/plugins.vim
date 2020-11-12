" Plugin Installations {{{
call plug#begin('~/.local/share/nvim/plugged')

" color scheme
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'chuling/ci_dark'

" Generic fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Ranger
Plug 'francoiscabrol/ranger.vim'

" Auto-completion using language servers
Plug 'neoclide/coc.nvim', {'do': 'yarn install'}

" Easy commenting
Plug 'tpope/vim-commentary'

" Support for brackets, quotes etc
Plug 'jiangmiao/auto-pairs'

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
Plug 'ryanoasis/vim-devicons'

" Sane buffer close logic
Plug 'rbgrouleff/bclose.vim'

" Smooth tmux and vim split movement
Plug 'christoomey/vim-tmux-navigator'

" Tagbar using LSP
Plug 'liuchengxu/vista.vim'

" Autoformatting
Plug 'sbdchd/neoformat'

" TOML syntax support
Plug 'cespare/vim-toml'

" Run commands asynchronously
Plug 'skywind3000/asyncrun.vim'

" Alignment command
Plug 'godlygeek/tabular'

" LaTeX folding support
Plug 'matze/vim-tex-fold'

call plug#end()
" Plugin Installations }}}

" Plugin Configurations {{{
"Force insert closing braces
let g:AutoPairsFlyMode = 0

let g:lightline = {}
let g:lightline.colorscheme = 'ci_dark'
let g:lightline.active = {
      \ 'right': [
      \   ['lineinfo'],
      \   ['percent'],
      \   ['filetype', 'fileencoding', 'sleuth_info'],
      \   ['cocdiagnostic']
      \ ]}
let g:lightline.component_function = {'sleuth_info': 'SleuthIndicator', 'cocdiagnostic': 'CocStatusDiagnostic'}

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
 " Plugin Configurations }}}
