#!/usr/bin/env bash

APPNAME=${APPNAME:-Dunst}
ICON=${ICON:-/usr/share/icons/Adwaita/22x22/devices/computer.png}
URGENCY=${URGENCY:-normal}
TIMEOUT=${TIMEOUT:-1500}
DUID=${DUID:-5710}

function create_bar() {
    $HOME/.config/scripts/lib/bar.sh $1 $2 $3
}

function play_sound() {
    SOUND_PATH="/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"
    paplay $SOUND_PATH
}

function notify() {
    TITLE=${1:-}
    BODY=${2:-}
    SOUND=${3:-true}
    BARP=${4:-0}
    BARL=${5:-0}
    BARS=${6:-line}

    BAR=$(create_bar $BARP $BARL $BARS)

    [[ $SOUND = true ]] && play_sound

    dunstify -a "$APPNAME" -i "$ICON" -t "$TIMEOUT" -r "$DUID" -u "$URGENCY" "$TITLE" "$BAR $BODY"
}


quote() {
    local q="$(printf '%q ' "$@")"
    printf '%s' "${q% }"
}
