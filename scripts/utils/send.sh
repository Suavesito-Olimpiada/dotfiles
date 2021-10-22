#!/usr/bin/env bash

curl -F "file=@$1" 0x0.st | tee cosa
xclip -i cosa
rm cosa
