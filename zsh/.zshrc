# shell opts
setopt autocd
setopt completealiases
setopt histignorealldups
setopt histfindnodups
setopt incappendhistory
setopt sharehistory

if [[ $OSTYPE == *darwin* ]]; then
  export PATH="${HOME}/perl5/bin${PATH:+:${PATH}}"
  export PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
  export PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
  export PERL_MB_OPT="--install_base ${HOME}/perl5"
  export PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"
fi

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

#zplug
if [ ! -d ${ZPLUG_HOME} ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

while [ ! -f ${ZPLUG_HOME}/init.zsh ]; do
  sleep 1
done

source ${ZPLUG_HOME}/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'MichaelAquilina/zsh-you-should-use' # prompt you should use for alias 
zplug 'ael-code/zsh-colored-man-pages'
zplug 'zsh-users/zsh-completions'
# zplug 'mafredri/zsh-async'
zplug 'denysdovhan/spaceship-prompt', use:spaceship.zsh, from:github, as:theme
zplug "zsh-users/zsh-autosuggestions", use:"zsh-autosuggestions.zsh"
zplug "chubin/cheat.sh", use:"share/cht.sh.txt", as:command, rename-to:cht
zplug "$ZDOTDIR/Pinyin-Completion", from:local, use:"shell/pinyin-comp.zsh"
zplug "$ZDOTDIR/Pinyin-Completion", from:local, use:"pinyin-comp", as:command
# zplug 'makeitjoe/incr.zsh'
# bat
if [[ $OSTYPE == *darwin* ]]; then
    zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*darwin*amd64*", if:"[[ $OSTYPE == *darwin* ]]"
    zplug 'vasyharan/zsh-brew-services', if:"[[ $OSTYPE == *darwin* ]]"
else
    zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*linux*amd64*", if:"[[ $OSTYPE == *linux* ]]"
fi
    


# FZF
zplug "junegunn/fzf", use:"bin/fzf-tmux", defer:2, dir:$XDG_DATA_HOME/fzf, as:command
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2, dir:$XDG_DATA_HOME/fzf

zplug 'zdharma/fast-syntax-highlighting', defer:1 #Switch themes via fast-theme {theme-name}.

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Then, source plugins and add commands to $PATH
zplug load

typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan,underline"

# ALIAS
alias top="htop"
alias du="ncdu"
alias vi="nvim"
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
alias fzf="fzf --preview 'bat --style=numbers --color=always {} | head -500'"

alias la='ls -A'
alias ll='ls -lA'
if [[ $OSTYPE == *darwin* ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

# smart case auto completion
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

# FUNCTIONS
weather(){
  curl wttr.in/$1
}


# source ${ZDOTDIR}/.iterm2_shell_integration.zsh


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/darius/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/darius/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/darius/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/darius/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

