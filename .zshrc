
alias tmuxs="vim ~/.tmux.conf"
alias zshs="vim ~/.zshrc"
alias vims="vim ~/.vimrc"
alias n='tmux new-session -s'
alias s='tmux switch -t'
alias a='tmux attach -t'
alias ttas='tmux new-session -n:tas '\''teamocil tas'\'''
alias servers='tmux new-session -n:servers '\''teamocil servers'\'''
alias kill-servers='/Users/aweisberg/scripts/kill_servers.sh'
alias restart-servers="kill-servers && tmux kill-session -t servers && servers"

alias vi="vim"
alias cddocs="cd /Users/aweisberg/Documents"
alias cdtas="cd /Users/aweisberg/Documents/rails_apps/tas"
alias cdmember="cd /Users/aweisberg/Documents/rails_apps/member"
alias cdrte="cd /Users/aweisberg/Documents/rails_apps/rte"
alias cdadmin="cd /Users/aweisberg/Documents/rails_apps/admin"
alias cdcallcenter="cd /Users/aweisberg/Documents/rails_apps/callcenter"
alias cdprovider="cd /Users/aweisberg/Documents/rails_apps/provider"
alias cdclient="cd /Users/aweisberg/Documents/rails_apps/client"
alias cdframework="cd /Users/aweisberg/Documents/rails_apps/teladoc_framework"
alias cdapps="cd /Users/aweisberg/Documents/rails_apps"
alias cdapi="cd /Users/aweisberg/Documents/rails_apps/teladoc_api"

alias tas="cdtas && vim"
alias member="cdmember && vim"
alias rte="cdrte && vim"
alias admin="cdadmin && vim"
alias callcenter="cdcallcenter && vim"
alias provider="cdprovider && vim"
alias client="cdclient && vim"
alias framework="cdframework && vim"
alias api="cdapi && vim"

alias copyconfig="less ~/.vimrc > /Users/aweisberg/Documents/config/.vimrc && less ~/.tmux.conf > /Users/aweisberg/Documents/config/.tmux.conf && less ~/.zshrc > /Users/aweisberg/Documents/config/.zshrc"

alias memcache="/usr/local/bin/memcached"
alias dep="ssh deploy1.dev.teladoc.com"
alias my_env="ssh aweisberg.dev.teladoc.com"
alias prod="ssh prodmirror.dev.teladoc.com"
alias prod2="ssh prodmirror2.dev.teladoc.com"

#DISABLE_AUTO_TITLE=true

ssh='ssh env.dev.teladoc.com'
# Path to your oh-my-zsh installation.
 export ZSH=$HOME/.oh-my-zsh

 # Set name of the theme to load.
 # Look in ~/.oh-my-zsh/themes/
 # Optionally, if you set this to "random", it'll load a random theme each
 # time that oh-my-zsh is loaded.
 ZSH_THEME="robbyrussell"

 # Example aliases
 # alias zshconfig="mate ~/.zshrc"
 # alias ohmyzsh="mate ~/.oh-my-zsh"

 # Uncomment the following line to use case-sensitive completion.
 # CASE_SENSITIVE="true"

 # Uncomment the following line to disable bi-weekly auto-update checks.
 # DISABLE_AUTO_UPDATE="true"

 # Uncomment the following line to change how often to auto-update (in days).
 # export UPDATE_ZSH_DAYS=13

 # Uncomment the following line to disable colors in ls.
 # DISABLE_LS_COLORS="true"

 # Uncomment the following line to disable auto-setting terminal title.
 # DISABLE_AUTO_TITLE="true"

 # Uncomment the following line to disable command auto-correction.
 # DISABLE_CORRECTION="true"

 # Uncomment the following line to display red dots whilst waiting for completion.
  #COMPLETION_WAITING_DOTS="true"

 # Uncomment the following line if you want to disable marking untracked files
 # under VCS as dirty. This makes repository status check for large repositories
 # much, much faster.
 # DISABLE_UNTRACKED_FILES_DIRTY="true"

 # Uncomment the following line if you want to change the command execution time
 # stamp shown in the history command output.
 # The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
 # HIST_STAMPS="mm/dd/yyyy"

 # Would you like to use another custom folder than $ZSH/custom?
 # ZSH_CUSTOM=/path/to/new-custom-folder

 # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
 # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
 # Example format: plugins=(rails git textmate ruby lighthouse)
 plugins=(git)

 source $ZSH/oh-my-zsh.sh

 # User configuration

 export PATH=$HOME/bin:/usr/local/bin:$PATH
 # export MANPATH="/usr/local/man:$MANPATH"

 # You may need to manually set your language environment
 # export LANG=en_US.UTF-8

 # Preferred editor for local and remote sessions
 # if [[ -n $SSH_CONNECTION ]]; then
 #   export EDITOR='vim'
 # else
 #   export EDITOR='mvim'
 # fi

 # Compilation flags
 # export ARCHFLAGS="-arch x86_64"

 # ssh
 # export SSH_KEY_PATH="~/.ssh/dsa_id"
export PATH=$PATH:~/bin
export PATH=$PATH:~/scripts
export PATH=/usr/local/bin:$PATH

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*



# Teamocil autocomplete
#compctl -g '~/.teamocil/*(:t:r)' teamocil
