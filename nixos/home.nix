{ config, pkgs, lib, ... }:

let
  hub = pkgs.gitAndTools.hub;
  zplug = pkgs.callPackage ./zplug.nix {};

in

{
  imports = [
  #  ./home/alacritty.nix
  ];
  programs.home-manager.enable = true;

  home.username = "kayhide";
  home.homeDirectory = "/home/kayhide";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  xsession = {
    enable = true;
    windowManager.i3 =
      let mod = "Mod4";
      in {
        enable = true;
        package = pkgs.i3-gaps;
        config = {
          modifier = mod;
	        keybindings = lib.mkOptionDefault {
	          "${mod}+Return" = "exec kitty";
	          # "${mod}+d" = "exec rofi --show drun";
	        };

	        window = {
	          border = 2;
	        };

	        gaps = {
	          inner = 20;
	          outer = 0;
	        };
        };
        extraConfig = ''

        '';
      };
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # WM
    acpi
    arandr
    autorandr
    conky
    feh
    i3-gaps
    i3blocks
    i3lock
    i3status
    maim
    rofi

    # Cli
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

    # Container
    kubernetes-helm
    kubectl
    kubectx
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

  # home.file.".config/i3/config".source = ./home/i3/config;
}
