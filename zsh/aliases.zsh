#
#  _________  _   _      _    _ _
# |__  / ___|| | | |    / \  | (_) __ _ ___  ___  ___
#   / /\___ \| |_| |   / _ \ | | |/ _` / __|/ _ \/ __|
#  / /_ ___) |  _  |  / ___ \| | | (_| \__ \  __/\__ \
# /____|____/|_| |_| /_/   \_\_|_|\__,_|___/\___||___/
#
# Here are my aliases for the runtime

# SYSTEM ALIASES
# alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
# alias l1='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -1'
# alias l='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -CF'
# alias ll='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -alhF'
# alias la='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -A'

alias grep='grep --color=tty -d skip'
# alias grep='rg'
alias locate='locate -r'
alias wget='wget -c --read-timeout=20'

alias cp='cp -i'
alias mv='mv -i'

alias wipe='wipe -l2 -x2 -p1'

alias cat='bat' # This is batman
#alias cat='lolcat' # This is lol

alias ls='lsd'
alias l1='lsd -1'
alias l='lsd'
alias ll='lsd -alh'
alias la='lsd -A'

alias ltree='lsd -L --tree'

# alias xargs='xargs -or' # `-r` means run nothing on empty input
                        # `-o` menas open tty again (for programs with input -vim-)

alias yay='yay --editmenu --cleanmenu --noredownload --editor=vim --color always'

alias info='info --vi-keys'

alias dropcatch='echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias swapswap='sudo swapoff -a && sudo swapon -a'


# X SYSTEM SECTION
alias hw='startx /bin/herbstluftwm --locked'


# UPDATE SECTION
#
# This are some short ways to update all
# the things that I have that can be updated
# tha «pacmanup» is just for arch-like 
# GNU/Linux distributions.

# alias pipup="pip3 freeze --user --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install --user -U"
# alias pip2up="pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip2 install -U"

# alias gemup="gem update"
# alias stackup="stack update && stack upgrade"
# alias Rup="sudo R -e 'old.packages (repos = \"https://cran.itam.mx\"); update.packages (ask = FALSE, repos = \"https://cran.itam.mx\")'"
# alias juliaup="julia -e 'import Pkg; Pkg.update(); Pkg.build()'"
# alias npmup="npm i -g npm"

alias flatup="flatpak update"
alias snapup="sudo snap refresh"

alias pacmanup="yay -Syyuu && sudo mandb && sudo pkgfile --update"
alias pacmanclean='sudo pacman -Rns $(pacman -Qtdq)'
alias paccacheclean='sudo paccache -rvk3'
alias sysclean='pacmanclean; paccacheclean'


# MOUNTING SECTION
#
# This are very specific and probably will change
# with the time.

alias mountWindows='pmount /dev/sda9 /media/win'
alias umntWindows='pumount /media/win'


# SPECIAL APPS SECTION
#
# Some spetial functions that I aliased for my own
# purpose.

function less_highlight_f()
{
    if [[ $@ = "" ]]
    then
        less
    else
        if [[ ${1: -4} = ".pdf" ]]
        then
            pdftotext $@ - | less
        else
            echo $@
            echo
            ~/.config/less-highlight/less-highlight.sh $@ | less -R
        fi
    fi
}
alias lessc=less_highlight_f

alias volume=volume.sh

function _man() # Give colors to man
{
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
alias man=_man

function _ssh_tmux ()
{
    SESSION=''
    ARGS=''
    while [[ $# -gt 0 ]]
    do
        if [[ $1 !=  '--session' ]]
        then
            ARGS="$ARGS $1"
        else
            SESSION=$2
            shift
        fi
        shift
    done
    /usr/bin/ssh -t ${=ARGS} "tmux -2 attach-session -t ssh_tmux$SESSION || tmux -2 new-session -s ssh_tmux$SESSION";
}
alias sst=_ssh_tmux


# UTILITY SECTION
#
# Here I have some things that make the life
# easier in some ways. This are not systems,
# neither system needed things to do, or
# aliased functions, just aliases that are useful.

# alias lg="lazygit" # Lazygit git utility
alias git="hub" # Use hub intead of git
alias github="gh"
alias neofetch="neofetch --cpu_temp C --refresh_rate on --memory_percent on"
alias screenfetch="neofetch --cpu_temp C --refresh_rate on --memory_percent on"
alias dragon="dragon-drop"
alias fzf-preview="fzf --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
alias f="fuck"
alias @benchmark="hyperfine"
alias myip="curl http://ipecho.net/plain; echo"

# tmux specifics

alias tmux="tmux -2 -u"
alias tnew="tmux new-session -s"
alias tlss="tmux list-sessions"
alias tatt="tmux attach-session -t"
alias tsrc="tmux source-file ~/.tmux.conf"
