{ config, pkgs, lib, ... }:

let
  mod = "Mod4";

in

{
  config = {
    xsession = {
      enable = true;
      # windowManager.command = "i3";
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        config = {
          modifier = mod;
	        keybindings = lib.mkOptionDefault {
	          "${mod}+Return" = "exec kitty";
	          "${mod}+h" = "focus left";
	          "${mod}+j" = "focus down";
	          "${mod}+k" = "focus up";
	          "${mod}+l" = "focus right";
	          "${mod}+b" = "split h";
	          "${mod}+v" = "split v";
	          "${mod}+d" = "exec rofi -modi drun -show drun";
	          "${mod}+Shift+Tab" = "workspace prev";
	          "${mod}+Tab" = "workspace next";
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
          exec --no-startup-id bash ~/.config/i3/autostart.sh
        '';
      };
    };

    home.packages = with pkgs; [
      arandr
      autorandr
      dunst
      feh
      i3lock
      keynav
      # libnotify
      lxappearance
      networkmanagerapplet
      parcellite
      pasystray
      pavucontrol
      redshift
      rofi
      unclutter
      xautolock
      xfontsel
      xorg.xbacklight
      xorg.xev
      xorg.xkill
    ];

    home.file.".config/i3/autostart.sh".source = ../dotfiles/i3/autostart.sh;
  };
}
