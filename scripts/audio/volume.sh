#!/usr/bin/env bash

function get_icon() {
    VOL=$1
    if (( VOL < 30 ))
    then
        ICON=/usr/share/icons/la-capitaine/status/scalable-dark/audio-volume-low.svg
    elif (( VOL < 60 ))
    then
        ICON=/usr/share/icons/la-capitaine/status/scalable-dark/audio-volume-medium.svg
    else
        ICON=/usr/share/icons/la-capitaine/status/scalable-dark/audio-volume-high.svg
    fi
    printf "%s" "$ICON"
}

function set_volume() {
    pactl set-sink-volume $1 $2
}

function get_volume() {
    amixer -D pulse get Master | sed -E -e '7,7!d' -e 's/.*\[([0-9]+).*/\1/'
}

function up_volume() {
    pactl set-sink-volume $1 +$2
}

function down_volume() {
    pactl set-sink-volume $1 -$2
}

function toggle_volume() {
    amixer sset Master toggle
}


APPNAME=suave.Volume
ICON=""

case $1 in
    "up")
        ICON=$( get_icon $(( $(get_volume) + 5 )) )
        ;;
    "down")
        ICON=$( get_icon $(( $(get_volume) - 5 )) )
        ;;
    "set")
        ICON=/usr/share/icons/la-capitaine/status/scalable-dark/audio-volume-medium.svg
        ;;
    "toggle")
        if [[ $(amixer sget Master | sed -E -e '7,7!d' -e 's/.*\[([a-z]+).*/\1/') = on ]]
        then
            ICON=/usr/share/icons/la-capitaine/status/scalable-dark/audio-volume-muted.svg
        else
            ICON=$( get_icon $(get_volume) )
        fi
        ;;
esac

source $HOME/.config/scripts/lib/notify.sh

HELP="Posible commands are
    get            - return volume percentage as an integer
    set <volume>%  - set volume to <volume> percent
    up             - up volume by 5%
    down           - down volume by 5%
    toggle         - toggle between mute an not mute
"

DELTA="5%"
SINK=$(pactl info | grep -i "default sink" | sed -E 's/.* (.*)/\1/')

case $1 in
    'up')
        up_volume $SINK $DELTA
        notify "-" "$(get_volume | cut -c 1-3)" "true" "$(get_volume)" "40"
        ;;
    'down')
        down_volume $SINK $DELTA
        notify "-" "$(get_volume | cut -c 1-3)" "true" "$(get_volume)" "40"
        ;;
    'get')
        get_volume
        ;;
    'set')
        if [[ -z $2 ]]
        then
            printf "It is needed the volume.\n"
            exit
        fi
        set_volume $SINK $2
        notify "-" "$(get_volume | cut -c 1-3)" "true" "$(get_volume)" "40"
        ;;
    'toggle')
        toggle_volume
        notify "-" "$(get_volume | cut -c 1-3)" "true" "$(get_volume)" "40"
        ;;
    'help')
        printf "%s" "$HELP"
        ;;
    *)
        printf "Not valid command: %s\n" "$1"
        ;;
esac

