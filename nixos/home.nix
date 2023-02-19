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
    bat
    bat-extras.batgrep
    bat-extras.batman
    bat-extras.batwatch
    bc
    bind
    direnv
    entr
    fd
    file
    findutils
    fzf
    gettext
    lsof
    lv
    moreutils
    ncdu
    neofetch
    nkf
    openssh
    peco
    ripgrep
    rlwrap
    rsync
    tree
    unar
    watch
    websocat
    xclip
    xsel

    # Shell
    bash
    zplug
    zsh

    # Top
    atop
    gotop
    htop
    iftop
    iotop
    powertop

    # Git
    ghq
    gibo
    git
    git-lfs
    tig

    # Json / Yaml / Html
    jo
    jq
    pup
    yq-go

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
    hub
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
    evince
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
    gnumake
    ruby
    shellcheck
    shfmt

    # Haskell
    hlint
    stack
    stylish-haskell

    # Container
    docker
    docker-compose
    kompose
    kubectl
    kubectx
    kubernetes-helm
    lazydocker

    # Nix
    nix-direnv
    nix-prefetch
    nix-prefetch-git
    patchelf
    niv
    nixpkgs-fmt
  ];

  home.file = {
    "bin/nix-update" = {
      source = ./bin/nix-update;
      executable = true;
    };

    "bin/nixos-commit-hash" = {
      source = ./bin/nixos-commit-hash;
      executable = true;
    };

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
