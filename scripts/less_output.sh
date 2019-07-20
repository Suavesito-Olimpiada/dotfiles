#!/bin/bash
Search=`echo|dmenu -p "Less Output Pipe: "`
st -e bash -ci "$Search |& less -dgKsSR"
