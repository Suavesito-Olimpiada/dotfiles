#!/bin/env sh

STATUS=`pgrep jupyter`

function echod ()
{
    if [[ -z $DMENU ]]
    then
        echo $@
    else
        echo $@ | sed 's/ /\n/g' | dmenu -i -l 5
    fi
}

if [[ -z $@ ]]
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
        echod "Closed"
    else
        case $@ in
            "status"|"stat")
                echod "Running"
                ;;
            "url")
                echod $(jupyter notebook list | sed -n '2,$s/\(.*\)\(::.*\)/\1/p')
                ;;
            "dir"|"directory")
                echod $(jupyter notebook list | sed -n '2,$s/\(.*\)\(::\)\(.*\)/\3/p')
                ;;
            *)
                echod 'Not command found'
                ;;
        esac
    fi
fi
