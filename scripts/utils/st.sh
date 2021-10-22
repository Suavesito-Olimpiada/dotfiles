#!/usr/bin/env bash

XYS=$(herbstclient list_monitors | awk '/FOCUS/ {printf "%s\n", $2}' | sed 's/[x+]/ /g')
XS=$(printf "%s" "$XYS" | awk '{printf "%s", $1}')
YS=$(printf "%s" "$XYS" | awk '{printf "%s", $2}')

FONT='Hack Nerd Font Mono:style=Regular:pixelsize=10:antialias=true:autohint=true'
TEXT=$(seq -s "." 0 80 | sed -E 's/[0-9]//g')
PIX_LENGHT=$(xftwidth "$FONT" "$TEXT")

st -f "$FONT" -g 80x24+$(( (XS-PIX_LENGHT)/2 ))+$(( (YS-1-(24*15))/2 )) -i
