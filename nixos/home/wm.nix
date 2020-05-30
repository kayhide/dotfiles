{ config, pkgs, lib, ... }:

let
  mod = "Mod4";

in

{
  config = {
    xsession = {
      enable = true;
      windowManager.command = "i3";
    };

    home.packages = with pkgs; [
      arandr
      autorandr
      dunst
      feh
      i3-gaps
      i3status
      i3lock
      i3blocks
      keynav
      # libnotify
      lxappearance
      networkmanagerapplet
      parcellite
      pasystray
      pavucontrol
      picom
      redshift
      rofi
      unclutter
      xautolock
      xfontsel
      xorg.xbacklight
      xorg.xev
      xorg.xkill
    ];

    home.file.".config/i3/config".source = ../dotfiles/i3/config;
    home.file.".config/i3/autostart.sh".source = ../dotfiles/i3/autostart.sh;
    home.file.".config/picom/picom.conf".source = ../dotfiles/picom/picom.conf;
  };
}
