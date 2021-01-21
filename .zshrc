bindkey -e

setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt brace_ccl
# setopt correct
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

# colors
autoload colors && colors

# zplug
if which zplug-env > /dev/null && readlink -f "$(which zplug-env)" > /dev/null 2>&1; then
    export ZPLUG_INIT=""$(dirname "$(readlink -f "$(which zplug-env)")")"/../init.zsh"
elif [[ -f $HOME/.nix-profile/opt/zplug/init.zsh ]]; then
    export ZPLUG_INIT="$HOME/.nix-profile/opt/zplug/init.zsh"
elif [[ -f $HOME/.zplug/init.zsh ]]; then
    export ZPLUG_INIT="$HOME/.zplug/init.zsh"
elif [[ -f /usr/local/opt/zplug/init.zsh ]]; then
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
    zplug "docker/compose", use:contrib/completion/zsh
    zplug "nnao45/zsh-kubectl-completion"
    zplug "ahmetb/kubectx"
    zplug check --verbose || zplug install
    zplug load

    if [[ ! -e $ZPLUG_HOME/completions ]]; then
        mkdir -p "$ZPLUG_HOME/completions"
    fi
    if [[ ! -f $ZPLUG_HOME/completions/_kubectx.zsh ]]; then
        cp "$ZPLUG_HOME/repos/ahmetb/kubectx/completion/kubectx.zsh" "$ZPLUG_HOME/completions/_kubectx.zsh"
    fi
    if [[ ! -f $ZPLUG_HOME/completions/_kubens.zsh ]]; then
        cp "$ZPLUG_HOME/repos/ahmetb/kubectx/completion/kubens.zsh" "$ZPLUG_HOME/completions/_kubens.zsh"
    fi
fi


# completion
fpath=($ZPLUG_HOME/completions $fpath)
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit


_prompt_mark() {
    if [[ -n ${DIRENV_DIR+x} ]]; then
        echo -n "🎃"
    fi
    if [[ -n ${IN_NIX_SHELL+x} ]]; then
        echo -n "💠"
    fi
    if [[ -n ${RANGER_LEVEL+x} ]]; then
        for i in $(seq "$RANGER_LEVEL"); do
            echo -n "🌵"
        done
    fi
    if [[ -n ${IN_KAKOUNE_CONNECT+x} ]]; then
        echo -n "🥚\033[33m$KAKOUNE_SESSION"
    fi
}

set_style__pure() {
    zstyle :prompt:pure:git:branch color green
    zstyle :prompt:pure:git:action color yellow
    PROMPT=$(echo $PROMPT | sed -e "1 s/\(.*\)/\$(_prompt_mark)\1/")
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

which xsel > /dev/null && alias pbcopy="xsel --clipboard --input"
which xdg-open > /dev/null && alias open="xdg-open"

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

# env
export EDITOR='kak'
export VISUAL=$EDITOR


export LANG="en_US.UTF-8"
export LC_COLLATE="C"

if [[ -f $HOME/.nix-profile/lib/locale/locale-archive ]]; then
    export LOCALE_ARCHIVE="$HOME/.nix-profile/lib/locale/locale-archive"
fi

export CUDA_PATH="/usr/local/cuda"
export DYLD_LIBRARY_PATH="/usr/local/cuda/lib"

export GTAGSLABEL=pygments


which direnv > /dev/null && eval "$(direnv hook zsh)"
# which hub > /dev/null && eval "$(hub alias -s zsh)"
which stack > /dev/null && eval "$(stack --bash-completion-script stack)"

if [[ -z $IN_NIX_SHELL ]]; then
    which rbenv > /dev/null && eval "$(rbenv init -)"
    which pyenv > /dev/null && eval "$(pyenv init -)"
    which nodenv > /dev/null && eval "$(nodenv init -)"
fi


source_if_exists() {
    [[ -e "$1" ]] && source "$1"
}

source_if_exists "${HOME}/.nix-profile/etc/profile.d/nix.sh"
source_if_exists "${HOME}/.iterm2_shell_integration.zsh"
source_if_exists "${HOME}/.google-cloud-sdk/path.zsh.inc"
source_if_exists "${HOME}/.google-cloud-sdk/completion.zsh.inc"
# source_if_exists "${HOME}/.opam/opam-init/init.sh"
which minikube > /dev/null && source <(minikube completion zsh)

source_if_exists "${HOME}/.zsh/cdgem.zsh"
source_if_exists "${HOME}/.zsh/cdrepo.zsh"
source_if_exists "${HOME}/.zsh/select-history.zsh"
source_if_exists "${HOME}/.zsh/zinputrc"

if [[ -z ${RANGER_LEVEL+x} && -z ${IN_KAKOUNE_CONNECT+x} ]]; then
    source_if_exists "${HOME}/.zsh/save-last-pwd.zsh"
fi


export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$CUDA_PATH/bin:$PATH"
export PATH="$HOME/bin:$PATH"
