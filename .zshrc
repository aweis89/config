#ulimit -n 2560
source $HOME/configs/lkenv.sh

#Go setup
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOPATH/bin
#Elixir setup
export PATH="$PATH:/path/to/elixir/bin"
export GIT_TEMPLATE_DIR=$HOME/.git-templates
export NVIM_TUI_ENABLE_TRUE_COLOR=1

#//use the following if you want to generate documentation for your package using godoc
#export GOROOT=`go env GOROOT`
#export PATH=$PATH:$GOROOT/bin
#Tmux
#z
. ~/z/z.sh
alias st='ssh lkst030'
#alias tmux="tmux -2"

alias sp='~/Downloads/shpotify-master/spotify'
alias qa='ssh lkqa030'
#alias tmux='TERM=screen-256color-bce tmux'
alias tmuxs="vim ~/.tmux.conf"
alias zshs="vim ~/.zshrc"
alias vims="vim ~/.vimrc"
alias nvims="vim ~/.nvim/nvimrc"
alias v='nvim'
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
alias git='hub'
alias gce='git add --all && git commit -v'
alias stmate='rm -f ~/tmp/tmate.sock && tmate -S ~/tmp/tmate.sock && tmate show-messages'
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
alias specs="bundle exec rspec -f d"

alias servers='tmux new-session -n:servers '\''teamocil servers'\'''
alias kill-servers='/Users/aweisberg/scripts/kill_servers.sh'
alias rs="kill-servers && tmux kill-session -t servers && servers"
alias wservers='wemux new-session -n:servers '\''teamocil servers'\'''

#alias z='zeus'
#alias vi="vim"
alias vim="nvim"

alias memcache="/usr/local/bin/memcached"
alias xml-post="curl -i -H \"Content-Type: text/xml\" -d @- -X POST"

#DISABLE_AUTO_TITLE=true

alias rfind='find . -name "*.rb" | xargs grep -n'
#Default editor
export EDITOR=vim
export ZDOTDIR=$HOME

job() {
  $1 &> /dev/null &
  echo "executing \`$1\` in background ..."
}
alias background="job"

post () {
  curl -i -H "Content-Type: application/${2:=json}" -d @- -X POST $1
}

get () {
  curl -i -H "Content-Type: application/${2:=json}" -X GET $1
}
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

tojsx () {
  for f in *.es6; do
    mv -- "$f" "${f%.es6}.jsx"
  done
}

api () {
  curl -i --user JBR:7dc77e80793d673ad32fe7876961387d -H "Accept: application/json" -H "Content-Type: application/json; charset=US-ASCII" --data $1 http://api.gh.dev/gh/v1/bulk_loans
}

zr() {
  rm ../../.zeus.sock
  rm .zeus.sock
  zeus start
}

unalias z
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | sed -n 's/^[ 0-9.,]*//p' | fzf)"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

fh() {
  eval $(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s | sed 's/ *[0-9]* *//')
}
#open file in vim
fv() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && vim "$file"
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
# fbr - checkout git branch
fgc() {
  local branches branch
  branches=$(git branch) &&
    branch=$(echo "$branches" | fzf +s +m) &&
    git checkout $(echo "$branch" | sed "s/.* //")
}
# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2
  ) && $EDITOR $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}

export FUZZY_SEARCH_PATHS="~/Projects:~/XCode:~/Sites/apps:~/Sites/gems"


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
#bindkey '<ctrl-d>' "$(fzf_tmux_dir)\e\C-e"

function tag () {
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
    done
  fi
done

function dir_exec () {
cd $1
for path in ./*
do
  cd $path || echo "cannot cd into: ${path}"
  echo "executing $2 in $path ..." && eval "$2" || echo "cannot execute: $2 in $path"
  cd .. || echo "cannot cd back from $path"
done
}

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

function gem_vars () {
  cd ~/Sites/gems
  for gem in ~/Sites/gems/*
  do 
    cd $gem 
    gem=$(basename $gem)
    eval "export ${gem:u}_DIR=~/Sites/gems/${gem}"
  done
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
 # time that oh-my-zsh is loaded.
 # philips
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
 bindkey -M viins 'jj' vi-cmd-mode
 bindkey -M viins 'kk' clear-screen
 # Move to where the arguments belong.
 up-case-prev-word() {
   zle vi-backward-word
   zle up-case-word
 }
 zle -N up-case-prev-word
 bindkey "^u" up-case-prev-word
#bash -e ~/Sites/configs/env/.bash_fynanz
#source ~/.powconfig
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export JAVA_HOME=$(/usr/libexec/java_home)
export JDK_HOME=$(/usr/libexec/java_home)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Pipe output of previous command
alias _='fc -e - |'
