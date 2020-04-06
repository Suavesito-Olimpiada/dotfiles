#!/usr/bin/env sh

TFMT=m # format, s, m, h
TIME=10 # time to stop
MSG="¡¡¡Ya está!!!"

if [[ -n $1 ]]
then
    TIME=$1
fi

if [[ -n $2 ]]
then
    TFMT=$2
fi

if [[ -n $3 ]]
then
    MSG="$3"
fi

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

pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo 100%

ffplay -loglevel -8 -t 5 -loop 3 -nodisp -autoexit "/media/data/Música/Kungs vs Cookin on 3 Burners - This Girl.mp3"

pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo $VOL%
