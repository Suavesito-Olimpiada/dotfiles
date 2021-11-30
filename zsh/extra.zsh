#
#  _______  _______ ____      _      _________  _   _
# | ____\ \/ /_   _|  _ \    / \    |__  / ___|| | | |
# |  _|  \  /  | | | |_) |  / _ \     / /\___ \| |_| |
# | |___ /  \  | | |  _ <  / ___ \   / /_ ___) |  _  |
# |_____/_/\_\ |_| |_| \_\/_/   \_\ /____|____/|_| |_|
#
#
# This are some extra lines that I DON'T want them to be
# in my zshrc, so I create this file and call it from
# zshrc. Cheers!!!


# Charge my aliases file
source $HOME/.zsh/aliases.zsh

# Zplug call cascade
source $HOME/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
# zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

if [[ -n $DISPLAY ]]
then
    zplug "hlissner/zsh-autopair", defer:2

    # zplug "RobSis/zsh-completion-generator"

    # zplug "plugins/fd", from:oh-my-zsh
    zplug "plugins/fzf", from:oh-my-zsh
    zplug "plugins/thefuck", from:oh-my-zsh
    zplug "plugins/safe-paste", from:oh-my-zsh
    # zplug "plugins/autojump", from:oh-my-zsh
fi

if [[ -n $DISPLAY ]] && [[ $TERM != 'st-256color' ]]
then
    zplug "romkatv/powerlevel10k", as:theme, depth:1

    # zplug "reobin/typewritten", as:theme

    # zplug "plugins/autoenv", from:oh-my-zsh
    zplug "plugins/command-not-found", from:oh-my-zsh
    # zplug "plugins/docker", from:oh-my-zsh
    # zplug "plugins/docker-compose", from:oh-my-zsh

    # zplug "chitoku-k/fzf-zsh-completions"

    # zplug 'wfxr/forgit'

    # zplug 'Tarrasch/zsh-bd'

    # zplug "ryutok/rust-zsh-completions"

    zplug "MichaelAquilina/zsh-auto-notify"

    zplug 'zplug/zplug', hook-build:'zplug --self-manage'
fi

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load


#  ____   ___  _   _ ____   ____ _____ ____
# / ___| / _ \| | | |  _ \ / ___| ____|  _ \
# \___ \| | | | | | | |_) | |   |  _| | | | |
#  ___) | |_| | |_| |  _ <| |___| |___| |_| |
# |____/ \___/ \___/|_| \_\\____|_____|____/
#
# Sourced plugins fom another packes that
# I cannot get running with zplug or it was
# simplier to get run externally.

if [[ -n $DISPLAY ]] && [[ $TERM != 'st-256color' ]]
then
    # source /usr/share/doc/pkgfile/command-not-found.zsh

    # Fuck nicesties
    eval $(thefuck --alias) # --enable-experimental-instant-mode)
fi

if [[ -n $DISPLAY ]]
then
    # For [marker](https://github.com/pindexis/marker)
    [[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

    # FZF nicesties (substituted by oh-my-zsh:fzf)
    # source /usr/share/fzf/completion.zsh
    # source /usr/share/fzf/key-bindings.zsh

    # AUTOJUPM nicesties (substituted by oh-my-zsh:autojump)
    # source /usr/share/autojump/autojump.zsh

    # ZOXIDE nicesties
    eval "$(zoxide init --cmd j --no-aliases zsh)"

    # LS_COLORS (for aur:lscolors-git) (substituted by vivid -check in .zshenv-)
    #source /usr/share/LS_COLORS/dircolors.sh

    # asdf-vm for language version control
    source /opt/asdf-vm/asdf.sh

    # Local plugins and scripts
    PLUGHOME=$HOME/.zsh/plugin
    # source $PLUGHOME/autojump.zsh
    source $PLUGHOME/zoxide.zsh
    source $PLUGHOME/man.zsh
    source $PLUGHOME/marker.zsh
    source $PLUGHOME/ripgrep.zsh
    source $PLUGHOME/music.zsh
    source $PLUGHOME/clean.zsh
fi


#   ____ ___  _   _ _____ ___ ____
#  / ___/ _ \| \ | |  ___|_ _/ ___|
# | |  | | | |  \| | |_   | | |  _
# | |__| |_| | |\  |  _|  | | |_| |
#  \____\___/|_| \_|_|   |___\____|
#
# Configurations for all the packages installed
# and loaded before.

# For termite to be able to use ctrl-shift-t to open a new terminal in
# the same directory I need to set 'manually' the working directory.

# I need to use xterm-256color, because I change the TERM env for termite
# to be able to use correctly ssh.
# if [[ $TERM == xterm-256color ]]; then
#     . /etc/profile.d/vte.sh
#     __vte_osc7
# fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -n $DISPLAY ]]
then
    source "$HOME/.zsh/p10k/p10k.zsh"
else
    source "$HOME/.zsh/p10k/p10k-nodisplay.zsh"
fi

# A nice reminder that I'm not free. :'c
[[ $TERM != "st-256color" ]] && \
vrms -g 2>&1 1>/dev/null | \
sed -nE '2s/.+: ([0-9]+)/You have \1 non-free packages in your system./p'
