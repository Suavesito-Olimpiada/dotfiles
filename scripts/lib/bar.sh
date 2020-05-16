#!/usr/bin/env bash

source "$HOME/.config/scripts/lib/color.sh"

if [[ -z $1 ]]
then
    printf "Must at least give a percentage.\n"
    exit
fi

PERCENT=${1:-}
LENGTH=${2:-10}
BARSTYLE=${3:-solid}
BARCOLOR=${4:-}

if [[ $LENGTH = 0 ]]
then
    printf "\n"
    exit
fi

BARSTYLES=(solid line braille)

LVLS=( "█" "▆" "▅" "▃" "▁" "░" "░" "░" )
LVLL=( "━" "╾" "╾" "╾" "╾" "─" "" "─" ) # +
LVLB=( "⣿" "⡷" "⡇" "⠆" "⠂" "·" "·" "·" )

declare -a LVL
case $BARSTYLE in
    "solid")
        LVL=( ${LVLS[@]} )
        ;;
    "line")
        LVL=( ${LVLL[@]} )
        ;;
    "braille")
        LVL=( ${LVLB[@]} )
        ;;
esac

function m() {
    printf "%s\n" "$@" | bc -l
}

function floor() {
    awk "BEGIN { printf \"%d\n\", int($1); }";
}

function ceil() {
    awk "BEGIN { printf \"%d\n\", int($1+1); }";
}

LB=$( m "$LENGTH/100" )
PR=$( m "$PERCENT*$LB" )
LL=$( floor $PR )
LR=$(( LENGTH - (LL+2) ))
LM=$( floor $(m "($PR-$LL)*5") )

LBAR=$(seq -s ${LVL[0]} 0 $LL | sed 's/[0-9]//g')
RBAR=$(seq -s ${LVL[7]} 0 $LR | sed 's/[0-9]//g')
(( $(ceil $PERCENT) >= 100 )) || MIDC=${LVL[$(( (5-LM) % 6 ))]}
(( $(ceil $PERCENT) >= 100 )) || ENDC=${LVL[6]}

BAR="$LBAR$MIDC$ENDC$RBAR"

if [[ -n $BARCOLOR ]]
then
    printf "${COLORS[$BARCOLOR]}%s${COLORS[NC]}\n" "$BAR"
else
    printf "%s\n" "$BAR"
fi
