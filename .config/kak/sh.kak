define-command -override -hidden indent-as-preceding -params 2 %{
    execute-keys -draft -save-regs '^' <space> K <a-k> %arg{2} <ret> Z <a-/> %arg{1} <ret> <a-z> a <a-&>
}

define-command -override -hidden indent-after -params 1 %{
    execute-keys -draft <space> k x <a-k> %arg{1} <ret> J <a-&> <semicolon> <a-gt>
}

define-command -override -hidden deindent-after -params 1 %{
    execute-keys -draft <space> k x <a-k> %arg{1} <ret> J <a-&> <semicolon> <a-lt>
}

define-command -override -hidden sh-indent-on-new-line %[
    evaluate-commands -draft -itersel %[
        # preserve previous line indent
        try %{ execute-keys -draft <semicolon> K <a-&> }
        # filter previous line
        try %{ execute-keys -draft k : sh-trim-indent <ret> }

        # Indent loop syntax, e.g.:
        # for foo in bar; do
        #       things
        # done
        #
        # or:
        #
        # while foo; do
        #       things
        # done
        #
        # or equivalently:
        #
        # while foo
        # do
        #       things
        # done
        #
        # indent done as preceding do
        try %{ indent-as-preceding \bdo$ \bdone$ }
        # indent after do
        try %{ indent-after \bdo$ }

        # Indent if/then/else syntax, e.g.:
        # if [ $foo = $bar ]; then
        #       things
        # else
        #       other_things
        # fi
        #
        # or equivalently:
        # if [ $foo = $bar ]
        # then
        #       things
        # else
        #       other_things
        # fi
        #
        # indent else/fi as preceding if
        try %{ indent-as-preceding ^\s*if\b \belse|fi$ }
        # indent after then/else
        try %{ indent-after \bthen|else$ }

        # Indent case syntax, e.g.:
        # case "$foo" in
        #       bar) thing1;;
        #       baz)
        #               things
        #               ;;
        #       *)
        #               default_things
        #               ;;
        # esac
        #
        # or equivalently:
        # case "$foo"
        # in
        #       bar) thing1;;
        # esac
        #
        # indent esac as preceding case
        try %{ indent-as-preceding ^\s*case\b \besac$ }
        # indent after in
        try %{ indent-after \bin$ }
        # indent after )
        try %{ indent-after ^\s*\(?[^(]+[^)]\)$ }
        # deindent after ;;
        try %{ deindent-after ^\s*\;\;$ }

        # Indent compound commands as logical blocks, e.g.:
        # {
        #       thing1
        #       thing2
        # }
        #
        # or in a function definition:
        # foo () {
        #       thing1
        #       thing2
        # }
        #
        # We don't handle () delimited compond commands - these are technically very
        # similar, but the use cases are quite different and much less common.
        #
        # Note that in this context the '{' and '}' characters are reserved
        # words, and hence must be surrounded by a token separator - typically
        # white space (including a newline), though technically it can also be
        # ';'. Only vertical white space makes sense in this context, though,
        # since the syntax denotes a logical block, not a simple compound command.
        try %= execute-keys -draft <space> k <a-x> <a-k> (\s|^)\{$ <ret> j <a-gt> =
        # deindent closing }
        try %= execute-keys -draft <space> k <a-x> <a-k> ^\s*\}$ <ret> <a-lt> j K <a-&> =
        # deindent closing } when after cursor
        try %= execute-keys -draft <a-x> <a-k> ^\h*\} <ret> gh / \} <ret> m <a-S> 1<a-&> =

    ]
]
