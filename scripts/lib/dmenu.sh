#!/usr/bin/env bash

TEMP=$(getopt -o inrztl:p:f: -- "$@")
eval set -- "$TEMP"

LINES=""
PROMPT=""
FONT=""
FILTER=""
SPACE_OR_FUZZY=""
NOINPUT=""
INSENSITIVE=""
# extract options and their arguments into variables.
while true ; do
    case "$1" in
        -l)
            LINES="$2"
            shift 2
            ;;
        -p)
            PROMPT="$2"
            shift 2
            ;;
        -f)
            FONT="$2"
            shift 2
            ;;
        -r)
            FILTER="$1"
            shift
            ;;
        -t|-z)
            SPACE_SEP="$1"
            shift
            ;;
        -n)
            NOINPUT="-noinput"
            shift
            ;;
        -i)
            INSENSITIVE="$1"
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Internal error!"
            exit 1
            ;;
    esac
done

[[ -n "$LINES" ]] || LINES="0"
[[ -n "$PROMPT" ]] || PROMPT=""

# XYS=$(xrandr -q | sed -En '1,1s/.+current ([0-9]+) x ([0-9]+).+/\1 \2/p')
# I did not find a way to get the actual monitor with xrandr, so I'll use
# herbsftluft to do the job
XYS=$(herbstclient list_monitors | awk '/FOCUS/ {printf "%s\n", $2}' | sed 's/[x+]/ /g')
XS=$(printf "%s" "$XYS" | awk '{printf "%s", $1}')
YS=$(printf "%s" "$XYS" | awk '{printf "%s", $2}')

[[ -n "$FONT" ]] || FONT="Hack Nerd Font Mono:style Regular:pixelsize=10:antialias=true:size=8"

FILE=$(cat -)
CHAR_LENGHT=$(printf "%s" "$FILE" | awk '{ if(length > L) { L=length } } END { print L }')
TEXT="$PROMPT"$(seq -s "." 0 $CHAR_LENGHT | sed -E 's/[0-9]//g')
PIX_LENGHT=$(xftwidth "$FONT" "$TEXT....")
[[ $PIX_LENGHT -gt 360 ]] || PIX_LENGHT="360"
[[ $PIX_LENGHT -lt $XS ]] || PIX_LENGHT="$XS"

printf "%s" "$FILE" | dmenu -class dmenu -fn "$FONT" -x $(( (XS-PIX_LENGHT)/2 )) -w $PIX_LENGHT -y $(( (YS-1-(LINES*15))/2 )) -h 15 -l $LINES -p "$PROMPT" $FILTER $SPACE_SEP $NOINPUT $INSENSITIVE
