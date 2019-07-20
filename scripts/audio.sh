#!/bin/env sh

SOURCE=`pactl info | grep "Default Source" | sed 's/\(.*\)\(hdmi\|analog\)\(-stereo.*\)/\2/'`

if [[ "$SOURCE" = "hdmi" ]]
then
    notify-send "Analog"
    pactl set-card-profile 0 "output:analog-stereo"
else
    notify-send "HDMI"
    pactl set-card-profile 0 "output:hdmi-stereo"
fi
