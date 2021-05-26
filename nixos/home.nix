{ config, pkgs, lib, ... }:

let
  hub = pkgs.gitAndTools.hub;

in

{
  imports = [
    ./home/wm.nix
    ./home/polybar.nix
    ./home/notification.nix
    ./home/suspend.nix
    ./home/autorandr.nix
    ./home/wallpaper.nix
    ./home/conky-clock.nix
    ./home/picom.nix
  ];

  home = {
    username = "kayhide";
    homeDirectory = "/home/kayhide";
    sessionVariables = {
      SAVE_LAST_PWD = "/home/kayhide/.cache/last-pwd";
    };
  };

  programs = {
    home-manager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # WM
    acpi
    maim

    # Cli
    atop
    bash
    bat
    bat-extras.batgrep
    bat-extras.batman
    bat-extras.batwatch
    bc
    bind
    direnv
    entr
    envsubst
    fd
    file
    fzf
    ghq
    gibo
    git
    git-lfs
    gotop
    htop
    hub
    iotop
    jo
    jq
    lsof
    lv
    ncdu
    neofetch
    openssh
    peco
    powertop
    ripgrep
    rsync
    tig
    tree
    unar
    watch
    websocat
    xclip
    xsel
    yq-go
    zplug
    zsh

    # HW
    dmidecode
    glxinfo
    pciutils
    usbutils
    udiskie

    # Cli Apps
    alacritty
    awscli
    cmatrix
    dropbox
    exercism
    ffmpeg
    google-cloud-sdk
    heroku
    imagemagick
    kak-lsp
    kakoune
    kitty
    mplayer
    neovim
    ranger

    # Gui Apps
    connman-gtk
    emacs
    font-manager
    gucharmap
    pcmanfm
    vlc

    # Unfree Apps
    google-chrome
    slack
    zoom-us

    # Languages
    chez
    elixir
    erlang
    gnumake
    ruby
    shellcheck

    # Haskell
    hlint
    stack
    stylish-haskell

    # Container
    docker
    docker-compose
    k3s
    kompose
    kubectl
    kubectx
    kubernetes-helm
    lazydocker
    minikube

    # Nix
    nix-direnv
    nix-prefetch
    nix-prefetch-git
    patchelf
    niv
    nixpkgs-fmt
  ];

  home.file = {
    "bin/reset-monitors" = {
      source = ./bin/reset-monitors;
      executable = true;
    };

    "bin/set-monitor" = {
      source = ./bin/set-monitor;
      executable = true;
    };
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
