if [[ -n ${SAVE_LAST_PWD+x} ]]; then
    __save_last_pwd() {
        pwd > "$SAVE_LAST_PWD"
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd __save_last_pwd

    if [[ -f $SAVE_LAST_PWD ]]; then
        cd "$(cat "$SAVE_LAST_PWD")" 2> /dev/null || true
    fi
fi
