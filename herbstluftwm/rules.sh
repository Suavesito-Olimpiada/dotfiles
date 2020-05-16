#!/usr/bin/env bash

hc() {
    herbstclient "$@"
}


hc rule class~'[Dd]ragon-drag-and-drop' floating=on
hc rule class~'st-256color' floating=on
