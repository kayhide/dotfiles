{ config, pkgs, lib, ... }:

let
  restart-services-command = ''
    systemctl --user restart polybar conky-clock wallpaper
  '';
in

{
  config = {
    programs.autorandr = {
      enable = true;
      hooks = {
        postswitch = {
          restart-services = ''
            lock="$HOME/.cache/screen-locker/lock"
            ${pkgs.util-linux}/bin/flock -n -x "$lock" -c "${restart-services-command}"
          '';
        };
      };
    };
  };
}
