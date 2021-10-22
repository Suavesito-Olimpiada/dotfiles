#!/usr/bin/env bash

while read line
do
    ACOT=$(echo $line | sed -E 's|(.+)/(.+)[ ]*(.+)|\1|')
    REPO=$(echo $line | sed -E 's|(.+)/(.+)[ ]*(.+)|\2|')
    STAT=$(echo $line | sed -E 's|(.+)/(.+)[ ]*(.+)|\3|')
    mkdir -p $ACOT/$STAT
    cd $ACOT/$STAT
    git clone "https://github.com/$ACOT/$REPO" # I just have from here
    cd ~/.vim/pack/
    echo $ACOT - $REPO ($STAT)
done < ~/.vim/pack/vimgitrepo
