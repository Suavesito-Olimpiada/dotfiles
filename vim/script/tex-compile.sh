#!/bin/env bash

function set_x_env()
{
    namepdf1=`echo "$1.pdf" | sed 's:/home/jose:~:'`
    namepdf2="$1.pdf"

    wininfo1="error"
    wininfo2="error"

    while [ "$wininfo1" = "error" ] && [ "$wininfo2" = "error" ]
    do
        wininfo1=`xwininfo -name "$namepdf1" |& grep -P -o 'error'`;
        wininfo2=`xwininfo -name "$namepdf2" |& grep -P -o 'error'`;
        sleep 0.1;
    done

    sleep 2

    herbstclient split horizontal
    herbstclient shift right
    herbstclient split vertical 0.75
    herbstclient focus down
    herbstclient focus left
    herbstclient shift right
    herbstclient focus up
    sleep 0.1
    xdotool key s
    sleep 0.1
    xdotool key ctrl+r
    herbstclient focus left
    sleep 0.1
    xdotool key Return
}

set_x_env "$2" &!

cd "$1"

latexmk "$3"
