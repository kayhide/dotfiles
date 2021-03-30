declare-option str clipboard_copy_command "xsel --clipboard --input"
declare-option str clipboard_paste_command "xsel --clipboard --output"

evaluate-commands %sh{
    case $(uname -s) in
    	Darwin)
    		printf "%s" "set-option global clipboard_copy_command pbcopy"
    		echo
    		printf "%s" "set-option global clipboard_copy_command pbcopy"
    		echo
    		;;
    esac
}

hook global NormalKey y|d|c %{
    nop %sh{
        printf "%s" "$kak_main_reg_dquote" | $kak_opt_clipboard_copy_command
    }
}

define-command pull-from-xsel %{
    evaluate-commands %sh{
        printf "set-register '%s' " '"'
        echo -n '%='
        $kak_opt_clipboard_paste_command | sed "s/=/==/g"
        echo -n '='
    }
}
map global normal p ': pull-from-xsel<ret>p'
map global normal P ': pull-from-xsel<ret>P'
map global normal R ': pull-from-xsel<ret>R'

