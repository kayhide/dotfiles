function cdrepo() {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER" --prompt "REPO>")
    if [ -n "$selected_dir" ]; then
        cd $selected_dir
    fi
}
