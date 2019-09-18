#!/bin/env sh

SOUND=$(pactl list sinks short | awk '{printf "%s %s\n", $7, $2}' | sort |
        head -1 | awk '{printf "%s\n", $2}')
pactl set-sink-volume $SOUND $@
