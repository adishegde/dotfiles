"================ Persistent Undo ==================
call plug#begin('~/.local/share/nvim/plugged')

Plug 'pangloss/vim-javascript'                                                  "Javascript syntax and indentation improvement
Plug 'maxmellon/vim-jsx-pretty'

Plug 'morhetz/gruvbox'                                                          "Color scheme
Plug 'joshdick/onedark.vim'
Plug 'iCyMind/NeoSolarized'

" See mappings
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }               "Searching interface
Plug 'junegunn/fzf.vim'

" See mappings
Plug 'rafaqz/ranger.vim'                                                        "File Browser

Plug 'neoclide/coc.nvim', {'do': 'yarn install'}                                "Autocompletion

" See mappings
Plug 'scrooloose/nerdcommenter'                                                 "Commenting text fast

Plug 'neomake/neomake'                                                          "Run programs and linting
Plug 'benjie/neomake-local-eslint.vim'                                          "Use local eslint with neomake over global one

Plug 'jiangmiao/auto-pairs'                                                     "Support for pairwise modifications of branckets etc,.

Plug 'Yggdroot/indentLine'                                                      "Indent Lines

"See mappings
Plug 'majutsushi/tagbar'                                                        "Tagbar for easy navigation

Plug 'vim-airline/vim-airline'                                                  "Status/tab line
Plug 'vim-airline/vim-airline-themes'                                           "Themes for other plugins

" cs change, ys surround, ds delete, yss for line surround, S in visual
Plug 'tpope/vim-surround'                                                       "Surround operator

" {i/a}{pair char}, use a for arguments
Plug 'wellle/targets.vim'                                                       "Defines text objects for easy manipulation

Plug 'haya14busa/is.vim'                                                        "Improves incremental search

Plug 'ludovicchabant/vim-gutentags'                                             "Tag file generation automated

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': [
      \ 'javascript',
      \ 'typescript',
      \ 'css',
      \ 'less',
      \ 'scss',
      \ 'json',
      \ 'graphql',
      \ 'markdown',
      \ 'vue'
  \ ] }

Plug 'kana/vim-arpeggio'                                                        "Define simultaneous mappings with custom delays
Plug 'tpope/vim-sleuth'                                                         "Detect and set indentation related variables

Plug 'alvan/vim-closetag'                                                       "Automatically close HTML tags

Plug 'wakatime/vim-wakatime'                                                    "Wakatime for vim

Plug 'danro/rename.vim'                                                         "Rename a file and buffer in vim

"You can jump between hunks with [c and ]c. You can preview, stage, and undo
"hunks with <leader>hp, <leader>hs, and <leader>hu respectively.
Plug 'airblade/vim-gitgutter'                                                   "Show diff in gutter

Plug 'SirVer/ultisnips'                                                         "Snippet engine neovim

":NeoTex to compile, NeoTexOn to start live updates and NeoTexOff to stop live
"updates
Plug 'donRaphaco/neotex', { 'for': 'tex' }                                      "Live latex preview

Plug 'tomlion/vim-solidity'                                                     "Solidity syntax support

Plug 'vim-pandoc/vim-pandoc'                                                    "Pandoc markdown support and syntax highlight
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'ryanoasis/vim-devicons'                                                   "Icons for plugins

call plug#end()

" ================ General Config ====================
filetype plugin indent on                                                       "Enable plugins and indents by filetype

let g:mapleader =  " "                                                          "Change leader to a space

let g:onedark_terminal_italics = 1                                              "Enable italic font
let g:onedark_termcolors=16

set termguicolors
set title                                                                       "change the terminal's title
set number                                                                      "Line numbers are good
set relativenumber                                                              "Show numbers relative to current line
set showcmd                                                                     "Show incomplete cmds down the bottom
set gdefault                                                                    "Set global flag for search and replace
set gcr=a:blinkon500-blinkwait500-blinkoff500                                   "Set cursor blinking rate
set smartcase                                                                   "Smart case search if there is uppercase
set ignorecase                                                                  "case insensitive search
set showmatch                                                                   "Highlight matching bracket
set nostartofline                                                               "Jump to first non-blank character
set timeoutlen=1000 ttimeoutlen=0                                               "Reduce Command timeout for faster escape and O
set fileencoding=utf-8                                                          "Set utf-8 encoding on write
set wrap                                                                        "Enable word wrap
set linebreak                                                                   "Wrap lines at convenient points
set listchars=tab:\ \ ,trail:·                                                  "Set trails for tabs and spaces
set list                                                                        "Enable listchars
set lazyredraw                                                                  "Do not redraw on registers and macros
set background=dark                                                             "Set background to dark
set hidden                                                                      "Hide buffers in background
set splitright                                                                  "Set up new vertical splits positions
set splitbelow                                                                  "Set up new horizontal splits positions
set inccommand=split                                                            "Show substitute changes immidiately in separate split
set fillchars+=vert:\│                                                          "Make vertical split separator full line
set pumheight=30                                                                "Maximum number of entries in autocomplete popup
set foldmethod=syntax                                                           "Set syntax based folding
set nofoldenable
set colorcolumn=80
set t_Co=256
set cmdheight=2                                                                 "Better display for messages
set signcolumn=yes

