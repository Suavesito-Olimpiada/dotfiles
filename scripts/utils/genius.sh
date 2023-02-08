#!/usr/bin/env bash

DMENU="$HOME/.config/scripts/lib/dmenu.sh"
OP=$(echo | $DMENU -p "Operation: ")

[[ -n "$OP" ]] || exit

RESULT=$(genius --nomixed --maxdigits=0 --precision=2048 --fullexp -e "$OP")
RESULT=${RESULT#*] }
ACCION=$(printf "%s\n%s" "$RESULT" "copy" | $DMENU -i -l 2)
if [ "$ACCION" == "copy" ]; then
    printf '%s' "$RESULT" | xclip -i
fi
