set -g Z_SCRIPT_PATH=$HOME/z/z.sh
. $HOME/.config/z-fish/z.fish
# Path to Oh My Fish install.
set -gx OMF_PATH /Users/aweisberg/.local/share/omf

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG /Users/aweisberg/.config/omf

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

alias fch $HOME/plugins/crh

