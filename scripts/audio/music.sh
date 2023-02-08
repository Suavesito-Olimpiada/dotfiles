#!/usr/bin/env bash

APPNAME=Music
ICON=""

case $1 in
    "pos")
        if [[ -z $2 ]] || [[ -z $3 ]]
        then
            printf "Are needed at least two more arguments (+|-, numeric).\n"
            exit
        fi
        case $2 in
            "+")
                ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-seek-forward.svg
                ;;
            "-")
                ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-seek-backward.svg
                ;;
            *)
                exit
                ;;
        esac
        ;;
    "next")
        ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-skip-forward.svg
        ;;
    "prev")
        ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-skip-backward.svg
        ;;
    "play")
        ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playback-start.svg
        ;;
    "pause")
        ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playback-pause.svg
        ;;
    "toggle")
        if [[ $(playerctl status) = Playing ]]
        then
            ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playback-start.svg
        else
            ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playback-pause.svg
        fi
        ;;
    "toggle-random")
        if [[ $(mpc | sed -E -e '3,3!d' -e 's/.*dom: ([a-z]+).*/\1/') = on ]]
        then
            ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playlist-repeat.svg
        else
            ICON=/usr/share/icons/la-capitaine/actions/22x22-dark/media-playlist-shuffle.svg
        fi
        ;;
esac

# MPD depends on mpd-mpris
# MPV depends on mpv-mpris

case $1 in
    "pos")
        SEEK=$3
        if [[ $2 = "+" ]]
        then
            playerctl position $SEEK+
        else
            playerctl position $SEEK-
        fi
        ;;
    "next")
        playerctl next
        ;;
    "prev")
        playerctl previous
        ;;
    "play")
        playerctl play
        ;;
    "pause")
        playerctl pause
        ;;
    "toggle")
        playerctl play-pause
        ;;
    "toggle-random")
        mpc random
        notify "Music" "Random $(mpc | sed -E -e '3,3!d' -e 's/.*dom: ([a-z]+).*/\1/')" "true"
        exit
        ;;
esac

# this depends on playerctld running
# sleep 0.25
STATUS="$(playerctl status)"
SONG="$(playerctl metadata --format '{{title}} ({{artist}})' | colrm 20)"
ART_URL="$(playerctl metadata --format '{{mpris:artUrl}}')"
if [[ -n $ART_URL ]]
then
    curl $ART_URL -o /tmp/art
    ICON=/tmp/art
fi

source $HOME/.config/scripts/lib/notify.sh

# notify "$SONG" "$STATUS" "true"
