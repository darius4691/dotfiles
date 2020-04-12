#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CACHE_HOME=${HOME}/.cache
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh
export WEECHAT_HOME=${HOME}/.config/weechat

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi


export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'
export ZPLUG_HOME=${XDG_DATA_HOME}/zplug
export LC_ALL=en_US.UTF-8 

export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export CONDARC="$XDG_CONFIG_HOME"/conda
