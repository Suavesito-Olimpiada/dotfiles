#!/bin/env sh

SOUND=`pactl list sinks | grep "Monitor Source" | sed 's/\([^a-zA-Z]Monitor Source: \)\(.*\)\(.monitor\)/\2/' | sed -n '1p'`
pactl set-sink-volume $SOUND $@
