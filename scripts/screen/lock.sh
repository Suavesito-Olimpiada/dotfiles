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
    --pass-media-keys   \
    --pass-volume-keys  \
    --pass-screen-keys  \
    \
    --insidever-color=$B   \
    --ringver-color=$V     \
    \
    --insidewrong-color=$B \
    --ringwrong-color=$W   \
    \
    --inside-color=$B      \
    --ring-color=$D        \
    --line-color=$B        \
    --separator-color=$D   \
    \
    --verif-color=$V       \
    --wrong-color=$W       \
    --time-color=$T        \
    --date-color=$T        \
    --keyhl-color=$K       \
    --bshl-color=$W        \
    \
    --color=00000033      \
    --clock               \
    --indicator           \
    --time-str="%H:%M:%S"  \
    --date-str="%A, %m %Y" \
    \
    --verif-text=Verifying... \
    --wrong-text=Wrong! \
    --noinput-text=... \
    --time-size=30 \
    --time-font="Hack Nerd Font Mono"
    # --screen 1            \
    # --blur 5              \
}


if [[ -n $1 ]]
then
    for (( i=$2 ; i>0 ; --i )); do echo "Tu pantalla se apagará en $i"; sleep 1; done | dzen2 -x 660 -y 510 -w 600 -h 60 -fn "xos4 Terminus:size=30" -e 'button1=exec:killall lock.sh'
fi

lock
