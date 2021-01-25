function cdrepo() {
    local dir="$(ghq list --full-path | fzf)"
    if [[ -n $dir ]]; then
        cd "$dir"
    fi
}
