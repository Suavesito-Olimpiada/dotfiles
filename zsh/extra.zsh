#
#  _______  _______ ____      _      _________  _   _
# | ____\ \/ /_   _|  _ \    / \    |__  / ___|| | | |
# |  _|  \  /  | | | |_) |  / _ \     / /\___ \| |_| |
# | |___ /  \  | | |  _ <  / ___ \   / /_ ___) |  _  |
# |_____/_/\_\ |_| |_| \_\/_/   \_\ /____|____/|_| |_|
#
#
# This are some extra lines that I DON'T want them to be
# in my zshrc, so i create this file and call it from
# zshrc. Cheers!!!


# Charge my aliases file
source /home/jose/.zsh/aliases.zsh

# Zplug call cascade
source /home/jose/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

zplug "hlissner/zsh-autopair", defer:2

zplug "bcho/Watson.zsh"

zplug "ryutok/rust-zsh-completions"

zplug "MichaelAquilina/zsh-auto-notify"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

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

source /usr/share/doc/pkgfile/command-not-found.zsh



#   ____ ___  _   _ _____ ___ ____
#  / ___/ _ \| \ | |  ___|_ _/ ___|
# | |  | | | |  \| | |_   | | |  _
# | |__| |_| | |\  |  _|  | | |_| |
#  \____\___/|_| \_|_|   |___\____|
#
# Configurations for all the packages installed
# and loaded before.

# A nive reminder that I'm not free. :'c
echo $(vrms -g |& head -2 | tail -1 | sed 's/N\(.*\): \([0-9]*\)/You have \2 n\1 in your system./')
