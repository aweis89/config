# Tmux
alias n='tmux new-session -s'
alias s='tmux switch -t'
alias a='tmux attach -d -t'
alias k='tmux kill-session -t'
alias t='tmux'

# Javascript
export PATH="$PATH:`yarn global bin`"
alias rn=react-native

# Bropages ingnore deprecations
alias bro='bro "$@" 2> /dev/null'

# Git
alias ggpull='git pull origin HEAD'
alias ggpush='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gstatus='git status -sb'
alias glog="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"

# Neovim editor
alias vim=nvim
alias v=nvim
alias nano=nvim
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export VISUAL=vim
export EDITOR=$VISUAL

# Settings files
alias nvims="$EDITOR $HOME/.config/nvim/init.vim"
alias tmuxs="$EDITOR $HOME/.tmux.conf"
alias zshs="$EDITOR $HOME/.zshrc"

# Docker
alias dr='docker run -it --rm'
alias dc=docker-compose

source ~/.zsh/fzf.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/z/z.sh

SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
bindkey '^ ' autosuggest-execute
bindkey '^f' autosuggest-accept
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=250'

export GOBIN=$HOME/Apps/golang/bin
export PATH=$PATH:$GOBIN
fpath=(~/.zsh/completion $fpath)

# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# autojump
alias d=z

autoload -U promptinit; promptinit
prompt pure
