# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
alias ls='eza --group-directories-first --sort=extension'
alias ll='eza -l --group-directories-first --sort=extension'

# PATH additions
source $HOME/.local/bin/env
export PATH="$HOME/go/bin:$PATH"

# Load SSH key into agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" >/dev/null
fi
ssh-add ~/.ssh/github 2>/dev/null
