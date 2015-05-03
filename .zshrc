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

setopt auto_cd
cdpath=(.. ~)

# colors
autoload colors
colors

# completion
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fpath=($(brew --prefix)/share/zsh-completions $fpath)
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# prompt
setopt prompt_subst

if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
    source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
fi

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
alias tree='tree -N'

alias g='git'
alias gstatus='git status | lv -c'
alias glgraph='git log --graph --all --decorate --oneline'
alias gcheckout='git checkout'
alias gbranch='git branch'
alias gmerge='git merge'

alias gflow='git flow'
alias gffstart='git flow feature start'
alias gfffinish='git flow feature finish'

alias vf='vim +VimFiler'

alias -g G='| grep'
alias -g L='| lv -c'
alias -g X='| xargs'
alias -g XG='| xargs grep'
alias -g PBCOPY='| pbcopy'

alias -g r='rails'
alias -g sr='spring rails'
alias -g RED='RAILS_ENV=development'
alias -g RET='RAILS_ENV=test'
alias -g REP='RAILS_ENV=production'

alias rdmigrate='rake db:migrate'
alias rdstatus='rake db:migrate:status'
alias rdrollback='rake db:rollback'

alias powopen='powder open'
alias powlink='powder link'
alias powunlink='powder unlink'
alias powstop='powder stop'
alias powstart='powder start'
alias powrestart='powder stop; powder start'

alias -g mm='middleman'

alias be='bundle exec'

alias tcopy='tmux save-buffer - | pbcopy'

# env
export EDITOR='vim'
export VISUAL=$EDITOR

export PGDATA='/usr/local/var/postgres/9.3'
export PGHOST='localhost'
export PGLOG='/usr/local/var/postgres/server.log'
export PGUSER='postgres'

alias pg_start="pg_ctl start -l $PGLOG"
alias pg_status="pg_ctl status"
alias pg_stop="pg_ctl stop -m s"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which hub > /dev/null; then eval "$(hub alias -s)"; fi

export PATH="$HOME/.cabal/bin:$PATH"
export PATH="/usr/texbin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="./bin:$HOME/bin:$PATH"

export ANDROID_HOME="/usr/local/opt/android-sdk"


function cdgem() {
    local gem_name=$(bundle list | sed -e 's/^ *\* *//g' | peco | cut -d \  -f 1)
    if [ -n "$gem_name" ]; then
        local gem_dir=$(bundle show ${gem_name})
        cd $gem_dir
    fi
}
