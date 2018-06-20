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
if which brew > /dev/null; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
  fpath=($(brew --prefix)/share/zsh-completions $fpath)
  if [ -f $(brew --prefix)/etc/bash_completion.d/git-prompt.sh ]; then
    source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
  fi
fi

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'


if which stack > /dev/null; then
  eval "$(stack --bash-completion-script stack)"
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
alias gbrowse='git browse'

alias d='docker'
alias dbuild='docker build'
alias drun='docker run'
alias dps='docker ps'
alias dstats='docker stats'
alias dimages='docker images'
alias dcontainer='docker container'
alias dsweep='docker rm $(docker ps --filter "status=exited" -q) && docker rmi $(docker images --filter "dangling=true" -aq'

alias vf='vim +VimFiler'

alias -g G='| grep'
alias -g L='| lv -c'
alias -g X='| xargs'
alias -g XG='| xargs grep'
alias -g CP='| pbcopy'
alias -g P='| peco'

alias -g r='rails'
alias -g sr='spring rails'
alias -g RED='RAILS_ENV=development'
alias -g RET='RAILS_ENV=test'
alias -g REP='RAILS_ENV=production'

alias rdmigrate='rake db:migrate'
alias rdstatus='rake db:migrate:status'
alias rdrollback='rake db:rollback'

alias -g ST='STAGE=test'
alias -g SD='STAGE=dev'
alias -g SP='STAGE=prod'
alias -g RSD='ON_REMOTE=1 STAGE=dev'
alias -g RSP='ON_REMOTE=1 STAGE=prod'

alias powopen='powder open'
alias powlink='powder link'
alias powunlink='powder unlink'
alias powstop='powder stop'
alias powstart='powder start'
alias powrestart='powder stop; powder start'

alias be='bundle exec'

alias ghc="stack ghc --"
alias runghc="stack runghc --"
alias runhaskell="stack runhaskell --"
alias ghci="stack exec -- ghci"

# env
export EDITOR='vim'
export VISUAL=$EDITOR


export LANG="ja_JP.UTF-8"
export LC_COLLATE="C"

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/cuda/bin:$PATH"
export PATH="./bin:../bin:$HOME/bin:$PATH"

export CUDA_PATH="/usr/local/cuda"
export DYLD_LIBRARY_PATH="/usr/local/cuda/lib"

export GTAGSLABEL=pygments


if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
if which hub > /dev/null; then eval "$(hub alias -s)"; fi
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi


source ~/.zsh/tac.zsh
source ~/.zsh/select-history.zsh
source ~/.zsh/select-branch.zsh
source ~/.zsh/cdgem.zsh
source ~/.zsh/cdrepo.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

