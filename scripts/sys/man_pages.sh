#!/usr/bin/env bash

# Using native man search with '-k'
# Here
#

DMENU="$HOME/.config/scripts/lib/dmenu.sh"
search=$(man -k . | $DMENU -i -l 11 -p "Man Page: " | awk '{print $2 " " $1}' | sed 's/(\(.*\))\(.*\)/\1\2/')
if [[ -n $search ]]
then
    echo $search
    alacritty -e bash -ci "MANPAGER=\"sh -c 'col -bx | bat -l man -p --pager \\\"less -R\\\"'\" man $search"
fi
