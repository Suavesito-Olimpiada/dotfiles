#!/bin/bash
Search=`echo|dmenu -p "Less Output Pipe: "`
termite -e "bash -ci \"$Search |& less -dgKsSR\""
