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

# completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# colors
autoload colors && colors

# zplug
if [[ -d $HOME/.nix-profile/opt/zplug ]]; then
    export ZPLUG_INIT="$HOME/.nix-profile/opt/zplug/init.zsh"
elif [[ -d /usr/local/opt/zplug ]]; then
    export ZPLUG_INIT="/usr/local/opt/zplug/init.zsh"
fi
if [[ -n ${ZPLUG_INIT+x} ]]; then
    export ZPLUG_HOME="$HOME/.zplug"
    mkdir -p "$ZPLUG_HOME"

    source "$ZPLUG_INIT"

    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "zsh-users/zsh-completions"
    zplug "mafredri/zsh-async", from:github
    zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
    zplug check --verbose || zplug install
    zplug load
fi

set_style__pure() {
    zstyle :prompt:pure:git:branch color green
    zstyle :prompt:pure:git:action color yellow
    if [[ -n ${IN_NIX_SHELL+x} ]]; then
        local nix="💠"
        PROMPT=$(echo $PROMPT | sed -e "1 s/\(.*\)/$nix \1/")
    fi

}
set_style__pure


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

if which brew > /dev/null; then
    alias brew="PATH=$(brew --prefix)/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"
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


which direnv > /dev/null && eval "$(direnv hook zsh)"
which hub > /dev/null && eval "$(hub alias -s zsh)"
which rbenv > /dev/null && eval "$(rbenv init -)"
which pyenv > /dev/null && eval "$(pyenv init -)"
which nodenv > /dev/null && eval "$(nodenv init -)"
which stack > /dev/null && eval "$(stack --bash-completion-script stack)"


source_if_exists() {
    [[ -e "$1" ]] && source "$1"
}

source_if_exists "${HOME}/.nix-profile/etc/profile.d/nix.sh"
source_if_exists "${HOME}/.iterm2_shell_integration.zsh"
source_if_exists "${HOME}/.google-cloud-sdk/path.zsh.inc"
source_if_exists "${HOME}/.google-cloud-sdk/completion.zsh.inc"
# source_if_exists "${HOME}/.opam/opam-init/init.sh"

source_if_exists "${HOME}/.zsh/tac.zsh"
source_if_exists "${HOME}/.zsh/select-history.zsh"
source_if_exists "${HOME}/.zsh/select-branch.zsh"
source_if_exists "${HOME}/.zsh/cdgem.zsh"
source_if_exists "${HOME}/.zsh/cdrepo.zsh"


export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$CUDA_PATH/bin:$PATH"
export PATH="$HOME/bin:$PATH"
