# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cloud"

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
# COMPLETION_WAITING_DOTS="true"

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

export PATH="/Users/aweisberg/.nvm/v0.10.28/bin:/usr/local/bin:/usr/local/bin:/Users/aweisberg/.rvm/gems/ruby-1.9.3-p545/bin:/Users/aweisberg/.rvm/gems/ruby-1.9.3-p545@global/bin:/Users/aweisberg/.rvm/rubies/ruby-1.9.3-p545/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/aweisberg/bin:/Users/aweisberg/.rvm/bin"
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
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias cdtas="cd /Users/aweisberg/Documents/rails_apps/tas"
alias cdmember="cd /Users/aweisberg/Documents/rails_apps/member"
alias cdrte="cd /Users/aweisberg/Documents/rails_apps/rte"
alias cdadmin="cd /Users/aweisberg/Documents/rails_apps/admin"
alias cdcallcenter="cd /Users/aweisberg/Documents/rails_apps/callcenter"
alias cdprovider="cd /Users/aweisberg/Documents/rails_apps/provider"
alias cdclient="cd /Users/aweisberg/Documents/rails_apps/client"
alias cdframework="cd /Users/aweisberg/Documents/rails_apps/teladoc_framework"
alias cdapps="cd /Users/aweisberg/Documents/rails_apps"

alias tas="subl /Users/aweisberg/Documents/rails_apps/tas"
alias member="subl /Users/aweisberg/Documents/rails_apps/member"
alias rte="subl /Users/aweisberg/Documents/rails_apps/rte"
alias admin="subl /Users/aweisberg/Documents/rails_apps/admin"
alias callcenter="subl /Users/aweisberg/Documents/rails_apps/callcenter"
alias provider="subl /Users/aweisberg/Documents/rails_apps/provider"
alias client="subl /Users/aweisberg/Documents/rails_apps/client"
alias framework="subl /Users/aweisberg/Documents/rails_apps/teladoc_framework"
alias tapps="subl /Users/aweisberg/Documents/rails_apps"
alias api="subl /Users/aweisberg/Documents/rails_apps/teladoc_api"


alias vtas="vim /Users/aweisberg/Documents/rails_apps/tas" alias member="subl /Users/aweisberg/Documents/rails_apps/member"
alias vrte="vim /Users/aweisberg/Documents/rails_apps/rte"
alias vadmin="vim /Users/aweisberg/Documents/rails_apps/admin"
alias vcallcenter="vim /Users/aweisberg/Documents/rails_apps/callcenter"
alias vprovider="vim /Users/aweisberg/Documents/rails_apps/provider"
alias vclient="vim /Users/aweisberg/Documents/rails_apps/client"
alias vframework="vim /Users/aweisberg/Documents/rails_apps/teladoc_framework"
alias vtapps="vim /Users/aweisberg/Documents/rails_apps"
alias vapi="vim /Users/aweisberg/Documents/rails_apps/teladoc_api"

# alias servers="cdtas ; rails s -p3030 ; cdmember ; rails s ; cdprovider ; rails s -p3010"

alias s="screen -r"

# alias servers="cdtas ; rails s -p3030 ; cdmember ; rails s ; cdprovider ; rails s -p3010"

alias s="screen -r"

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/bin:$PATH

[ -s "/Users/aweisberg/.nvm/nvm.sh" ] && . "/Users/aweisberg/.nvm/nvm.sh" # This loads nvm
