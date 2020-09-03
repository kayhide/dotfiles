
define-command psc-ide-add-import -docstring "add import" -params 0.. %{
    execute-keys '<a-i><a-w>'
    evaluate-commands %sh{
        identifier="${kak_selection##*.}"
        qualifier="$(echo "$kak_selection" |sed -n "s/\.[^\.]\+$//p")"
        echo $1 >> /home/kayhide/tmp/psc-ide.log
        echo psc-ide-cli "$kak_buffile" "$identifier" "$qualifier" "$1" >> /home/kayhide/tmp/psc-ide.log
        res="$(psc-ide-cli "$kak_buffile" "$identifier" "$qualifier" "$1")"
            code="$?"
        if [[ $code != 0 ]]; then
            printf 'eval -client %s %%{ fail add-import returned an error %s }\n' "$kak_client" "$?" | kak -p "$kak_session"
            printf 'fail add-import returned an error %s\n' "$code"
        elif [[ -z $res ]]; then
            printf "%s\n" "info OK"
        else
            printf "menu"
            for x in $res; do
                printf " %s %s" "$x" %{ psc-ide-add-import "$x" }
            done
        fi
    }

#    evaluate-commands -draft -no-hooks -save-regs '|' %{
#        set-register '|' %{
#            src="$(mktemp "${TMPDIR:-/tmp}"/kak-psc-ide-XXXXXX)"
#            dst="$(mktemp "${TMPDIR:-/tmp}"/kak-psc-ide-XXXXXX)"
#
#            cat > "$src"
#            eval "$kak_opt_formatcmd" < "$src" > "$dst"
#            if [ $? -eq 0 ]; then
#                cat "$dst"
#            else
#                printf 'eval -client %s %%{ fail formatter returned an error %s }\n' "$kak_client" "$?" | kak -p "$kak_session"
#                cat "$src"
#            fi
#            rm -f "$src" "$dst"
#        }
#        execute-keys '|<ret>'
#    }
}


