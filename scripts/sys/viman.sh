#!/usr/bin/env bash

export MANPAGER='env MAN_PN=1 vim -M +MANPAGER -'
man $@
export MANPAGER='less -R'
