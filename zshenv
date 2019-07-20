#
#  _________  _   _   _____ _   ___     __
# |__  / ___|| | | | | ____| \ | \ \   / /
#   / /\___ \| |_| | |  _| |  \| |\ \ / /
#  / /_ ___) |  _  | | |___| |\  | \ V /
# /____|____/|_| |_| |_____|_| \_|  \_/
#
# Here are my enviroment variables

#export MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"
export MANPAGER="less -R"

export VISUAL="/bin/vim"
export EDITOR="/bin/vim"

export WAKATIME_HOME="/home/jose/.config/wakatime"

#export LC_ALL="es_MX.UTF-8"

# Keys that the people shouldn't have (except for me)
source /home/jose/.zsh/secrets.zsh

export ZPLUG_HOME=/home/jose/.zsh/plugin/zplug

export JULIA_NUM_THREADS=4

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
