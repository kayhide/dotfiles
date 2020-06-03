{ pkgs, config, ... }:

let
  polybar = pkgs.polybar.override {
    i3GapsSupport = true;
    alsaSupport = true;
    pulseSupport = true;
  };

  colors = {
    black = "#3b4252";
    red = "#bf616a";
    green = "#a3be8c";
    yellow = "#ebcb8b";
    blue = "#81a1c1";
    magenta = "#b48ead";
    cyan = "#88c0d0";
    white = "#e5e9f0";
    gray = "#4c566a";
  };

  with_alpha = alpha: color: with builtins;
    "#${alpha}${replaceStrings ["#"] [""] color}";

  px-2 = s: "  ${s}  ";
  i = s: "%{T2}${s}%{T-}";

  bar = {
    monitor = "\${env:MONITOR}";
    width = "100%";
    height = "28";

    border-top-size = 8;
    border-left-size = 20;
    border-right-size = 20;
    module-margin = 2;

    background = "#000f0f0f";
    foreground = colors.white;
    font-0 = "NotoSans-Regular:size=10;2";
    font-1 = "Material Icons:style=Regular:size=10;3";
    # font-2 = "Font Awesome 5 Free,Font Awesome 5 Free Regular:style=Regular:size=10";
  };
in

{
  config = {
    services.polybar = {
      enable = true;
      package = polybar;
      script = ''
        MONITOR="eDP-1" polybar base &
        MONITOR="DP-3" polybar base &
      '';

      config = {
        "bar/base" = bar // {
          modules-left = "workspaces";
          modules-right = "wireless-network wired-network pulseaudio backlight battery date";
        };

        "bar/sub1" = bar // {
          modules-left = "workspaces";
          modules-right = "wireless-network wired-network pulseaudio backlight battery date";
        };

        "module/date" = {
          type = "internal/date";
          date = "%Y-%m-%d";
          time = "%H:%M:%S";

          label = px-2 "%date% %time%";
      	  format-background = with_alpha "77" colors.black;
        };

        "module/backlight" = {
          type = "internal/backlight";
          card = "intel_backlight";

          label = px-2 "%percentage%%";
      	  format-background = with_alpha "77" colors.black;
          format-prefix = px-2 (i "");
      	  format-prefix-background = with_alpha "aa" colors.black;
        };

        "module/battery" = {
          type = "internal/battery";
          full-at = 98;
          battery = "BAT0";
          adapter = "AC";

      	  label-charging = px-2 "%percentage%%";
      	  label-discharging = px-2 "%percentage%%";
      	  label-full = px-2 "%percentage%%";

      	  format-charging-background = with_alpha "77" colors.black;
      	  format-discharging-background = with_alpha "77" colors.black;
      	  format-full-background = with_alpha "77" colors.black;

      	  format-charging-prefix = px-2 (i "");
      	  format-discharging-prefix = px-2 (i "");
      	  format-full-prefix = px-2 (i "");

      	  format-charging-prefix-background = with_alpha "aa" colors.yellow;
      	  format-discharging-prefix-background = with_alpha "aa" colors.red;
      	  format-full-prefix-background = with_alpha "aa" colors.cyan;
        };

        "module/pulseaudio" = {
          type = "internal/pulseaudio";
          sink = "alsa_output.pci-0000_00_1f.3.analog-stereo";

      	  label-volume = px-2 "%percentage%%";
      	  label-muted = px-2 "0%";

      	  format-volume-background = with_alpha "77" colors.black;
      	  format-muted-background = with_alpha "77" colors.black;

      	  format-volume-prefix = px-2 (i "");
      	  format-muted-prefix = px-2 (i "");

      	  format-volume-prefix-background = with_alpha "aa" colors.blue;
      	  format-muted-prefix-background = with_alpha "aa" colors.magenta;
        };

        "module/wired-network" = {
          type = "internal/network";
          interface = "ens20u1u4";

          label-connected = px-2 "%linkspeed%";
          label-disconnected = px-2 "0 Mbit/s";

          format-connected-prefix = px-2 (i "");
          format-disconnected-prefix = px-2 (i "");

      	  format-connected-background = with_alpha "77" colors.black;
      	  format-disconnected-background = with_alpha "77" colors.black;

      	  format-connected-prefix-background = with_alpha "aa" colors.black;
      	  format-disconnected-prefix-background = with_alpha "aa" colors.red;
        };

        "module/wireless-network" = {
          type = "internal/network";
          interface = "wlp59s0";

          label-connected = px-2 "%signal%%";
          label-disconnected = px-2 "0%";

          format-connected-prefix = px-2 (i "");
          format-disconnected-prefix = px-2 (i "");

      	  format-connected-background = with_alpha "77" colors.black;
      	  format-disconnected-background = with_alpha "77" colors.black;

      	  format-connected-prefix-background = with_alpha "aa" colors.black;
      	  format-disconnected-prefix-background = with_alpha "aa" colors.red;
        };

        "module/workspaces" = {
          type = "internal/i3";
          pin-workspaces = true;
          index-sort = true;
          enable-click = false;
          enable-scroll = false;

      	  label-mode-background = colors.green;
      	  label-mode-foreground = colors.white;
      	  label-mode-padding    = 4;

      	  label-focused-background = with_alpha "aa" colors.green;
      	  label-focused-foreground = colors.white;
      	  label-focused-padding    = 4;

      	  label-unfocused-background = with_alpha "33" colors.gray;
      	  label-unfocused-foreground = colors.white;
      	  label-unfocused-padding    = 4;

      	  label-visible-background = with_alpha "99" colors.cyan;
      	  label-visible-foreground = colors.white;
      	  label-visible-padding    = 4;

      	  label-urgent-background = with_alpha "aa" colors.magenta;
      	  label-urgent-foreground = colors.white;
      	  label-urgent-padding    = 4;

        };
      };
    };
  };
}
