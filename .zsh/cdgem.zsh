function cdgem() {
    local gem_name=$(bundle list | sed -n 's/^ *\* *//p' | fzf | cut -d \  -f 1)

    if [[ -n $gem_name ]]; then
        local dir="$(bundle info ${gem_name} --path)"
        cd "$dir"
    fi
}
