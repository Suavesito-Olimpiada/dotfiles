#!/usr/bin/env bash

DMENU="$HOME/.config/scripts/lib/dmenu.sh"

function __gentags()
{
    for i in "$@"
    do
        echo +"\"$i\""
    done
}

function __focus()
{

    PROJECT=$(watson projects | $DMENU -l 10 -p "Project: ")

    if [[ -z $PROJECT ]]
    then
        return 42
    fi

    PTAGS=$(watson tags | $DMENU -i -l 10 -p "Tags: ")

    TAGS=$(eval __gentags $PTAGS)

    watson start "$PROJECT" $TAGS

    focus -p 15 -d 0 -t 'To work!' -b 'You can do it!'

    potato -w 50 -b 10 -s &!

}

function __unfocus()
{
    killall focus
    killall potato
    watson stop
}

WST="$HOME/.config/scripts/work/wst"
if [[ $(cat $WST) == 0 ]]
then
    __focus
    if [[ $? == 42 ]]
    then
        exit -1
    fi
    echo 1 > $WST
else
    __unfocus
    echo 0 > $WST
fi
