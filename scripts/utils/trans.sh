#!/usr/bin/env bash

FONT="Noto Sans Mono CJK JP, Noto Sans Mono CJK TC, Noto Sans Mono CJK SC, Noto Sans Mono CJK HK, Noto Sans Mono CJK KR:style=Regular:pixelsize=10"
DMENU="$HOME/.config/scripts/lib/dmenu.sh"

CMD="$DMENU -l 5"
LANGTO=$(printf "en\nes\nfr\nit\nja\nko" | $CMD)
[[ -z $LANGTO ]] && exit

TEXT=$(echo | $DMENU -f "$FONT" -p "Translate: ")
[[ -z $TEXT ]] && exit

TRANSLATION="$(trans -t $LANGTO -no-warn -no-ansi -b "$TEXT")"
TRANSLATION="${TRANSLATION#*] }"
ACTION=$(printf "%s\n%s" "$TRANSLATION" "Copy" | $DMENU -i -l 2)
if [ "$ACTION" == "Copy" ]; then
    printf "$TRANSLATION" | xclip -i
fi
