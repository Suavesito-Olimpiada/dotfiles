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

#export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"
export MANPAGER="less -R"

export VISUAL="/bin/vim"
export EDITOR="/bin/vim"

# As I use termite for some things, to be able to use it with ssh
# I need to change the term enviroment variable.
if [[ $TERM == xterm-termite ]]; then
    export TERM="xterm-256color"
fi

# Auto-Notify threshold for zsh-auto-notify
AUTO_NOTIFY_THRESHOLD=30
AUTO_NOTIFY_TITLE="Hey! %command has just finished"
AUTO_NOTIFY_BODY="It completed in %elapsed seconds with exit code %exit_code"
AUTO_NOTIFY_IGNORE+=("docker" "man" "sleep" "ssh" "tmux" "yaourt" "julia" "bpython" "R" "julia-1.3" "sst")

#export LC_ALL="es_MX.UTF-8"

# Keys that the people shouldn't have (except for me)
source /home/jose/.zsh/secrets.zsh

# For downgrade package [ALA Manjaro](https://wiki.manjaro.org/index.php?title=Downgrading_packages)
export DOWNGRADE_FROM_ALA="1"

# Julia threads to nproc
export JULIA_NUM_THREADS=$(nproc)

# Path and home variables
export ZPLUG_HOME=/home/jose/.zsh/plugin/zplug

export LOC_APPS=$HOME/Apps
export PATH="$LOC_APPS/bin:$PATH"

export PATH="/home/jose/.local/bin:$PATH"
export PATH="/home/jose/.config/scripts:$PATH"

export GOPATH=$HOME/Apps/pkg/go
export PATH="$GOPATH:$GOPATH/bin:$PATH"

export CARGO_HOME=$HOME/Apps/pkg/rust
export PATH="$CARGO_HOME/bin:$PATH"

export GEM_HOME=$HOME/Apps/pkg/ruby/
export GEM_PATH=$GEM_HOME
export PATH="$GEM_PATH/bin:$PATH"

export NODE_PATH=$HOME/Apps/pkg/nodejs
export PATH="$NODE_PATH/bin:$PATH"

export JAVA_HOME="/usr/lib/jvm/java-12-openjdk"
export PATH="$JAVA_HOME/bin:$PATH"
