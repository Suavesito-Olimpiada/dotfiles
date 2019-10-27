#!/usr/bin/sh

ifconfig wlp2s0 down
macchanger -r wlp2s0

# Sleep random ammount of time
sleep $(($RANDOM % 15))

ifconfig wlp2s0 up
