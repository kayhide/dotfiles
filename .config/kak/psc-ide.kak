
define-command psc-ide-add-import-from -docstring "add import from" -params 3 %{
    evaluate-commands -draft -no-hooks -save-regs 'iqm|' %{
        set-register i %arg{1}
        set-register q %arg{2}
        set-register m %arg{3}
        set-register '|' %{
            identifier="$kak_reg_i"
            qualifier="$kak_reg_q"
            module="$kak_reg_m"
            echo psc-ide-cli "$kak_buffile" "$identifier" "$qualifier" "$module" >> /home/kayhide/tmp/psc-ide.log
            dst="$(mktemp "${TMPDIR:-/tmp}"/kak-psc-ide-XXXXXX)"
            psc-ide-cli "$kak_buffile" "$identifier" "$qualifier" "$module" > "$dst"
            code="$?"
            if (( $code == 1 )); then
                printf 'eval -client %s %%{ fail add-import returned an error %s }\n' "$kak_client" "$?" | kak -p "$kak_session"
                cat
            else
                cat >/dev/null
                cat "$dst"
            fi
            rm -f "$dst"
        }
        execute-keys '%|<ret>'
    }
}


define-command psc-ide-add-import -docstring "add import" %{
    evaluate-commands -draft %{
        execute-keys '<a-i><a-w>s[a-zA-Z0-9_\.]+<ret>'
        evaluate-commands %sh{
            identifier="${kak_selection##*.}"
            qualifier="$(echo "$kak_selection" |sed -n "s/\.[^\.]\+$//p")"
            echo $1 >> /home/kayhide/tmp/psc-ide.log
            echo psc-ide-cli "$kak_buffile" "$identifier" "$qualifier" >> /home/kayhide/tmp/psc-ide.log
            res="$(psc-ide-cli "$kak_buffile" "$identifier" "$qualifier")"
            code="$?"
            if (( $code == 1 )); then
                printf 'eval -client %s %%{ fail add-import returned an error %s }\n' "$kak_client" "$?" | kak -p "$kak_session"
                printf 'fail add-import returned an error %s\n' "$code"
            elif (( $code == 2 )); then
                printf "menu"
                for x in $res; do
                    printf " %s %s" "$x" %{ psc-ide-add-import-from "$identifier" "$qualifier" "$x" }
                done
            else
                printf "%s '%s' '%s' '%s'" psc-ide-add-import-from "$identifier" "$qualifier" "" >> /home/kayhide/tmp/psc-ide.log
                printf "%s '%s' '%s' '%s'" psc-ide-add-import-from "$identifier" "$qualifier" ""
            fi
        }
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


