#!/usr/bin/env bash

ROOT=$(pwd | sed 's/\(.*\)\(\/[a-zA-Z]*$\)/\1/')

PROGRAM="build/program"
INDIR="test/in"
OUTDIR="test/out"

# FOR EVERY CASE (example)
#for ((i=1; i<4; ++i)) do
#    date
#    echo "$ROOT/$PROGRAM -u -m $ROOT/$INDIR/U$i.bin -v $ROOT/$INDIR/c$i.bin &> $ROOT/$OUTDIR/Uc$i.txt"
#    "$ROOT/$PROGRAM" -u -m "$ROOT/$INDIR/U$i.bin" -v "$ROOT/$INDIR/c$i.bin" &> "$ROOT/$OUTDIR/Uc$i.txt"
#done

exit 0
