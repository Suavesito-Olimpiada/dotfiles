function fzf_music() {
    music_mpc.sh fzf
}
zle -N fzf_music        # Declare fzf_music as widget
bindkey "^Y" fzf_music  # Add proper keybind
