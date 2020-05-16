function man-find() {
    f=$(fd . $MANPATH/man${1:-1} -t f -x echo {/.} | fzf) && man $f
}

function fman() {
    man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
}
