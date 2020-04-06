#!/bin/env sh

# WORD='ReAlLy_LoNg_WoRd_ThAt_NoOnE_WiLl_NeVeR_EvEr_UsE_At_AnY_TiMe'

# MPV_STAT=$(pgrep mpv)
# MPR_STAT=$(playerctl -l)
# MPC_STAT=$(mpc |& grep paused | sed 's/\[\(paused\)\]\(.*\)/\1/')

# if [[ -z $MPV_STAT ]]
# then
#     if [[ -z $MPR_STAT ]] || [[ -z $MPC_STAT ]]
#     then
#         case $@ in
#             "next")
#                 mpc next &> /dev/null
#                 ;;
#             "prev")
#                 mpc prev &> /dev/null
#                 ;;
#             "play")
#                 mpc play &> /dev/null
#                 ;;
#             "pause")
#                 mpc pause &> /dev/null
#                 ;;
#             "toggle")
#                 mpc toggle &> /dev/null
#                 ;;
#             *)
#                 ;;
#         esac
#     else

MPD=$(playerctl -l | grep mpd)
MPV=$(playerctl -l | grep mpv)
PLM=$(playerctl -l | grep plasma)
MSC=''

[[ -z $MPD ]] || MSC=$MPD
[[ -z $PLM ]] || MSC=$PLM
[[ -z $MPV ]] || MSC=$MPV

case $@ in
    "next")
        playerctl --player=$MSC next
        ;;
    "prev")
        playerctl --player=$MSC previous
        ;;
    "play")
        playerctl --player=$MSC play
        ;;
    "pause")
        playerctl --player=$MSC pause
        ;;
    "toggle")
        playerctl --player=$MSC play-pause
        ;;
    *)
        ;;
esac
#     fi
# else
#     mpc pause &> /dev/null
#     playerctl pause &> /dev/null
#     echo $MPC_STAT
#     case $@ in
#         "next")
#             xdotool search --pid $MPV_STAT $WORD key --clearmodifiers Right
#             ;;
#         "prev")
#             xdotool search --pid $MPV_STAT $WORD key --clearmodifiers Left
#             ;;
#         "play")
#             xdotool search --pid $MPV_STAT $WORD key --clearmodifiers p
#             ;;
#         "pause")
#             xdotool search --pid $MPV_STAT $WORD key --clearmodifiers p
#             ;;
#         "toggle")
#             xdotool search --pid $MPV_STAT $WORD key --clearmodifiers p
#             ;;
#         *)
#             ;;
#     esac
# fi
