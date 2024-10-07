bindkey -e

setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt brace_ccl
# setopt correct
# setopt extended_glob
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
if which zplug-env > /dev/null 2>&1 && readlink -f "$(which zplug-env)" > /dev/null 2>&1; then
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
    zplug check --verbose || zplug install
    zplug load
fi


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
    zstyle :prompt:pure:environment:nix-shell show no
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

which xsel > /dev/null 2>&1 && alias pbcopy="xsel --clipboard --input"
which xdg-open > /dev/null 2>&1 && alias open="xdg-open"

alias g='git'
alias glgraph='git log --graph --all --decorate --oneline'
alias gcheckout='git checkout'
alias gbranch='git branch'
alias gmerge='git merge'
alias gbrowse='git browse'

alias d='docker'
alias dcontainer='docker container'
alias dsweep='docker rm $(docker ps --filter "status=exited" -q) && docker rmi $(docker images --filter "dangling=true" -aq'

alias -g G='| grep'
alias -g L='| lv -c'
alias -g X='| xargs'
alias -g XG='| xargs grep'
alias -g CP='| pbcopy'

alias rdmigrate='rake db:migrate'
alias rdstatus='rake db:migrate:status'
alias rdrollback='rake db:rollback'

if which brew > /dev/null 2>&1; then
    alias brew="PATH=$(brew --prefix)/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"
    fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

# completion
if [[ -d $HOME/.nix-profile/share/zsh/site-functions ]]; then
    fpath=("$HOME/.nix-profile/share/zsh/site-functions" $fpath)
fi
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# env
export EDITOR='hx'
export VISUAL=$EDITOR


export LANG="en_US.UTF-8"
export LC_COLLATE="C"

if [[ -f $HOME/.nix-profile/lib/locale/locale-archive ]]; then
    export LOCALE_ARCHIVE="$HOME/.nix-profile/lib/locale/locale-archive"
fi

export CUDA_PATH="/usr/local/cuda"
export DYLD_LIBRARY_PATH="/usr/local/cuda/lib"

export GTAGSLABEL=pygments


which direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"
# which hub > /dev/null 2>&1 && eval "$(hub alias -s zsh)"
which stack > /dev/null 2>&1 && eval "$(stack --bash-completion-script stack)"

if [[ -z $IN_NIX_SHELL ]]; then
    which rbenv > /dev/null 2>&1 && eval "$(rbenv init -)"
    which pyenv > /dev/null 2>&1 && eval "$(pyenv init -)"
    which nodenv > /dev/null 2>&1 && eval "$(nodenv init -)"
fi


source_if_exists() {
    [[ -e "$1" ]] && source "$1"
}

source_if_exists "${HOME}/.nix-profile/etc/profile.d/nix.sh"
source_if_exists "${HOME}/.iterm2_shell_integration.zsh"
source_if_exists "${HOME}/.google-cloud-sdk/path.zsh.inc"
source_if_exists "${HOME}/.google-cloud-sdk/completion.zsh.inc"
# source_if_exists "${HOME}/.opam/opam-init/init.sh"
which minikube > /dev/null 2>&1 && source <(minikube completion zsh)

source_if_exists "${HOME}/.zsh/cdgem.zsh"
source_if_exists "${HOME}/.zsh/cdrepo.zsh"
source_if_exists "${HOME}/.zsh/select-history.zsh"
source_if_exists "${HOME}/.zsh/zinputrc"

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.pack/bin:$PATH"
PATH="$HOME/.ghcup/bin:$PATH"
PATH="$CUDA_PATH/bin:$PATH"
PATH="$HOME/bin:$PATH"
export PATH
