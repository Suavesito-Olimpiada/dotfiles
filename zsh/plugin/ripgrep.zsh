function fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    rg --files-with-matches --no-messages "$1" | lscolors | fzf --print0 --preview "bat --color=always --number {} | rg --color=always --heading  --context 5 \"$1\""
}

function fe() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    fif "$1" | xargs -0 -ro vim
}
