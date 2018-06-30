# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey -M viins 'jk' vi-cmd-mode

# Keep your system specific configuration here
[ -f "$HOME/.zshrc-local" ] && source "$HOME/.zshrc-local"

export TERM="xterm-256color"
export PYTHONPATH=/usr/local/bin/python2.7/site-packages:$PYTHONPATH
export GTAGSLABEL=pygments
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  docker        # Docker section
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_USE_ASYNC="true"

export LANG=en_US.UTF-8

# Easy access to config
alias zshconfig="$EDITOR ~/.zshrc"
alias vimconfig="$EDITOR ~/.config/nvim/init.vim"
alias zpreztoconfig="$EDITOR ~/.zpreztorc"

alias emterm="emacsclient -t"
alias v="nvim"

# start virtual box VM from command line
alias start-vm="VBoxManage startvm --type headless"

alias tsw="tmux switchc -t"
alias tl='tmux list-sessions'
alias trw="tmux renamew -t"
alias td="tmux detach-client"
alias ta='tmux attach -t'
alias ts='tmux new-session -s'

alias g="git"
alias ga='git add'
alias gc='git commit -v'
alias gd='git diff'
alias gds="git diff --staged"
alias glog='git log --oneline --decorate --graph'
alias glg='git log --stat'
alias gst='git status'
alias gp='git push'

alias l="ls -a"

alias dk="docker"

alias julia='/Applications/Julia-0.6.app/Contents/Resources/julia/bin/julia'

alias g14="clang++ -std=c++14"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Use OSX true colours
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1
