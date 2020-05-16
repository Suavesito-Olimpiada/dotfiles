#!/usr/bin/env bash

APPNAME=suave.Brightess
ICON=/usr/share/icons/la-capitaine/status/symbolic/display-brightness-symbolic.svg

source $HOME/.config/scripts/lib/notify.sh

function set_brightness() {
    light -S $1
}

function get_brightness() {
    light -G | cut -d '.' -f 1
}

function up_brightness() {
    light -A $1
}

function down_brightness() {
    light -U $1
}

if [[ -z $1  ]]
then
    printf "It is needed one argument (up|down|set|get).\n"
    exit
fi

DELTA=5%

case $1 in
    'up')
        up_brightness $DELTA
        notify "-" "$(get_brightness | cut -c 1-3)" "true" "$(get_brightness)" "40" solid
        ;;
    'down')
        down_brightness $DELTA
        notify "-" "$(get_brightness | cut -c 1-3)" "true" "$(get_brightness)" "40" solid
        ;;
    'get')
        get_brightness
        ;;
    'set')
        if [[ -z $2 ]]
        then
            printf "It is needed the brightness.\n"
            exit
        fi
        set_brightness $2
        notify "-" "$(get_brightness | cut -c 1-3)" "true" "$(get_brightness)" "40" solid
        ;;
esac

