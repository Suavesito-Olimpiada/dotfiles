#!/bin/bash

search=$(man -k . | dmenu -i -l 11 -p "Man Page: " | awk '{print $2 " " $1}' | sed 's/(\(.*\))\(.*\)/\1\2/')
if [[ -n $search ]]
then
    termite -e "bash -ci \"man $search | env MAN_PN=1 vim -M +MANPAGER -\""
fi
