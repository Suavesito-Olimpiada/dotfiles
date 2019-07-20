#!/bin/env sh

PID=$(pgrep pulseaudio)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

SOUND=$(pactl list sinks | grep "Monitor Source" | sed 's/\([^a-zA-Z]Monitor Source: \)\(.*\)\(.monitor\)/\2/' | sed -n '1p')
pactl set-sink-volume $SOUND 80%

if [[ $@ = 1 ]]
then
    /home/jose/.config/scripts/music.sh play
else
    /home/jose/.config/scripts/music.sh pause
fi
