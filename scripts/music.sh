#!/bin/env sh

WORD='ReAlLy_LoNg_WoRd_ThAt_NoOnE_WiLl_NeVeR_EvEr_UsE_At_AnY_TiMe'

MPV_STAT=$(pgrep mpv)
SPO_STAT=$(pgrep spotify)
MPC_STAT=$(mpc |& grep paused | sed 's/\[\(paused\)\]\(.*\)/\1/')

if [[ -z $MPV_STAT ]]
then
    if [[ -z $SPO_STAT ]] || [[ -z $MPC_STAT ]]
    then
        case $@ in
            "next")
                mpc next &> /dev/null
                ;;
            "prev")
                mpc prev &> /dev/null
                ;;
            "play")
                mpc play &> /dev/null
                ;;
            "pause")
                mpc pause &> /dev/null
                ;;
            "toggle")
                mpc toggle &> /dev/null
                ;;
            *)
                ;;
        esac
    else
        case $@ in
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
            *)
                ;;
        esac
    fi
else
    mpc pause &> /dev/null
    playerctl pause &> /dev/null
    echo $MPC_STAT
    case $@ in
        "next")
            xdotool search --pid $MPV_STAT $WORD key --clearmodifiers Right
            ;;
        "prev")
            xdotool search --pid $MPV_STAT $WORD key --clearmodifiers Left
            ;;
        "play")
            xdotool search --pid $MPV_STAT $WORD key --clearmodifiers p
            ;;
        "pause")
            xdotool search --pid $MPV_STAT $WORD key --clearmodifiers p
            ;;
        "toggle")
            xdotool search --pid $MPV_STAT $WORD key --clearmodifiers p
            ;;
        *)
            ;;
    esac
fi
