filetype plugin indent on                                                       "Enable plugins and indents by filetype

let g:mapleader =  " "                                                          "Change leader to a space

set exrc                                                                        "Local vimrc files allowed
set secure                                                                      "Disable auto, shell and write commands from being run in .nvimrc
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
set shortmess+=c
set encoding=utf8
set guifont=<FONT_NAME>:h<FONT_SIZE>
set guifont=DroidSansMono_Nerd_Font:h11
set updatetime=100

let $NVIM_TUI_ENABLE_TRUE_COLOR=1                                               "This line enables the true color support.
let g:onedark_terminal_italics = 1                                              "Enable italic font
let g:onedark_termcolors=16
let g:python_host_prog=expand("$HOME/.local/share/nvim/python2/bin/python")     "Path to python interpretters
let g:python3_host_prog=expand("$HOME/.local/share/nvim/python3/bin/python3")

syntax on                                                                       "Turn on syntax highlighting
colorscheme gruvbox
hi ColorColumn ctermbg=237 guibg=#3c3836

silent !mkdir ~/.local/share/nvim/undos > /dev/null 2>&1                        "Keep undo history across sessions, by storing in file.
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
