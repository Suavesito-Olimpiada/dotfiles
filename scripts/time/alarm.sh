#!/usr/bin/env bash

TFMT=${1:-m} # format, s, m, h
TIME=${2:-10} # time to stop
MSG="${3:-'¡¡¡Ya está!!!'}"

case $TFMT
in
    s)
        sleep $TIME
    ;;
    m)
        sleep $((TIME*60))
    ;;
    h)
        sleep $((TIME*3600))
    ;;
    *)
        exit
    ;;
esac

notify-send -u critical "$MSG"

VOL=$(amixer -D pulse get Master | sed -e '7,7!d' -e 's/\(.*[^0-9]\)\([0-9][0-9]*\)\(.*[^0-9]\)/\2/')
TEMP=$(pactl info | grep -i sink | sed -E 's/.*: (.*)/\1/')

pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo
pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo 100%

ffplay -loglevel -8 -t 5 -loop 3 -nodisp -autoexit "/media/data/Música/Kungs Vs. Cookin On 3 Burners/Novinki s raznyh popularnyh MP3 sajtov Ver.51/27 This Girl.mp3"

pactl set-default-sink $TEMP
pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo $VOL%
