function select-history() {
    BUFFER=$(history -n 1 | fzf --tac)
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N select-history
bindkey '^r' select-history
