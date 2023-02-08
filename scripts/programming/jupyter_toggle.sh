#!/usr/bin/env bash

STATUS=$(pgrep jupyter-lab)
if [[ -z $STATUS ]]
then
    julia --startup-file=no --history=no --project=@Conda -e 'using Conda; Conda.runconda(`run jupyter lab`, :jupyterlab); exit()'
else
    kill -15 $STATUS
fi

exit 0

DMENUR="$HOME/.config/scripts/lib/dmenu.sh"
STATUS=$(pgrep jupyter)

function echod ()
{
    if [[ -z $2 ]]
    then
        echo "$1"
    else
        echo "$1" | $DMENUR -i -l 5
    fi
}

if [[ $1 = "dmenu" ]]
then
    DMENU=1
    shift 1
fi


if [[ -z $1 ]]
then
    if [[ -z $STATUS ]]
    then
        jupyter lab &> /dev/null &
    else
        kill -9 $(pgrep jupyter)
    fi
else
    if [[ -z $STATUS ]]
    then
        echod "Closed" $DMENU
    else
        case $1 in
            "status"|"stat")
                echod "Running" $DMENU
                ;;
            "url")
                echod "$(jupyter lab list | sed -n '2,$p' | awk '{printf "%s\n", $1}')" $DMENU
                ;;
            "dir"|"directory")
                echod "$(jupyter lab list | sed -n '2,$p' | awk '{printf "%s\n", $3}')" $DMENU
                ;;
            *)
                echod 'Not command found'
                ;;
        esac
    fi
fi
