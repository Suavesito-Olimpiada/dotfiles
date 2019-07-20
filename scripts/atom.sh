#!/usr/bin/bash

# Used for packege julia-client
# allow using remote session with tmux

eval $(ssh-agent -s)
/home/jose/Apps/precompile/atom-1.37.0-amd64/atom
kill $SSH_AGENT_PID
