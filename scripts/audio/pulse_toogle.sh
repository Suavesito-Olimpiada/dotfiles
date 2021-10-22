#!/usr/bin/env bash

function get_default_sink() {
    pactl info | grep -i "default sink" | sed -E 's/.*: (.*)/\1/'
}

function get_sink_list() {
    pactl list sinks short | cut -f 2
}

function get_sink_signature() {
    SINKS_LIST=$(get_sink_list)
    printf "%s\n" $SINKS_LIST | grep -i $1
}

function move_input() {
    for input in $1
    do
        pactl move-sink-input $input $2
    done
}

ALSA=$(get_sink_signature alsa)
BLUEZ=$(get_sink_signature bluez)
DEFAULT=$(get_default_sink)

INPUT_LIST=$(pactl list sink-inputs short | cut -f 1)


APPNAME=${Music}
ICON=""

if [[ $DEFAULT = $ALSA ]]
then
    ICON=/usr/share/icons/la-capitaine/devices/scalable-dark/audio-headset.svg
else
    ICON=/usr/share/icons/la-capitaine/devices/scalable-dark/audio-speakers.svg
fi

source $HOME/.config/scripts/lib/notify.sh

if [[ $DEFAULT = $ALSA ]]
then
    move_input "$INPUT_LIST" "$BLUEZ"
    pactl set-default-sink "$BLUEZ"
    notify "Audio" "<b>Bluetooth</b>"
else
    move_input "$INPUT_LIST" "$ALSA"
    pactl set-default-sink "$ALSA"
    notify "Audio" "<b>Speakers</b>"
fi
