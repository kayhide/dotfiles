declare-option str clipboard_copy_command "xsel --clipboard --input"
declare-option str clipboard_paste_command "xsel --clipboard --output"

evaluate-commands %sh{
    case $(uname -s) in
    	Darwin)
    		printf "%s" "set-option global clipboard_copy_command pbcopy"
    		echo
    		printf "%s" "set-option global clipboard_paste_command pbpaste"
    		echo
    		;;
    esac
}

hook global NormalKey y|d|c %{
    nop %sh{
        printf "%s" "$kak_main_reg_dquote" | $kak_opt_clipboard_copy_command
    }
}

define-command pull-from-clipboard %{
    evaluate-commands %sh{
        printf "set-register '%s' %%=" '"'
        $kak_opt_clipboard_paste_command | sed "s/=/==/g"
        printf "="
    }
}
map global normal p ': pull-from-clipboard<ret>p'
map global normal P ': pull-from-clipboard<ret>P'
map global normal R ': pull-from-clipboard<ret>R'
