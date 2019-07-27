#!/bin/env sh

SOUND=`pactl list sinks short | grep "RUNNING" | sed -n '1p' | awk '{printf "%s", $2}'`
pactl set-sink-volume $SOUND $@
