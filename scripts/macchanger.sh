#!/usr/bin/sh

ifconfig wlp2s0 down
macchanger -r wlp2s0

# Sleep random ammount of time to make it harder
# to correlate changing mac
sleep $(($RANDOM % 15))

ifconfig wlp2s0 up
