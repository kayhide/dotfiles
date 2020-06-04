{ config, pkgs, lib, ... }:

let
  hub = pkgs.gitAndTools.hub;
  zplug = pkgs.callPackage ./zplug.nix {};

in

{
  imports = [
    ./home/wm.nix
    ./home/bar.nix
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
    bat
    bind
    direnv
    entr
    ghq
    gibo
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
    zplug

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
    font-manager
    gucharmap

    # Unfree Apps
    google-chrome
    slack
    zoom-us

    # Languages
    gnumake
    stack
    elixir
    chez

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
