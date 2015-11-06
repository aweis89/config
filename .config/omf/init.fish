source $HOME/.config/git-aliased.fish
set -gx OMF_PATH /Users/aweisberg/.local/share/omf
# Spotify TODO move to plugin directory
alias sp '~/Downloads/shpotify-master/spotify'
alias d 'z'

# SSH shortcuts
alias qa 'ssh lkqa030'
alias st 'ssh lkst030'

# CD aliases
alias cdapp 'cd /Users/aweisberg/Sites/apps'
alias cdgem 'cd /Users/aweisberg/Sites/gems'

# Git
alias g 'git'
alias git 'hub'
alias gce 'git add --all; git commit -v'
alias ga 'git add'
alias gc 'git commit -v'

#Bundler
alias be "bundle exec"
alias bl "bundle list"
alias bp "bundle package"
alias bo "bundle open"
alias bu "bundle update"
alias bi "bundle install"
alias bs "bundle show"
alias specs "bundle exec rspec -f d"

# Tmux 
alias n 'tmux new-session -s'
alias s 'tmux switch -t'
alias a 'tmux attach -d -t'
alias k 'tmux kill-session -t'
alias t 'tmux'
alias wemux 'TERM screen-256color-bce wemux'

# Neovim editor
alias vim "nvim"
alias v 'nvim'
export NVIM_TUI_ENABLE_TRUE_COLOR 1
export EDITOR vim

# Settings files
alias tmuxs "vim ~/.tmux.conf"
alias zshs "vim ~/.zshrc"
alias vims "vim ~/.vimrc"
alias nvims "vim ~/.nvim/nvimrc"

alias memcache "/usr/local/bin/memcached"

alias rfind 'find . -name "*.rb" | xargs grep -n'


# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
source $HOME/.config/fzf.fish
