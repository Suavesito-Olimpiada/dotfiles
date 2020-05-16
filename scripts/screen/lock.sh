#!/usr/bin/bash
# Need to be bash and not env bash to work. :v

[[ -z "$(pgrep i3lock)" ]] || exit

B='#00000000'  # blank
C='#ffffff22'  # clear ish
K='#ff4400ff'  # keys
D='#66aa00dd'  # default
T='#eeeeeedd'  # text
W='#aa0066dd'  # wrong
V='#0088aadd'  # verifying

function lock() {
    i3lock \
    --pass-media-keys \
    \
    --insidevercolor=$B   \
    --ringvercolor=$V     \
    \
    --insidewrongcolor=$B \
    --ringwrongcolor=$W   \
    \
    --insidecolor=$B      \
    --ringcolor=$D        \
    --linecolor=$B        \
    --separatorcolor=$D   \
    \
    --verifcolor=$V       \
    --wrongcolor=$W       \
    --timecolor=$T        \
    --datecolor=$T        \
    --keyhlcolor=$K       \
    --bshlcolor=$W        \
    \
    --color=00000033      \
    --clock               \
    --indicator           \
    --timestr="%H:%M:%S"  \
    --datestr="%A, %m %Y" \
    \
    --veriftext=Verifying... \
    --wrongtext=Wrong! \
    --noinputtext=... \
    --timesize=30 \
    --time-font="Hack Nerd Font Mono"
    # --screen 1            \
    # --blur 5              \
}


if [[ -n $1 ]]
then
    for (( i=$2 ; i>0 ; --i )); do echo "Tu pantalla se apagará en $i"; sleep 1; done | dzen2 -x 660 -y 510 -w 600 -h 60 -fn "xos4 Terminus:size=30" -e 'button1=exec:killall lock_screen.sh'
fi

lock
