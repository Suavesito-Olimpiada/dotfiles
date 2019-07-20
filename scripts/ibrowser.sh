#!/bin/sh

URL=$(dmenu -i -p "URL")

tabbed -dc -r 3 surf -BDfGIMNPS -e n > "/home/jose/.config/scripts/dmenu_search/surf.xid" $URL
