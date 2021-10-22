#!/usr/bin/env bash

DMENU="$HOME/.config/scripts/lib/dmenu.sh"
SEARCH=$(echo | $DMENU -p "Less Output Pipe: ")
alacritty -e bash -ci "$SEARCH |& less -dgKsSR"
