function select-history() {
    BUFFER=$(history -n 1 | tac | peco --prompt "HISTORY>" --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N select-history
bindkey '^r' select-history
