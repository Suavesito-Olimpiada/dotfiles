#!/usr/bin/env bash
# Notify me with notify-send if my battery is below $@%.
# You can set this to run via cron.

[[ -n $1 ]] || exit

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
BAT=$(cat /sys/class/power_supply/BAT1/capacity)
if [[ -f /sys/class/power_supply/BAT1/capacity ]]
then
    if (( $BAT < $1 ))
    then
        notify-send -u critical "Battery critically low."
    elif (( $BAT > 98 ))
    then
        notify-send -u critical "Battery completely charged."
    fi
fi
