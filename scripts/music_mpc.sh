#!/bin/sh

FIELD=$(echo "Artist
Title"  | dmenu -l 5)
SONG=''

if [[ $FIELD = Artist ]]
then
    SFIELD="$(mpc list $FIELD | dmenu -l 10)"
    SONG="$(mpc search artist "$SFIELD" | sed -nE 's_.+/([^ ]+)(( [^ ]+)* -)?[ ]+(.+)\.(mp3|ogg)_\4_gp' | dmenu -l 10)"
else
    SONG="$(mpc list $FIELD | dmenu -l 10)"
fi

if [[ -n "$SONG" ]]
then
    mpc searchplay title "$SONG"
fi
