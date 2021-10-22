#!/usr/bin/env bash


case "$@" in
    "")
        maim -m 10 -q "$HOME/Imágenes/Screenshots/`date +'%Y-%m-%d-%T'.png`"
    ;;
    "-s")
        maim -s -m 10 -q "$HOME/Imágenes/Screenshots/`date +'%Y-%m-%d-%T'.png`"
    ;;
esac
