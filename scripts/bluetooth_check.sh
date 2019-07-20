#!/bin/env bash

status=`bluetooth | grep -o on`

if [ ! -z $status ]
then
	notify-send "BLUETOOTH : ON"
else
	notify-send "BLUETOOTH : OFF"
fi
