#!/bin/env sh

ROOT=`pwd | sed 's/\(.*\)\(\/[a-zA-Z]*$\)/\1/'`

PROGRAM="build/program"
DATADIR="test/data"
RESULTDIR="test/results"

# FOR EVERY CASE (example)
#for ((i=1; i<4; ++i)) do
#    date
#    echo "$ROOT/$PROGRAM -u -m $ROOT/$DATADIR/U$i.bin -v $ROOT/$DATADIR/c$i.bin &> $ROOT/$RESULTDIR/Uc$i.txt"
#    "$ROOT/$PROGRAM" -u -m "$ROOT/$DATADIR/U$i.bin" -v "$ROOT/$DATADIR/c$i.bin" &> "$ROOT/$RESULTDIR/Uc$i.txt"
#done

exit 0
