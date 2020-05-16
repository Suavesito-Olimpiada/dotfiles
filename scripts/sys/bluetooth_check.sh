#!/usr/bin/env bash

APPNAME=suave.Bluetooth
ICON=""

STATUS=$(bluetooth | awk '{printf "%s\n", toupper($3)}')

if [[ $STATUS = ON ]]
then
    ICON=/usr/share/icons/la-capitaine/status/symbolic/bluetooth-active-symbolic.svg
else
    ICON=/usr/share/icons/la-capitaine/status/symbolic/bluetooth-disabled-symbolic.svg
fi

source $HOME/.config/scripts/lib/notify.sh

BODY="Not connected to a network."

[[ -z $(bluetoothctl info | grep -i name) ]]  || BODY="Connected to <b>$(bluetoothctl info | grep -i name | sed -E 's/.*: (.*)/\1/')</b>."

notify "$STATUS" "$BODY"
