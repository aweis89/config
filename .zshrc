#Tmux
#alias tmux="tmux -2"
alias tmux='TERM=screen-256color-bce tmux'
alias tmuxs="vim ~/.tmux.conf"
alias zshs="vim ~/.zshrc"
alias vims="vim ~/.vimrc"
alias n='tmux new-session -s'
alias s='tmux switch -t'
alias a='tmux attach -d -t'
alias k='tmux kill-session -t'
alias t='tmux'
alias wemux='TERM=screen-256color-bce wemux'
alias we='wemux'
alias wn="we new-session -s"
alias wa='we attach -d -t'
alias wk='we kill-session -t'
alias g='git'

#Bundler
alias be="bundle exec"
alias bl="bundle list"
alias bp="bundle package"
alias bo="bundle open"
alias bu="bundle update"
alias bi="bundle install"
alias bs="bundle show"

alias servers='tmux new-session -n:servers '\''teamocil servers'\'''
alias kill-servers='/Users/aweisberg/scripts/kill_servers.sh'
alias restart-servers="kill-servers && tmux kill-session -t servers && servers"

alias z='zeus'
alias vi="vim"
alias cddocs="cd /Users/aweisberg/Documents"

alias cdp="cd /Users/aweisberg/Documents/programs/"
alias cdtas="cd /Users/aweisberg/Documents/programs/tas"
alias cdmember="cd /Users/aweisberg/Documents/programs/member"
alias cdrte="cd /Users/aweisberg/Documents/programs/rte"
alias cdadmin="cd /Users/aweisberg/Documents/programs/admin"
alias cdcallcenter="cd /Users/aweisberg/Documents/programs/callcenter"
alias cdprovider="cd /Users/aweisberg/Documents/programs/provider"
alias cdclient="cd /Users/aweisberg/Documents/programs/client"
alias cdframework="cd /Users/aweisberg/Documents/programs/teladoc_framework"
alias cdapps="cd /Users/aweisberg/Documents/programs"
alias cdapi="cd /Users/aweisberg/Documents/programs/teladoc_api"
alias cdbook="cd /Users/aweisberg/Documents/programs/book_store"
alias cdrails="cd /Users/aweisberg/Documents/programs/rails"
alias cdoms="cd /Users/aweisberg/Documents/programs/oms"
alias cdconstants="cd /Users/aweisberg/Documents/programs/teladoc_constants_gem"

alias constants="cdconstants && vim"
alias oms="cdoms && vim"
alias book="cdbook && vim"
alias tas="cdtas && vim"
alias member="cdmember && vim"
alias rte="cdrte && vim"
alias admin="cdadmin && vim"
alias callcenter="cdcallcenter && vim"
alias provider="cdprovider && vim"
alias client="cdclient && vim"
alias framework="cdframework && vim"
alias api="cdapi && vim"
alias db="cp ../database.yml config/"

alias cdnode="/Users/aweisberg/Documents/node_apps"
alias copyconfig="less ~/.vimrc > /Users/aweisberg/Documents/config/.vimrc && less ~/.tmux.conf > /Users/aweisberg/Documents/config/.tmux.conf && less ~/.zshrc > /Users/aweisberg/Documents/config/.zshrc"

alias memcache="/usr/local/bin/memcached"
alias my_env="ssh aweisberg.dev.teladoc.com"
alias prod="ssh prodmirror.dev.teladoc.com"
alias prod2="ssh prodmirror2.dev.teladoc.com"

#DISABLE_AUTO_TITLE=true

alias rfind='find . -name "*.rb" | xargs grep -n'

function dep() {
  default_branch=`current_branch`
  default_app=${PWD##*/}
  ssh -t deploy1.dev.teladoc.com "cd /opt/release && DEPLOYMENT_TARGET=${2:-$default_app} DEPLOYMENT_BRANCH=${3:-$default_branch} cap ${1} deploy; exit; bash"
}

function r() {
  ssh -t $1.dev.teladoc.com "cd /telapp/tas/current/ && sudo -u teldev bash && /opt/ruby/bin/bundle exec rails c production"
}

function rprod() {
  ssh -t prod1.us1.teladoc.com "cd /telapp/tas/current/ && sudo -u telprod bash"
}

function tbu() {
  bundle update rte && bundle update teladoc_constants_gem
}

function cbu() {
  bundle update teladoc_constants_gem && bundle update teladoc_framework
}

function bde(){
  cdtas && bundle install && tbu
  cdadmin && bundle install && cbu
  cdprovider && bundle install && cbu
  cdmember && bundle install && cbu
  cdcallcenter && bundle install && cbu
}
function pry() {
if [ -e .zeus.sock ]; then
  zeus console
else
  command pry $@
fi
}

function rake() {
if [ -e .zeus.sock ]; then
  zeus rake $@
elif [ -e bin/rake ]; then
  bin/rake $@
else
  command rake $@
fi
}
# Path to your oh-my-zsh installation.
 export ZSH=$HOME/.oh-my-zsh

 # Set name of the theme to load.
 # Look in ~/.oh-my-zsh/themes/
 # Optionally, if you set this to "random", it'll load a random theme each
 # time that oh-my-zsh is loaded.
 # philips
 ZSH_THEME="robbyrussell"

#function zle-line-init zle-keymap-select {
   #VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
       #RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_custom_status) $EPS1"
           #zle reset-prompt
         #}

         #zle -N zle-line-init
         #zle -N zle-keymap-select
         #export KEYTIMEOUT=1
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
 plugins=(ruby brew git zsh-syntax-highlighting)

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

# vim keybindings
 bindkey -v
 bindkey '^P' up-history
 bindkey '^N' down-history
 bindkey '^?' backward-delete-char
 bindkey '^h' backward-delete-char
 bindkey '^w' backward-kill-word
 bindkey '^r' history-incremental-search-backward
