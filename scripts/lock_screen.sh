#!/bin/bash

if [[ -z $@ ]]
then
    for (( i=5 ; i>0 ; --i )); do echo "Tu pantalla se apagará en $i."; sleep 1; done | dzen2 -x 660 -y 490 -w 600 -h 100 -fn "xos4 Terminus:size=30" -e 'button1=exec:killall lock_screen.sh'
fi

export XSECURELOCK_PASSWORD_PROMPT=disco
xsecurelock
