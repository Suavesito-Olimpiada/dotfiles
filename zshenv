#
#  _________  _   _   _____ _   ___     __
# |__  / ___|| | | | | ____| \ | \ \   / /
#   / /\___ \| |_| | |  _| |  \| |\ \ / /
#  / /_ ___) |  _  | | |___| |\  | \ V /
# /____|____/|_| |_| |_____|_| \_|  \_/
#
# Here are my enviroment variables

# Some nice things for zsh
# DEFAULT_USER='jose'

# A level of inception indicator if ZSH is from inside ZSH
if [[ -z "$INCEPTION" ]]
then
    export INCEPTION=0
else
    export INCEPTION="$((INCEPTION + 1))"
fi

# Ignoring spaced commands... for tomb
export HISTIGNORESPACE=1

#export MANPAGER="less -R"
#export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"
export MANPAGER="sh -c 'col -bx | bat -l man -p --pager \"less -R\"'"

export VISUAL="/usr/bin/vim"
export EDITOR="/usr/bin/vim"
export BROWSER="firefox"

# As I use termite for some things, to be able to use it with ssh
# I need to change the term enviroment variable.
if [[ $TERM == xterm-termite ]]; then
    export TERM="xterm-256color"
fi

# To use with [zsh-completion-generator](https://github.com/RobSis/zsh-completion-generator)
export GENCOMPL_FPATH=$HOME/.zsh/completion

# Auto-Notify threshold for zsh-auto-notify
export AUTO_NOTIFY_THRESHOLD=30
export AUTO_NOTIFY_TITLE="Hey! %command has just finished"
export AUTO_NOTIFY_BODY="It completed in %elapsed seconds with exit code %exit_code"
AUTO_NOTIFY_IGNORE+=("docker" "man" "sleep" "ssh" "tmux" "yaourt" "julia" "bpython" "R" "mosh" "sh" "bash")

# typewritten options
# TYPEWRITTEN_PROMPT_LAYOUT="singleline"

# Marker key for get options, no more C-@ (ctrl-space)
export MARKER_KEY_GET=
export MARKER_KEY_NEXT_PLACEHOLDER=

# Marker+fzf configuration
export FZF_MARKER_MAIN_KEY=
export FZF_MARKER_PLACEHOLDER_KEY=

# MOSH escape key
export MOSH_ESCAPE_KEY=

# FZF options
export FZF_DEFAULT_OPTS="
--layout=reverse
--border
--ansi
--color dark
--prompt='~ '
--pointer='▶'
--marker='✗'
--multi
--bind 'ctrl-y:execute-silent(echo {+} | xclip -i)'"
export FZF_DEFAULT_COMMAND="fd \
--follow \
--color=always \
--exclude 'node_modules' \
--exclude 'tags' \
--exclude 'GPATH' \
--exclude 'GTAGS' \
--exclude 'GRTAGS'"
# --exclude '.git' \
# --hidden \
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS"
export FZF_ALT_C_COMMAND="fd \
--type d \
--follow \
--color=always \
--exclude 'node_modules'"

# Emoji-cli for Emojify
EMOJI_CLI_KEYBIND=

# LS_COLORS from vivid
export LS_COLORS=$(vivid generate solarized-dark)

#export LC_ALL="es_MX.UTF-8"

# Keys that the people shouldn't have (except for me)
source $HOME/.zsh/secrets.zsh

# For downgrade package [ALA Manjaro](https://wiki.manjaro.org/index.php?title=Downgrading_packages)
export DOWNGRADE_FROM_ALA="1"

# Julia threads to nproc
export JULIA_NUM_THREADS=$(nproc)

# Path and home variables
export ZPLUG_HOME=$HOME/.zsh/plugin/zplug

export LOC_APPS=$HOME/Apps
export PATH="$LOC_APPS/bin:$PATH"
export PATH="/var/lib/snapd/snap/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/usr/local/bin:$PATH"
export PATH="$(du $HOME/.config/scripts/ | grep -iv 'project' | cut -f2 | tr '\n' ':')$PATH"

export GOPATH=$HOME/Apps/pkg/go
export PATH="$GOPATH/bin:$PATH"

export CARGO_HOME=$HOME/Apps/pkg/rust
export PATH="$CARGO_HOME/bin:$PATH"

export CABALDIR=$HOME/Apps/pkg/cabal

# export GEM_HOME=$HOME/Apps/pkg/ruby/
# export GEM_PATH=$GEM_HOME/bin
# export PATH="$GEM_PATH:$PATH"

export NODE_PATH="$HOME/Apps/pkg/nodejs:/usr/lib/node_modules"
export PATH="$HOME/Apps/pkg/nodejs/bin:$PATH"

export JAVA_HOME="/usr/lib/jvm/default"
export PATH="$JAVA_HOME/bin:$PATH"

export RACKET_HOME="$HOME/.local/share/racket/8.3"
export PATH="$RACKET_HOME/bin:$PATH"
