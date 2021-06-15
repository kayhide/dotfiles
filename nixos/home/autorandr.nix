{ config, pkgs, lib, ... }:

let
  logfile = "/home/kayhide/autorandr.log";

in

{
  config = {
    programs.autorandr = {
      enable = true;
      hooks = {
        postswitch = {
          "restart-services" = ''
            systemctl --user start wallpaper.service
            systemctl --user restart polybar.service
          '';
        };
      };
    };
  };
}
