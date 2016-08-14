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

if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
    source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
fi

# prompt
setopt prompt_subst

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!%f"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+%f"
zstyle ':vcs_info:*' formats "%c%u%F{green}[%b]%f"
zstyle ':vcs_info:*' actionformats '%F{yellow}[%b|%a]'
precmd () { vcs_info }

PROMPT=$'%F{yellow}[%D{%Y-%m-%d %H:%M:%S}] %F{blue}%n@%m %F{cyan}%~ ${vcs_info_msg_0_}
%F{blue}%#%f '

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
alias lv='lv -c'
alias less='less -R'

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

alias -g MED='MOTION_ENV=development'
alias -g MET='MOTION_ENV=test'
alias -g MEP='MOTION_ENV=production'

alias -g mm='middleman'

alias be='bundle exec'

alias tcopy='tmux save-buffer - | pbcopy'

# env
export EDITOR='vim'
export VISUAL=$EDITOR

export PGDATA='/usr/local/var/postgres/9.5'
export PGHOST='localhost'
export PGLOG=$PGDATA'/server.log'
export PGUSER='postgres'

alias pg_start="pg_ctl start -l $PGLOG"
alias pg_status="pg_ctl status"
alias pg_stop="pg_ctl stop -m s"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which hub > /dev/null; then eval "$(hub alias -s)"; fi
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="/usr/texbin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/cuda/bin:$PATH"
export PATH="./bin:$HOME/bin:$PATH"

export CUDA_PATH="/usr/local/cuda"
export DYLD_LIBRARY_PATH="/usr/local/cuda/lib"

export ANDROID_HOME="/usr/local/opt/android-sdk"

export RUBYMOTION_ANDROID_SDK="$HOME/.rubymotion-android/sdk"
export RUBYMOTION_ANDROID_NDK="$HOME/.rubymotion-android/ndk"

export GTAGSLABEL=pygments


source ~/.zsh/tac.zsh
source ~/.zsh/select-history.zsh
source ~/.zsh/select-branch.zsh
source ~/.zsh/cdgem.zsh
source ~/.zsh/cdrepo.zsh
