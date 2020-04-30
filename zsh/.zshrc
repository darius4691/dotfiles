# ______  _______  ______ _____ _     _ _______
# |     \ |_____| |_____/   |   |     | |______
# |_____/ |     | |    \_ __|__ |_____| ______|
#                                              
# sourced in interactive shells
# should contain commands to set up aliases, functions, options, key bindings, etc.


################################################################################
#                           zshell internal settings                           #
################################################################################

# zshell options
setopt autocd            # type the name of a directory, and it will become the current
setopt completealiases   # complete alises
setopt histignorealldups # history ignore all duplications
setopt histfindnodups    # do not display duplicates of a line
setopt sharehistory      # imports from history, and appended to the history

# command check
check_commands(){
    local required_command=(
    git
    ag
    bat
    )
    local i
    for i in "${required_command[@]}"; do
        if ! [ -x "$(command -v $i)" ]; then
            echo "$i is not installed." 
        fi
    done
}
check_commands
unfunction check_commands


################################################################################
#                                    zplug                                     #
################################################################################

# zplug automatic installation scripts
if [ ! -d ${ZPLUG_HOME} ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

while [ ! -f ${ZPLUG_HOME}/init.zsh ]; do
  sleep 1
done

# zplug plugins
source ${ZPLUG_HOME}/init.zsh
# system specific packages
if [[ $OSTYPE == *darwin* ]]; then
    zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*darwin*amd64*"
    zplug 'vasyharan/zsh-brew-services'
else
    zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*linux*amd64*"
fi
zplug 'zplug/zplug', hook-build:'zplug --self-manage' # zplug itself
zplug 'MichaelAquilina/zsh-you-should-use'            # prompt you should use for alias
zplug 'ael-code/zsh-colored-man-pages'                # colored man pages
zplug 'zsh-users/zsh-completions'                     # Additional completion definitions
zplug 'denysdovhan/spaceship-prompt', use:spaceship.zsh, from:github, as:theme, hook-load:"export SPACESHIP_VI_MODE_SHOW=false"
# Fish-like fast/unobtrusive autosuggestions for zsh.
zplug "zsh-users/zsh-autosuggestions", use:"zsh-autosuggestions.zsh"
zplug "chubin/cheat.sh", use:"share/cht.sh.txt", as:command, rename-to:cht
zplug "$ZDOTDIR/Pinyin-Completion", from:local, use:"shell/pinyin-comp.zsh"
zplug "$ZDOTDIR/Pinyin-Completion", from:local, use:"pinyin-comp", as:command
zplug "junegunn/fzf", use:"bin/fzf-tmux", defer:2, dir:$XDG_DATA_HOME/fzf, as:command
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2, dir:$XDG_DATA_HOME/fzf
zplug 'zdharma/fast-syntax-highlighting', defer:1  

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Then, source plugins and add commands to $PATH
zplug load


################################################################################
#                               plugin settings                                #
################################################################################

typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan,underline"

################################################################################
#                                   aliases                                    #
################################################################################
alias top="htop"
alias du="ncdu"
alias vi="nvim"
# alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias fzf="fzf --preview 'bat --style=numbers --color=always {} | head -500'"
alias box="boxes -d shell -a hcvcjc -s 80"
alias la='ls -A'
alias ll='ls -lA'
if [[ $OSTYPE == *darwin* ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
# FUNCTIONS
weather(){
  curl wttr.in/$1
}


################################################################################
#                          zshell completion settings                          #
################################################################################

# smart case auto completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'


################################################################################
#                                  additional                                  #
################################################################################

# compatibility for conda, etc
if [ -f $HOME/.zshrc ]; then
    source $HOME/.zshrc
fi


