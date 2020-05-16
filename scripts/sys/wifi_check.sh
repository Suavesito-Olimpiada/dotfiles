#!/usr/bin/env bash

APPNAME=suave.Wifi
ICON=""

STATUS=$(wifi | awk '{printf "%s\n", toupper($3)}')

if [[ $STATUS = ON ]]
then
    ICON=/usr/share/icons/la-capitaine/status/symbolic/network-wireless-connected-symbolic.svg
else
    ICON=/usr/share/icons/la-capitaine/status/symbolic/network-wireless-offline-symbolic.svg
fi

source $HOME/.config/scripts/lib/notify.sh

BODY="Not connected to a network."

[[ -z $(iwgetid -r) ]]  || BODY="Connected to <b>$(iwgetid -r)</b>."

notify "$STATUS" "$BODY"
