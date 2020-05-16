#!/usr/bin/env bash

SOURCE=$(cat $HOME/.config/scripts/screen/hdmi/hdmi.st)

if [[ "$SOURCE" = "hdmi" ]]
then
    xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1 --auto
    herbstclient detect_monitors
    herbstclient reload
    echo screen > $HOME/.config/scripts/screen/hdmi/hdmi.st
else
    xrandr --output HDMI-1 --mode 1920x1080 --same-as eDP-1
    herbstclient detect_monitors
    herbstclient reload
    echo hdmi > $HOME/.config/scripts/screen/hdmi/hdmi.st
fi
