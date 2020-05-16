#!/usr/bin/env bash

TMP=$(mktemp)

echo $TMP

cat - &> $TMP

$@ $TMP

rm $TMP
