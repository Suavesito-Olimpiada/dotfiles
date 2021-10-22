#!/usr/bin/env bash

TYPE=latex

if [[ -n "$2" ]]
then
    TYPE="$2"
fi

if [[ -n "$1" ]]
then
    pandoc  -t "$TYPE"                           \
            --filter pandoc-crossref             \
            --filter pandoc-pyplot               \
            --filter filter_pandoc_run_py        \
            "$1" -o "$(echo "$1" | sed -E 's/(.+)\.md$/\1.pdf/')"
            # --filter ~/.pandoc/dot2tex-filter.py \
fi
