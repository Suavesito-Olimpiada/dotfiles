#!/bin/bash
cat ~/.config/pmenu/commandlist | pmenu | ${bash:-"/bin/sh"}
