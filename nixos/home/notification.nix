{ config, pkgs, lib, ... }:

let
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
in

{
  config = {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          geometry = "600x5-20+60";
          transparency = 20;
          padding = 6;
          horizontal_padding = 6;
          alignment = "center";
        };
        urgency_low = {
          foreground = colors.black;
          background = colors.cyan;
          frame_color = colors.cyan;
          timeout = 4;
        };
        urgency_normal = {
          foreground = colors.black;
          background = colors.green;
          frame_color = colors.green;
          timeout = 4;
        };
        urgency_critical = {
          foreground = colors.black;
          background = colors.red;
          frame_color = colors.red;
          timeout = 4;
        };
      };
    };
  };
}