syntax on                                                                       "turn on syntax highlighting
let $NVIM_TUI_ENABLE_TRUE_COLOR=1                                               "This line enables the true color support.

colorscheme onedark

hi ColorColumn ctermbg=237 guibg=#3c3836

let g:python_host_prog=expand("$HOME/.local/share/nvim/python2/bin/python")     "Path to python interpretters
let g:python3_host_prog=expand("$HOME/.local/share/nvim/python3/bin/python3")

let g:indentLine_fileTypeExclude = ['json', 'tex']

let g:NERDCompactSexyComs = 1                                                   "Good looking multiline comments

let g:AutoPairsFlyMode = 0                                                      "Force insert closing braces
let g:AutoPairsShortcutBackInsert = '<M-b>'                                     "To override/remove FlyMode inserted char

let g:airline#extensions#tabline#enabled = 1                                    "Show buffers if only one tab
let g:airline_theme='onedark'
let g:airline_section_z='%p%% : %{SleuthIndicator()} : %l/%L : %c'

call neomake#configure#automake('w')                                            "Call neomake maker on write
"let g:neomake_open_list = 2                                                     "Open location list automatically
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_tex_enabled_makers = ['lacheck']

set encoding=utf8                                                               "Settings for devicons
set guifont=<FONT_NAME>:h<FONT_SIZE>
set guifont=DroidSansMono_Nerd_Font:h11

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

" Ultisnips completion through Ctrl+j
let g:UltiSnipsSnippetsDir = expand("$HOME/.local/share/nvim/UltiSnips")
let g:UltiSnipsSnippetDirectories = [expand("$HOME/.local/share/nvim/UltiSnips")]

let g:tex_flavor = 'latex'
let g:pandoc#syntax#conceal#use = 0

let g:neotex_latexdiff = 1
let g:neotex_pdflatex_alternative = 'xelatex'
let g:neotex_subfile = 1

let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 4
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#semi = 'true'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'
let g:prettier#config#prose_wrap = 'preserve'

set updatetime=100                                                              "To make vim-gutter update faster

" ================ Persistent Undo ==================

silent !mkdir ~/.local/share/nvim/undos > /dev/null 2>&1                        "Keep undo history across sessions, by storing in file.
set undodir=~/.local/share/nvim/undos
set undofile

" ================ Completion =======================

set wildmode=list:full
set wildignore=*.o,*.obj,*~                                                     "stuff to ignore when tab completing
set wildignore+=*.git*
set wildignore+=*.meteor*
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8                                                                 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=5

" ================ Auto commands ======================

augroup vimrc
    autocmd!

    autocmd vimrc FocusGained,BufEnter * checktime                                  "Refresh file when vim gets focus
    autocmd vimrc BufWritePre * :call StripTrailingWhitespaces()                    "Auto-remove trailing spaces

    autocmd Filetype json let g:indentLine_enabled = 0                              "Indent lines hides quotes in json

    autocmd FileType tex setlocal spell spelllang=en_gb                             "Spell checking in tex files
    autocmd FileType tex syntax spell toplevel                                      "Spell checking in tex files

    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" ================ Functions ========================

function! StripTrailingWhitespaces()
  if &modifiable
    let l:l = line(".")
    let l:c = col(".")
    %s/\s\+$//e
    call cursor(l:l, l:c)
  endif
endfunction

" ================ Mappings ========================

call arpeggio#map('ixoc', '', 0, 'jk', '<Esc>')

map <leader>rr :RangerEdit<cr>

nmap <leader>t :TagbarToggle<cr>

nnoremap <leader>wj <C-W><C-J>
nnoremap <leader>wk <C-W><C-K>
nnoremap <leader>wl <C-W><C-L>
nnoremap <leader>wh <C-W><C-H>

nnoremap <silent> <Leader>pf :Files<CR>
nnoremap <silent> <Leader>pt :Tags<CR>
nnoremap <leader>ps :Ag<Space>

nnoremap <silent> <Leader>bb :Buffers<CR>
nnoremap <silent> <Leader>bt :BTags<CR>
nnoremap <silent> <Leader>bc :BCommits<CR>
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>bn :enew<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <C-j> and <C-k> for navigation
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm. Force select before
" confirm
 inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
