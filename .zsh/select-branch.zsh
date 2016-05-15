function select-branch() {
    local selected=$(git branch -a | peco --prompt "BRANCH>" | sed -e "s/^[ \*]*//g")
    BUFFER=$BUFFER$selected
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N select-branch
bindkey '^b' select-branch
