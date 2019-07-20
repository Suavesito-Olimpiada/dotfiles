#!/bin/sh

SONG=$(mpc list Title | dmenu -l 10)

if [[ -n "$SONG" ]]
then
    mpc searchplay "$SONG"
fi
