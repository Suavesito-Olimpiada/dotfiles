#!/usr/bin/env sh

function __gentags()
{
    for i in "$@"
    do
        echo +"\"$i\""
    done
}

function __focus()
{

    PROJECT=$(watson projects | dmenu -l 10 -p "Project: ")

    if [[ -z $PROJECT ]]
    then
        return 42
    fi

    PTAGS=$(watson tags | dmenu -l 10 -p "Tags: ")

    TAGS=$(eval __gentags $PTAGS)

    watson start "$PROJECT" $TAGS

    focus -p 10 -d 0 -t 'To work!' -b 'You can do it!'

    potato -s &!

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
