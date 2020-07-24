{ config, pkgs, lib, ... }:

let
  hub = pkgs.gitAndTools.hub;
  zplug = pkgs.callPackage ./nix/pkgs/zplug.nix {};

in

{
  imports = [
    ./home/wm.nix
    ./home/bar.nix
    ./home/notification.nix
    ./home/suspend.nix
  ];
  programs.home-manager.enable = true;

  home = {
    username = "kayhide";
    homeDirectory = "/home/kayhide";
    sessionVariables = {
      SAVE_LAST_PWD = "/home/kayhide/.cache/last-pwd";
    };
  };


  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # WM
    acpi
    maim

    # Cli
    atop
    bat
    bc
    bind
    direnv
    entr
    envsubst
    ghq
    gibo
    git
    git-lfs
    gotop
    htop
    hub
    iotop
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
    xclip
    xsel
    yq
    zplug

    # HW
    dmidecode
    glxinfo
    pciutils
    usbutils
    udiskie

    # Cli Apps
    awscli
    cmatrix
    dropbox
    exercism
    ffmpeg
    google-cloud-sdk
    heroku
    imagemagick
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
    gnumake
    shellcheck

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
    minikube

    # Nix
    nix-prefetch
    nix-prefetch-git
    patchelf
    niv
    nixpkgs-fmt
  ];

  home.file."bin/wallpaper" = {
    source = ./bin/wallpaper;
    executable = true;
  };

  home.file.".Xresources".source = ./dotfiles/Xresources;
  home.file.".config/kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;

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
