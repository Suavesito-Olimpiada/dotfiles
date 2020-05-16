#!/usr/bin/bash
# Need to be bash and not env bash to work. :v

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#ff00ffcc'  # default
T='#ee00eeee'  # text
W='#880000bb'  # wrong
V='#bb00bbbb'  # verifying

function lock() {
    i3lock \
    --insidevercolor=$C   \
    --ringvercolor=$V     \
    \
    --insidewrongcolor=$C \
    --ringwrongcolor=$W   \
    \
    --insidecolor=$B      \
    --ringcolor=$D        \
    --linecolor=$B        \
    --separatorcolor=$D   \
    \
    --verifcolor=$T       \
    --wrongcolor=$T       \
    --timecolor=$T        \
    --datecolor=$T        \
    --layoutcolor=$T      \
    --keyhlcolor=$W       \
    --bshlcolor=$W        \
    \
    --color=00000033      \
    --clock               \
    --indicator           \
    --timestr="%H:%M:%S"  \
    --datestr="%A, %m %Y" \
    --keylayout 2         \
    \
    --veriftext=Verifying... \
    --wrongtext=Wrong! \
    --noinputtext=... \
    --textsize=20 \
    --timefont="Hack Nerd Font Mono"
    # --screen 1            \
    # --blur 5
}


if [[ -z $@ ]]
then
    for (( i=5 ; i>0 ; --i )); do echo "Tu pantalla se apagará en $i."; sleep 1; done | dzen2 -x 660 -y 490 -w 600 -h 100 -fn "xos4 Terminus:size=30" -e 'button1=exec:killall lock_screen.sh'
fi

export XSECURELOCK_PASSWORD_PROMPT=disco
xsecurelock
