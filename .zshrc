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
alias gce='git add --all && git commit -v'

alias apps='/Users/aweisberg/Sites/apps'
alias gems='/Users/aweisberg/Sites/gems'
alias cdapp='/Users/aweisberg/Sites/apps'
alias cdgem='/Users/aweisberg/Sites/gems'
#Bundler
alias be="bundle exec"
alias bl="bundle list"
alias bp="bundle package"
alias bo="bundle open"
alias bu="bundle update"
alias bi="bundle install"
alias bs="bundle show"
alias specs="bundle exec rspec spec"

alias servers='tmux new-session -n:servers '\''teamocil servers'\'''
alias kill-servers='/Users/aweisberg/scripts/kill_servers.sh'
alias rs="kill-servers && tmux kill-session -t servers && servers"
alias wservers='wemux new-session -n:servers '\''teamocil servers'\'''

alias z='zeus'
alias vi="vim"
alias cddocs="cd /Users/aweisberg/Documents"

alias cdnode="/Users/aweisberg/Documents/node_apps"
alias copyconfig="less ~/.vimrc > /Users/aweisberg/Documents/config/.vimrc && less ~/.tmux.conf > /Users/aweisberg/Documents/config/.tmux.conf && less ~/.zshrc > /Users/aweisberg/Documents/config/.zshrc"

alias memcache="/usr/local/bin/memcached"

#DISABLE_AUTO_TITLE=true

alias rfind='find . -name "*.rb" | xargs grep -n'
#Default editor
export EDITOR=vim
export ZDOTDIR=$HOME

#FZF

# Copy the original fzf function to __fzf
#declare -f __fzf > /dev/null || eval "$(echo "__fzf() {"; declare -f fzf | \grep -v '^{' | tail -n +2)"

# Use git ls-tree when possible
#fzf() {
  #if [ -n "$(git rev-parse HEAD 2> /dev/null)" ]; then
    #FZF_DEFAULT_COMMAND="git ls-tree -r --name-only HEAD" command fzf "$@"
  #else
    #command fzf "$@"
  #fi
#}

#open file in vim
fv() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# Equivalent to above, but opens it with `open` command
fo() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && open "$file"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
    -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
# cdf - cd into the directory of the selected file
#cdf() {
  #local file
  #local dir
  #file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
#}
# fbr - checkout git branch
 fgc() {
   local branches branch
   branches=$(git branch) &&
     branch=$(echo "$branches" | fzf +s +m) &&
     git checkout $(echo "$branch" | sed "s/.* //")
 }

export FUZZY_SEARCH_PATHS="~/Projects:~/XCode:~/Sites/apps:~/Sites/gems"

cdf() {
local dir=$(cat << EOS | ruby | fzf -e -1 --query=$1
  (ENV["FUZZY_SEARCH_PATHS"]||"").split(":").each{|p| puts Dir["#{File.expand_path(p)}/*"]}
EOS)
cd "$dir"
}

fgrep() {
  grep --line-buffered --color=never -r "" * | fzf
}

# This is a helper function that splits the current pane to start the given
# command ($1) and sends its output back to the original pane with any number of
# optional keys (shift; $*).
fzf_tmux_helper() {
  [ -n "$TMUX_PANE" ] || return
  local cmd=$1
  shift
  tmux split-window -p 50 \
    "bash -c \"\$(tmux send-keys -t $TMUX_PANE \"\$(source ~/.fzf.bash; $cmd)\" $*)\"| vim"
}

testing(){
   local var="$(fzf_tmux_dir) works"
   echo $var
}
# This is the function we are going to run in the split pane.
# - "find" to list the directories
# - "sed" will escape spaces in the paths.
# - "paste" will join the selected paths into a single line
fzf_tmux_dir() {
  fzf_tmux_helper \
    'find * -path "*/\.*" -prune -o -type d -print 2> /dev/null |
     fzf --multi |
     sed "s/ /\\\\ /g" |
     paste -sd" " -' Space
}

# Bind CTRL-X-CTRL-D to fzf_tmux_dir
#bind '"\C-x\C-d": "$(fzf_tmux_dir)\e\C-e"'

function gen_ctags () {
 ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths) 
}

function apps_run () {
cd ~/Sites/apps/
for app in ./*
do
  cd $app || echo "cannot cd into: ${app}"
  echo "executing $@ in $app ..." && eval "$@" || echo "cannot execute: $1 in $app"
  cd ~/Sites/apps/
done
}

for dir in ~/Sites/*
do
  if [[ ${dir##*/} =~ 'apps|gems' ]]; then
    for app in ~/Sites/${dir##*/}/*
    do
      eval "cd${app##*/} () { cd $app }" 
      eval "v${app##*/} () { cd $app && vim }" 
      eval "${app##*/} () { cd $app && vim }" 
    done
  fi
done

#function dir_exec () {
#cd $1
#for path in ./*
#do
  #cd $path || echo "cannot cd into: ${path}"
  #echo "executing $2 in $path ..." && eval "$2" || echo "cannot execute: $2 in $path"
  #cd .. || echo "cannot cd back from $path"
#done
#}

function gems_run () {
  cd ~/Sites/gems
  for gem  in ~/Sites/gems/*
  do 
    cd $gem 
    eval "$1" || "cannot execute: ${1} for ${gem}"
    cd ~/Sites/gems
  done
}

function all_run () {
apps_run $1
gems_run $1
}


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
elif [ -e bin/pry ]; then
  bin/pry $@
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

for bun_command in rake rspec 
do

  read -d '' func << EOM
  ${bun_command} () {
  if [ -e bin/${bun_command} ]; then
    bin/${bun_command} ${@} 
  else
    command ${bun_command} ${@}
  fi
  }
EOM

eval "$func"

done

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
 plugins=(ruby brew git zsh-syntax-highlighting web-search)

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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
bash -e ~/Sites/configs/env/.bash_fynanz
source ~/.powconfig
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export JAVA_HOME=$(/usr/libexec/java_home)
export JDK_HOME=$(/usr/libexec/java_home)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
