bindkey -e

# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history

setopt auto_pushd
setopt pushd_ignore_dups

# completion
zstyle :compinstall filename '/home/mikagami/.zshrc'

autoload -Uz compinit
compinit

# colors
autoload colors
colors

# git completion
autoload bashcompinit
bashcompinit
source ~/.git-completion.sh


# prompt
setopt prompt_subst

color0=$'\e[0m'
color1=$'\e[38;5;46m'
color2=$'\e[38;5;2m'
PROMPT=$'%{${color1}%}[ %n@%m | %D{%Y-%m-%d %H:%M:%S} | Retv: %? ]
%{${color2}%}[ %~ ]$(__git_ps1 " (%s)")
%#%{${color0}%} '


# alias
case $(uname) in
'Darwin')
	alias ls='ls -h -G'
;;
*)
	alias ls='ls -h --color=auto'
;;
esac

alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'

alias r='rails'

alias g='git'
alias gstatus='git status | lv -c'
alias glgraph='git log --graph --all --decorate --oneline'

alias -g G='| grep'
alias -g L='| lv -c'

# env
case $(uname) in
'Darwin')
	export EDITOR='/usr/local/bin/emacsclient -t'
;;
*)
	export EDITOR='emacsclient -t'
;;
esac

export VISUAL=$EDITOR
export PATH="./bin:$HOME/bin:$PATH"

export PGDATA='/usr/local/var/postgres'
export PGHOST='localhost'
export PGLOG='/usr/local/var/postgres/server.log'

alias pg_start="pg_ctl start -l $PGLOG"
alias pg_status="pg_ctl status"
alias pg_stop="pg_ctl stop -m s"


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
