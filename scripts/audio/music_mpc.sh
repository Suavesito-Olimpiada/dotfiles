#!/usr/bin/env bash

SELECTOR=$1     # FZF or DMENU

if [[ $SELECTOR = "dmenu" ]]
then
    CMD="dmenu -l 5"
elif [[ $SELECTOR = "fzf" ]]
then
    CMD="fzf --height 10%"
else
    printf "Select a valid selector ('fzf' or 'dmenu').\n"
    exit 1
fi

FIELD=$(printf "Artist\nTitle"  | $CMD)
[[ -z $FIELD ]] && exit
SONG=''

if [[ $SELECTOR = "dmenu" ]]; then
    CMD="dmenu -l 10"
else
    CMD="fzf --height 50%"
fi

if [[ $FIELD = Artist ]]
then
    SFIELD="$(mpc list $FIELD | $CMD)"
    [[ -z $SFIELD ]] && exit
    SONG="$(mpc search artist "$SFIELD" | sed -nE 's_.+/([^ ]+)(( [^ ]+)* -)?[ ]+(.+)\.(mp3|ogg)_\4_gp' | $CMD)"
else
    SONG="$(mpc list $FIELD | $CMD)"
fi

[[ -n "$SONG" ]] && mpc searchplay title "$SONG"
