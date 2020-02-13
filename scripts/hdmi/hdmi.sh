#!/bin/env sh

SOURCE=`cat /home/jose/.config/scripts/hdmi/hdmi.st`

if [[ "$SOURCE" = "hdmi" ]]
then
    xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1 --auto
    herbstclient detect_monitors
    herbstclient reload
    echo screen > /home/jose/.config/scripts/hdmi/hdmi.st
else
    xrandr --output HDMI-1 --mode 1920x1080 --same-as eDP-1
    herbstclient detect_monitors
    herbstclient reload
    echo hdmi > /home/jose/.config/scripts/hdmi/hdmi.st
fi
