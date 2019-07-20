#!/bin/env bash

status=`wifi | grep -o on`

if [ ! -z $status ]
then
	notify-send "WIFI : ON"
else
	notify-send "WIFI : OFF"
fi
