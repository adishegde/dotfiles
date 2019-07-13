" Plugin Installations {{{
call plug#begin('~/.local/share/nvim/plugged')

" color scheme
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

" generic fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" language support
Plug 'sheerun/vim-polyglot'

" file browser
Plug 'rafaqz/ranger.vim'

" auto-completion using language servers
Plug 'neoclide/coc.nvim', {'do': 'yarn install'}

" function signature support for coc
Plug 'Shougo/echodoc.vim'

" easy commenting
Plug 'scrooloose/nerdcommenter'

" async make and linting
Plug 'neomake/neomake'

" using local eslint with neomake
Plug 'benjie/neomake-local-eslint.vim'

" support for brackets, quotes etc
Plug 'jiangmiao/auto-pairs'

Plug 'Yggdroot/indentLine'

" status line and associated themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround'

" helpful text objects like arguements etc
Plug 'wellle/targets.vim'

" incremental search
Plug 'haya14busa/is.vim'

" automatic tagfile generation
" not that useful due to coc usage
"Plug 'ludovicchabant/vim-gutentags'

" extensive key-chord support
Plug 'kana/vim-arpeggio'

" automatically set indentation related settings
Plug 'tpope/vim-sleuth'

" close html tags automatically
Plug 'alvan/vim-closetag'

" wakatime integration
Plug 'wakatime/vim-wakatime'

" command to rename files correctly
Plug 'danro/rename.vim'

" basic git integration
Plug 'airblade/vim-gitgutter'

" snippet support
Plug 'SirVer/ultisnips'

" extensive latex support
Plug 'lervag/vimtex'

" icons
Plug 'ryanoasis/vim-devicons'

" sane buffer close logic
Plug 'rbgrouleff/bclose.vim'

" automatic code formatting
Plug 'sbdchd/neoformat'

call plug#end()
" END Plugin Installations }}}

" Plugin Configurations {{{

let g:polyglot_disabled = ['latex']

let g:indentLine_fileTypeExclude = ['json', 'tex']

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

"Call neomake maker on write
call neomake#configure#automake('w')
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_tex_enabled_makers = ['lacheck']

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

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx'

let g:UltiSnipsSnippetsDir = expand("$HOME/.local/share/nvim/UltiSnips")
let g:UltiSnipsSnippetDirectories = [expand("$HOME/.local/share/nvim/UltiSnips")]

let g:tex_flavor = 'latex'
let g:tex_conceal = ''
let g:vimtex_latexmk_continuous = 1
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_method = 'skim'
let g:vimtex_fold_enabled = 1

let g:echodoc#enable_at_startup = 1

let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_less = ['prettier']
let g:neoformat_enabled_scss = ['prettier']
let g:neoformat_enabled_json = ['prettier']
let g:neoformat_enabled_graphql = ['prettier']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_vue = ['prettier']
let g:neoformat_tex_latexindentcustom = {
      \'exe': 'latexindent',
      \'args': ['-g /dev/stderr']
      \}
let g:neoformat_enabled_tex = ['neoformat_tex_latexindentcustom']

" END Plugin Configurations }}}