#!/usr/bin/env bash

bat -l julia -n --color=always "$2" | less -R $1
