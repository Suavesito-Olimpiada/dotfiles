#!/usr/bin/env bash

DMENU="$HOME/.config/scripts/lib/dmenu.sh"

TMPDIR="$(mktemp -d)"
cd "$TMPDIR"

MAXPAGE=5
TAGOPTIONS="\
#minimalism
#cyberpunk
#fantasy girl
#anime girls
#digital art
#anime
#nature
#cityscape
#pixel art
#Studio Ghibli
#landscape"

QUERY="$(printf "$TAGOPTIONS" | $DMENU -i -l 5 -p "Search Wallhaven: ")"
[[ -z "$QUERY" ]] && exit

SORTOPTIONS="\
date_added
relevance
random
views
favorites
toplist"
SORTING="$(printf "$SORTOPTIONS" | $DMENU -i -l 5 -p "Sort Order: ")"
[[ -z "$SORTING" ]] && exit

CQUERY="$(printf "$QUERY" | sed -e 's/#//g' -e 's/ /+/g')"

APPNAME="Wallpaper Download"
ICON="/usr/share/icons/la-capitaine/actions/22x22-dark/downloading.svg"
TIMEOUT="3000"
DUID="5000"
source $HOME/.config/scripts/lib/notify.sh

notify "Downloading wallpapers 🖼️" "$QUERY - $SORTING" "false"
# notify-send "⬇️ Downloading wallpapers 🖼️"
for i in $(seq 1 5)
do
    curl -s "https://wallhaven.cc/api/v1/search?\
q=${CQUERY}&\
categories=110&\
purity=100&\
atleast=1920x1080&\
sorting=${SORTING}&\
page=$i" > tmp.json
    # https://wallhaven.cc/api/v1/search? -> search url api
    # q=anime&                            -> tag options, some from $TAGOPTIONS
    # categories=111&                     -> categories is 100 (general) | 010 (anime) | 001 (people)
    # purity=100&                         -> purity only accepts 100 (SFW) | 010 (sketchy, for 001 (NSFW) needs API keys
    # atleast=1920x1080&                  -> minimum resolution accepted for images $width x $height
    # sorting=relevance&                  -> sorting mode accepts $SORTOPTIONS
    # order=desc&                         -> accepts asc (↑) and desc (↓)
    # page=3                              -> page number, starting from zero
    jq -r '.data[].path' tmp.json |\
        parallel -j 8 wget -q -nc -P "${TMPDIR}" '{}'
done
rm tmp.json
notify "Download finish ✅" "${QUERY} - ${SORTING}" "true"

sxiv -t "${TMPDIR}"
mv -n "${TMPDIR}"/* ~/Imágenes/Wallpapers/
cd ~
rmdir "${TMPDIR}"
