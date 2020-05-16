#!/usr/bin/env bash

git add --all
git commit -m "Automatic commit message ($(date '+%H:%M %d-%m-%y'))."
git push -u origin master
