export LANG=ja_JP.utf8
export LC_ALL=ja_JP.utf8

# -------------------------------------------------------------
# environment

# history
export HISTCONTROL="ignoreboth"
export HISTFILESIZE="4096"
export HISTSIZE="4096"

# -------------------------------------------------------------
# shell option

# interaction mode
if [[ "${PS1}" ]] ; then
    shopt -s cmdhist
    shopt -s histappend
    shopt -s checkwinsize
    shopt -s no_empty_cmd_completion
    shopt -u histappend
    shopt -q -s cdspell
    shopt -q -s checkwinsize
    shopt -s cmdhist
fi

# -------------------------------------------------------------
# terminal

# prompt
function custom_prompt_command {
    typeset _Retv=$?
    typeset _PromptColor=""
    if [[ ${_Retv} -eq 0 ]] ; then
        _PromptColor=$BASH_PROMPT_OK
    else 
        _PromptColor=$BASH_PROMPT_NG
    fi
  export PS1="\[${_PromptColor}\]
[ \u@\H | Time: $(/bin/date '+%Y-%m-%d %H:%M:%S') | Retv: \$? ]
[ \w ]$(__git_ps1 " (%s)")
# \[\e[0m\]"
}

PROMPT_COMMAND="custom_prompt_command"

case ${TERM} in
    "xterm")
        stty -ixon -ixoff
        eval $(dircolors ~/.dir_colors)
        alias ls='ls --classify --color=auto --show-control-char'
        ;;
    "emacs")
        export LS_COLORS='no=00:fi=00:di=35:ln=36:ex=32'
        export TERM_LENGTH='90'
        alias ls='ls --classify --color --show-control-char -C'
        ;;
esac

# -------------------------------------------------------------
# complete

complete -d cd

# -------------------------------------------------------------
# alias

# for interactive operation
#  alias rm='rm -i'
#  alias cp='cp -i'
#  alias mv='mv -i'

# alias for misc
  alias grep='grep --color'

# alias for some shortcuts for different directory listings
  alias ls='ls -h --color=always --show-control-chars'
  alias ll='ls -l'
  alias la='ls -A'
  alias lla='ls -lA'
  alias l='ls -CF'

# -------------------------------------------------------------
# change directory
if [[ "$__PWD__" != "" ]] ; then
    cd "$(echo $__PWD__ | nkf -s)"
else
    cd "$(pwd)"
fi

export INST_DIR=$inst_dir


alias gstatus='git status | lv -c'
alias glgraph='git log --graph --all --decorate --oneline'
source ~/.git-completion.sh

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


case ${OSTYPE} in
    "cygwin")
        alias open='cygstart'
        ;;
esac
