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
  base-background = with_alpha "77" colors.black;

  with_alpha = alpha: color: with builtins;
    "#${alpha}${replaceStrings ["#"] [""] color}";

  with_background = color: s:
    "%{B${color}}${s}%{B-}";


  px-2 = s: "  ${s}  ";
  sm = s: "%{T2}${s}%{T-}";
  lg = s: "%{T3}${s}%{T-}";

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
    font-0 = "NotoSans Nerd Font:style=Regular:size=10;2";
    font-1 = "NotoSans Nerd Font:style=Regular:size=8;3";
    font-2 = "NotoSans Nerd Font:style=Regular:size=12;3";
    font-3 = "Material Icons:style=Regular:size=12;4";
    # font-4 = "Font Awesome 5 Free,Font Awesome 5 Free Regular:style=Regular:size=10";
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
          modules-right = "wireless-network wired-network-eth0 wired-network-ens20u1u4 pulseaudio backlight battery";
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
          format-prefix = px-2 (lg "");
          format-prefix-background = with_alpha "99" colors.yellow;

          # 
        };

        "module/battery" = {
          type = "internal/battery";
          full-at = 98;
          battery = "BAT0";
          adapter = "AC";

          format-discharging = "${with_background (with_alpha "aa" colors.red) (px-2 "<ramp-capacity>")}${with_background base-background (px-2 "<label-discharging>")}";
          format-charging = "${with_background (with_alpha "aa" colors.magenta) (px-2 "<ramp-capacity>${sm ""}")}${with_background base-background (px-2 "<label-charging>")}";
          format-full = "${with_background (with_alpha "99" colors.black) (px-2 (lg ""))}${with_background base-background (px-2 "<label-full>")}";

          ramp-capacity-0 = lg "";
          ramp-capacity-1 = lg "";
          ramp-capacity-2 = lg "";
          ramp-capacity-3 = lg "";
          ramp-capacity-4 = lg "";

          #       
        };

        "module/pulseaudio" = {
          type = "internal/pulseaudio";
          sink = "alsa_output.pci-0000_00_1f.3.analog-stereo";

          label-volume = px-2 "%percentage%%";
          label-muted = px-2 "0%";

          format-volume-background = with_alpha "77" colors.black;
          format-muted-background = with_alpha "77" colors.black;

          format-volume-prefix = px-2 (lg "");
          format-muted-prefix = px-2 (lg "");

          format-volume-prefix-background = with_alpha "aa" colors.blue;
          format-muted-prefix-background = with_alpha "aa" colors.magenta;

          #  
        };

        "module/wired-network-eth0" = {
          type = "internal/network";
          interface = "eth0";

          label-connected = px-2 (lg "");
          format-connected-background = with_alpha "99" colors.green;

          label-disconnected = px-2 (lg "");
          format-disconnected-background = with_alpha "cc" colors.red;

          #  
        };

        "module/wired-network-ens20u1u4" = {
          type = "internal/network";
          interface = "ens20u1u4";

          label-connected = px-2 (lg "");
          format-connected-background = with_alpha "99" colors.green;

          label-disconnected = px-2 (lg "");
          format-disconnected-background = with_alpha "cc" colors.red;

          #  
        };

        "module/wireless-network" = {
          type = "internal/network";
          interface = "wlp59s0";

          format-connected-prefix = px-2 (lg "");
          format-connected-prefix-background = with_alpha "cc" colors.black;
          label-connected = px-2 "%essid%";
          format-connected-background = with_alpha "77" colors.black;

          label-disconnected = px-2 (lg "");
          format-disconnected-background = with_alpha "cc" colors.red;

          #  
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

          label-focused-background = with_alpha "cc" colors.blue;
          label-focused-foreground = colors.white;
          label-focused-padding    = 4;

          label-unfocused-background = with_alpha "66" colors.gray;
          label-unfocused-foreground = colors.white;
          label-unfocused-padding    = 4;

          label-visible-background = with_alpha "66" colors.blue;
          label-visible-foreground = colors.white;
          label-visible-padding    = 4;

          label-urgent-background = with_alpha "cc" colors.magenta;
          label-urgent-foreground = colors.white;
          label-urgent-padding    = 4;

        };
      };
    };
  };
}
