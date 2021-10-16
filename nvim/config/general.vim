"Enable plugins and indents by filetype
filetype plugin indent on

"Change leader to a space
let g:mapleader =  " "

"Local vimrc files allowed
set exrc

"Disable auto, shell and write commands from being run in .nvimrc
set secure

set termguicolors

"Change the terminal's title
set title

set number
set relativenumber

"Show incomplete cmds down the bottom
set showcmd

"Set global flag for search and replace
set gdefault

"Smart case search if there is uppercase
set smartcase
"case insensitive search
set ignorecase

"Highlight matching bracket
set showmatch

"Jump to first non-blank character
set nostartofline

"Reduce Command timeout for faster escape and O
set timeoutlen=1000 ttimeoutlen=0

"Set utf-8 encoding on write
set fileencoding=utf-8

"Enable word wrap
set wrap
"Wrap lines at convenient points
set linebreak

"Set trails for tabs and spaces
set listchars=tab:\ \ ,trail:·

"Enable listchars
set list

"Do not redraw on registers and macros
set lazyredraw

"Set background to dark
set background=dark

"Hide buffers in background
set hidden

"Set up new vertical splits positions
set splitright
"Set up new horizontal splits positions
set splitbelow

"Show substitute changes immidiately in separate split
set inccommand=split

"Make vertical split separator full line
set fillchars+=vert:\│

"Maximum number of entries in autocomplete popup
set pumheight=30

"Set syntax based folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set nofoldenable
set colorcolumn=80
set t_Co=256
set signcolumn=yes
set shortmess+=c
set encoding=utf8
set updatetime=100

"Better display for messages
set cmdheight=2

"Some LSP servers don't work well with backups
set nobackup
set nowritebackup

set spelllang=en_us

"This line enables the true color support.
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set completeopt=menu,menuone,noselect

"Path to python interpretters
let g:loaded_python_provider = 0
let g:python3_host_prog=expand("$HOME/.local/share/nvim/python3/bin/python3")

"Turn on syntax highlighting
syntax enable
colorscheme gruvbox
hi ColorColumn ctermbg=237 guibg=#3c3836

" Tex error check are more painful than helpful
let g:tex_no_error=1
let g:tex_flavor = 'latex'
let g:tex_conceal = ''

"Keep undo history across sessions, by storing in file.
silent !mkdir ~/.local/share/nvim/undos > /dev/null 2>&1
set undodir=~/.local/share/nvim/undos
set undofile

" Completion
set wildmode=list:full
set wildignore=*.o,*.obj,*~
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

" Scrolling
set scrolloff=8
set sidescrolloff=15
set sidescroll=5

" Editor and Indentation
" Good defaults, plugins update as required
set shiftwidth=4
set expandtab
set softtabstop=0
set smarttab
