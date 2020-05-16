#!/usr/bin/env bash

SEARCH=$(echo|dmenu -p "Less Output Pipe: ")
alacritty -e bash -ci "$SEARCH |& less -dgKsSR"
