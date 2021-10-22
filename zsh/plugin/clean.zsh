function clean_reset() {
    tput reset
}

zle -N clean_reset          # Declare fzf_music as widget
bindkey "^[l" clean_reset   # Add proper keybind
