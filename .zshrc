bindkey -e

setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt brace_ccl
setopt correct
setopt extended_glob
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt list_packed
setopt magic_equal_subst
setopt mark_dirs
setopt nolistbeep
setopt prompt_subst
setopt pushd_ignore_dups
setopt share_history

zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z-_}={A-Za-z_-}'
zstyle ':completion:*:default' menu select=1
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' extended-search yes
zstyle ':filter-select' hist-find-no-dups yes
zstyle ':filter-select' rotate-list yes

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export LISTMAX=0
export SAVEHIST=100000

cdpath=(.. ~)

# completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# colors
autoload colors && colors

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

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
if [ -f $ZPLUG_HOME/init.zsh ]; then
    source $ZPLUG_HOME/init.zsh

    # zplug "zsh-users/zsh-autosuggestions" # does not work with cdpath
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "zsh-users/zsh-completions"
    zplug check --verbose || zplug install
    zplug load
fi

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
alias glgraph='git log --graph --all --decorate --oneline'
alias gcheckout='git checkout'
alias gbranch='git branch'
alias gmerge='git merge'
alias gbrowse='git browse'

alias d='docker'
alias dcontainer='docker container'
alias dsweep='docker rm $(docker ps --filter "status=exited" -q) && docker rmi $(docker images --filter "dangling=true" -aq'

alias dc='docker-compose'
alias dcup='docker-compose up'
alias dcrun='docker-compose run'
alias dcexec='docker-compose exec'

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

if [[ "/usr/local" == $(brew --prefix) ]]; then
    alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"
fi

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

export CUDA_PATH="/usr/local/cuda"
export DYLD_LIBRARY_PATH="/usr/local/cuda/lib"

export GTAGSLABEL=pygments


if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi
if which hub > /dev/null; then eval "$(hub alias -s zsh)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
if which stack > /dev/null; then eval "$(stack --bash-completion-script stack)"; fi


export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$CUDA_PATH/bin:$PATH"
export PATH="./bin:../bin:$HOME/bin:$PATH"


source ~/.zsh/tac.zsh
source ~/.zsh/select-history.zsh
source ~/.zsh/select-branch.zsh
source ~/.zsh/cdgem.zsh
source ~/.zsh/cdrepo.zsh

test -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" && source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kayhide/src/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/kayhide/src/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kayhide/src/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/kayhide/src/google-cloud-sdk/completion.zsh.inc'; fi
