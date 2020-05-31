{ config, pkgs, lib, ... }:

let
  hub = pkgs.gitAndTools.hub;
  zplug = pkgs.callPackage ./zplug.nix {};

in

{
  imports = [
  #  ./home/alacritty.nix
    ./home/wm.nix
  ];
  programs.home-manager.enable = true;

  home.username = "kayhide";
  home.homeDirectory = "/home/kayhide";


  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # WM
    acpi
    maim

    # Cli
    bat
    direnv
    entr
    ghq
    htop
    hub
    jq
    lv
    neofetch
    openssh
    peco
    powertop
    rsync
    tig
    tree
    unar
    watch
    xclip
    xsel
    yq

    # HW
    glxinfo
    pciutils
    usbutils

    # Apps
    awscli
    dropbox
    emacs
    exercism
    google-cloud-sdk
    heroku
    imagemagick
    kitty
    neovim
    ranger

    # Container
    docker
    docker-compose
    kompose
    kubectl
    kubectx
    kubernetes-helm
    lazydocker
    minikube

    # Unfree Apps
    google-chrome
    slack
    zoom-us

    # Languages
    gnumake
    stack
    elixir
    chez

    # Nix
    nix-prefetch
    patchelf
    niv
    nixpkgs-fmt

    # Utils
    zplug
  ];

  home.file."bin/wallpaper" = {
    source = ./bin/wallpaper;
    executable = true;
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
