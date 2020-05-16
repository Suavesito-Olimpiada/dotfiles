#!/usr/bin/env bash

URL=$(dmenu -i -p "URL")

tabbed -dc -r 3 surf -BDfGIMNPS -e n > "$HOME/.config/scripts/dmenu_search/surf.xid" $URL
