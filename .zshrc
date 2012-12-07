# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mikagami/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


autoload colors
colors

# git completion
autoload bashcompinit
bashcompinit
source ~/.git-completion.sh

setopt prompt_subst

color0=$'\e[0m'
color1=$'\e[38;5;46m'
color2=$'\e[38;5;2m'
PROMPT='${color1}[ %n@%m | %D{%Y-%m-%d %H:%M:%S} | Retv: %? ]
[ ${color2}%~ ]$(__git_ps1 " (%s)")
%#${color0} '


#PS1="${color1}[%n@%m$(__git_ps1 " (%s)")]\# "

alias ls='ls -h --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -lA'
