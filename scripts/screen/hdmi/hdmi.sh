#!/usr/bin/env bash

SOURCE=$(cat $HOME/.config/scripts/screen/hdmi/hdmi.st)

if [[ "$SOURCE" = "hdmi" ]]
then
    xrandr --output HDMI1 --mode 1920x1080 --right-of eDP1 --auto
    herbstclient detect_monitors
    herbstclient reload
    echo screen > $HOME/.config/scripts/screen/hdmi/hdmi.st
else
    xrandr --output HDMI1 --mode 1920x1080 --same-as eDP1
    herbstclient detect_monitors
    herbstclient reload
    echo hdmi > $HOME/.config/scripts/screen/hdmi/hdmi.st
fi
