#!/usr/bin/env bash

sleep 1

scrot -s '%Y-%m-%d-%T_$wx$h.png' -q 100 -z -e 'mv $f ~/Imágenes/Screenshots/'
