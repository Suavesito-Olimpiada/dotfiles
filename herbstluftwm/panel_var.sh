#!/bin/env bash

cp /home/jose/.config/herbstluftwm/vars /tmp/vars
VARS=/tmp/vars

while true; do
    cpu=$(mpstat 1 1 | tail -1 | awk '{printf "%.0f", $3 + $4 + $5}')

    if (( $cpu < 100 )); then if (( $cpu < 10 )); then cpu="  $cpu"; else cpu=" $cpu"; fi ; fi

    sed -i "1s/.*/$cpu%/" $VARS
done &> /dev/null &

while true; do
    FREE=$(free -m)
    usd=$(echo $FREE | awk '{printf "%.2fG", $9/1024}')
    cac=$(echo $FREE | awk '{printf "%.2fG", $12/1024}')
    swp=$(if [[ $(echo $FREE | awk '{printf "%d", $16}') != 0 ]]; then echo $FREE | awk '{printf ":%.2fG", $16/1024}'; fi )
    tot=$(echo $FREE | awk '{printf "%.2fG", $8/1024}')
    lig=$(light | sed 's/\([0-9]*\)\..*/\1/') #| sed 's/\([0-9]*\)\.\([0-9]*\)/\1/') # It uses the light command in https://github.com/haikarainen/light
    vol=$(amixer -D pulse get Master | sed -e '7,7!d' -e 's/\(.*[^0-9]\)\([0-9][0-9]*\)\(.*[^0-9]\)/\2/')
    if [[ -z $(pgrep mpv) ]]
    then
        MPD=$(playerctl -l | grep mpd)
        MPV=$(playerctl -l | grep mpv)
        PLM=$(playerctl -l | grep plasma)
        MSC=''

        [[ -z $MPD ]] || MSC=$MPD
        [[ -z $PLM ]] || MSC=$PLM
        [[ -z $MPV ]] || MSC=$MPV

        # if [[ -z $(playerctl -l) ]]
        # then
        #     msc=$(mpc current | sed -e 's:\(.*\)\(\.\(mp[34]\|aac\)\):\1:' -e 's_/_\\/_g' -e 's:&:\\&:g' | colrm 40)
        #     # Use of colrm intead of cut -c because of 'https://unix.stackexchange.com/questions/163721/can-not-use-cut-c-characters-with-utf-8'
        # else
        msc=$(playerctl --player=$MSC metadata --format '{{artist}} - {{title}}' | sed -e 's_/_\\/_g' -e 's:&:\\&:g' | colrm 40)
        # fi
    else
        msc=$(xwininfo -id $(xdotool search --pid $(pgrep mpv) |& sed -n "s/\([0-9]\)/\1/p") | sed -n -e "2p" | sed -e "s/\(^[a-zA-Z:0-9]* \)\([a-zA-Z:0-9]* \)\([a-zA-Z:0-9]* \)\([a-zA-Z:0-9]* \)\(.*$\)/\5/" -e 's:"::g' -e 's_/_\\/_g' -e 's:&:\\&:g' | colrm 40)
    fi

    if (( $vol < 100 )); then if (( $vol < 10 )); then vol="  $vol"; else vol=" $vol"; fi ; fi
    if (( $lig < 100 )); then if (( $lig < 10 )); then lig="  $lig"; else lig=" $lig"; fi ; fi

    if (( $vol == 0 )); then vol=" MUT"; fi

    sed -i "2s/.*/$usd/" $VARS
    sed -i "3s/.*/$cac/" $VARS
    sed -i "4s/.*/$swp/" $VARS
    sed -i "5s/.*/$tot/" $VARS
    sed -i "8s/.*/$lig%/" $VARS
    sed -i "9s/.*/$vol%/" $VARS
    sed -i "10s/.*/$msc/" $VARS

    sleep 0.5
done &> /dev/null &

while true; do
    bat=$(acpi | awk '{print $4}' | sed 's/\([0-9]*\)\(.*\)/\1/')
    tim=$(acpi | awk '{print $3" "$5}' | sed 's/\(.*\)\(,\)\(.*\)/\1\3/')

    if (( $bat < 100 )); then if (( $bat < 10 )); then bat="  $bat"; else bat=" $bat"; fi ; fi

    if (($bat < 10 )); then bat="^fg(#3333FF)$bat"; fi

    sed -i "6s/.*/$bat%/" $VARS
    sed -i "7s/.*/$tim/" $VARS

    sleep 3
done &> /dev/null &
