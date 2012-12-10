bindkey -e

# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history

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
[ %{${color2}%}%~ ]$(__git_ps1 " (%s)")
%#%{${color0}%} '


# alias
alias ls='ls -h --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'

alias r='rails'

# env
export EDITOR=emacsclient
export VISUAL=emacsclient

