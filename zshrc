#
#  _________  _   _   ____   ____
# |__  / ___|| | | | |  _ \ / ___|
#   / /\___ \| |_| | | |_) | |
#  / /_ ___) |  _  | |  _ <| |___
# /____|____/|_| |_| |_| \_\\____|
#
# This is my zshrc, it's a little kind of mess, but
# I'm improving it with the time.
# I tried like four time OMZ but it never likes me.
# So I went to zplug to discover what else it have
# to give to my zsh experience.
# I'll figured it out. :)
#

# function zle-line-init zle-keymap-select # VI mode indicator in prompt
# {
#     RPS1="${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT} %T"
#     RPS2=$RPS1
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

# Bindkeys

bindkey -v #VI like keys

bindkey "^?" backward-delete-char   # Backspace work normally
bindkey "^h" backward-delete-char   # Backspace work normally

bindkey "^[[P" delete-char          # Delete work normally

bindkey "^w" backward-delete-word   # Delte word

# History Substring Search

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
#
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -M vicmd 'ZZ' exit

# SetOpts

zstyle :compinstall filename '/home/jose/.zshrc' # Completion

setopt COMPLETE_IN_WORD

setopt histignorealldups # If a new command is a duplicate, remove the older one

autoload -Uz compinit colors
compinit -C
colors

setopt AUTO_LIST # List completion automatically

setopt HIST_IGNORE_ALL_DUPS

setopt pushd_ignore_dups

setopt append_history

setopt autocd

setopt nomatch

setopt interactivecomments # Comment interatively

unsetopt LIST_AMBIGUOUS # List ambiguos commands

# Style

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Completion case-insensitive (all)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true # automatically find new executables in path

zstyle ':completion:*' menu select # Complete with selection in menu

# Exports

KEYTIMEOUT=1 # Get rid of mode switching time gaps

#RPROMPT actually needed otherwise it does not display mode or time, even though this is actually done above

PROMPT="%~>"
RPROMPT="%T"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# All the non-standard configuration is called here.
source /home/jose/.zsh/extra.zsh
