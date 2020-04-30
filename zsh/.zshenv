# ______  _______  ______ _____ _     _ _______
# |     \ |_____| |_____/   |   |     | |______
# |_____/ |     | |    \_ __|__ |_____| ______|
#                                              
# Defines environment variables.
# Ensure that a non-login, non-interactive shell has a defined environment.
# should contain commands to set the command search path, plus other important environment variables.
# should not contain commands that produce output or assume the shell is attached to a tty.


################################################################################
#                                    locale                                    #
################################################################################

export LC_ALL=en_US.UTF-8 

################################################################################
#                                xgd based dir                                 #
################################################################################

export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CACHE_HOME=${HOME}/.cache

################################################################################
#                     redirect softwares to xdg based dir                      #
################################################################################

export ZDOTDIR=${XDG_CONFIG_HOME}/zsh              # zshell
export ZPLUG_HOME=${XDG_DATA_HOME}/zplug           # zplug
export WEECHAT_HOME=${HOME}/.config/weechat        # XDG FOR APPLICATIONS
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass    # pass: A standard password manager
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android # adb
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker     # docker ~/.docker ~/.docker/machine
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
export CONDARC=$XDG_CONFIG_HOME/conda/condarc      # conda .condarc
# ipython .ipython jupyter .jupyter
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

################################################################################
#                         setting default application                          #
################################################################################

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

################################################################################
#                             application settings                             #
################################################################################

export FPP_EDITOR='nvim'   # fpp, the Facebook PathPicker
export ZPLUG_BIN=$HOME/bin # zplug binary dir

