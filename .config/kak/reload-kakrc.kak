# Reload kakrc and .kak when saving.
# Adds -override to definitions (unless they seem to be python defs!)
# Removes shared highlighting
# Idea: remove all grouped hooks?

define-command resource -params 1 %{
    evaluate-commands -draft -no-hooks -save-regs 'x' %{
        set-register 'x' %sh{ mktemp --tmpdir "kak-source-XXXXXX" }
        execute-keys '%'
        nop %sh{
            echo "Reloading $kak_buffile" >&2
            echo "$kak_selection" \
            | grep -v '^ *#' \
            | grep -v '^require-module' \
            | grep -v '^source' \
            | grep -v '^plug' \
            | sed 's/^def \([^:]*\)$/def -override \1/' \
            | sed 's/^define-command /define-command -override /' \
            | sed 's/^provide-module /define-command -hidden -override /' \
            | tee "$kak_reg_x" \
            >&2
        }
        source %reg{x}
        nop %sh{ rm -f "$kak_reg_x" }
        eval -client %val{client} "echo ""Reloaded %val{buffile}"""
    }
}

rmhooks global reload-kak
hook -group reload-kak global BufWritePost (.*kakrc|.*\.kak) %{
    resource %val{hook_param}
}
