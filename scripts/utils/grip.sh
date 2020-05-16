#!/usr/bin/env bash

# Create a tiny server to see MarkDown rendered
grip $@ &> /dev/null &!

sleep 2

surf "http://127.0.0.1:6419" &> /dev/null

kill $(ps -e | grep grip | awk '{printf "%s", $1}') &> /dev/null

