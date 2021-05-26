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
          "restart-i3" = ''
            ${pkgs.i3}/bin/i3-msg restart
            systemctl --user start wallpaper.service
            systemctl --user restart picom.service
            systemctl --user restart conky-clock.service
            systemctl --user restart polybar.service
          '';
        };
      };
    };
  };
}
