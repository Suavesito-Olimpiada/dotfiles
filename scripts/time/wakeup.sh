#!/usr/bin/env bash

PID=$(pgrep pulseaudio)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

SOUND=$(pactl list sinks | grep "Monitor Source" | sed 's/\([^a-zA-Z]Monitor Source: \)\(.*\)\(.monitor\)/\2/' | sed -n '1p')
pactl set-sink-volume $SOUND 80%

if [[ $@ = 1 ]]
then
    $HOME/.config/scripts/audio/music.sh play
else
    $HOME/.config/scripts/audio/music.sh pause
fi
