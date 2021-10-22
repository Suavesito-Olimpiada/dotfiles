#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias :q='exit'
alias hw='startx /bin/herbstluftwm'
PS1='\[\e[1;91m\][\u@\h \w]\$\[\e[0m\] '

function volume_control ()
{
    SOUND=`pactl list sinks | grep "Monitor Source" | sed 's/\([^a-zA-Z]Monitor Source: \)\(.*\)\(.monitor\)/\2/'`
    pactl set-sink-volume $SOUND $@
}
alias volume=volume_control

export VISUAL="/bin/vim"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/usr/local/bin:$PATH"
export GOPATH=$HOME/Apps/gopath
export PATH=$GOPATH:$GOPATH/bin:$PATH

export MANPAGER="less -R"
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
