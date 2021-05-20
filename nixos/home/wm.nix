{ config, pkgs, lib, ... }:

let
  i3lock-fancy = pkgs.callPackage ../nix/pkgs/i3lock-fancy.nix {};
  mod = "Mod4";

in

{
  config = {
    xsession = {
      enable = true;
      windowManager.command = "i3";
      profileExtra = ''
        export GLFW_IM_MODULE="ibus"
        export GTK_IM_MODULE="ibus"
        export QT_IM_MODUE="ibus"
        export XMODIFIERS="@im=ibus"
        ibus-daemon -rxv &
      '';
    };

    services.screen-locker = {
      enable = true;
      lockCmd = "${i3lock-fancy}/bin/i3lock-fancy -n -- ${pkgs.maim}/bin/maim -m 1";
      inactiveInterval = 10;
      xautolockExtraOptions = [
        "-corners" "++--"
        "-cornerdelay" "1"
        "-cornerredelay" "60"
      ];
    };

    services.udiskie.enable = true;

    home.packages = with pkgs; [
      arandr
      autorandr
      dunst
      feh
      i3-gaps
      i3status
      i3lock-fancy
      keynav
      # libnotify
      conky
      lxappearance
      parcellite
      pasystray
      pavucontrol
      picom
      redshift
      rofi
      unclutter
      xfontsel
      xorg.xbacklight
      xorg.xev
      xorg.xkill
      xorg.xwininfo
    ];

    home.file.".config/i3/config".source = ../dotfiles/i3/config;
    home.file.".config/i3/autostart.sh".source = ../dotfiles/i3/autostart.sh;
    home.file.".config/picom/picom.conf".source = ../dotfiles/picom/picom.conf;
    home.file.".config/conky/clock.conf".source = ../dotfiles/conky/clock.conf;
  };
}
