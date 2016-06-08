function cdgem() {
    local gem_name=$(bundle list | sed -e 's/^ *\* *//g' | peco --prompt "GEM>" | cut -d \  -f 1)
    if [ -n "$gem_name" ]; then
        local gem_dir=$(bundle show ${gem_name})
        cd $gem_dir
    fi
}
