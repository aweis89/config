# Auto start/attach default tmux session
if test -z $TMUX; then
  name=default
  tmux attach -d -t $name 2> /dev/null || tmux new-session -s $name
fi

# Source Prezto.
if [ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Trackpad enable/disable
alias ton="xinput --enable 11"
alias toff="xinput --disable 11"

# Ubuntu key mappings
alias xx="xmodmap $HOME/.Xmodmap"

# Tmux
alias tmux='tmux -q'
alias n='tmux new-session -s'
alias s='tmux switch -t'
alias a='tmux attach -d -t'
alias k='tmux kill-session -t'
alias t='env TERM=xterm-256color tmux'

# File picker
alias fpp='~/.zsh/fpp/fpp'
# Javascript
# export PATH="$PATH:`yarn global bin`"
alias rn=react-native

# Bropages ingnore deprecations
alias bro='bro "$@" 2> /dev/null'

# Git
alias ggpull='git pull origin $(git rev-parse --abbrev-ref HEAD)'
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
alias sshs="$EDITOR $HOME/.ssh/config"

# Docker
alias dr='docker run -it --rm'
alias dc=docker-compose

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
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

# Add addtional char when previous command fails
PROMPT='%(?.%F{magenta}.%F{red}❯%F{magenta})❯%f '

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source $HOME/.rvm/scripts/rvm

alias open=xdg-open

# Rename tmux window on ssh
ssh() {
  if test -z $TMUX; then
    command ssh "$@"
  else
    orig_name=$(tmux display-message -p '#W')
    new_name="${@: -1}"
    tmux rename-window "$new_name"
    command ssh "$@"
    tmux rename-window $orig_name
  fi
}


export ANDROID_HOME=$HOME/android-sdk-linux
export PATH=${PATH}:$HOME/android-sdk-linux/platform-tools:$HOME/android-sdk-linux/tools:$HOME/android-sdk-linux/build-tools/22.0.1/
source /usr/local/bin/aws_zsh_completer.sh
source <(kubectl completion zsh)
