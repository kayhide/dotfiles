{ config, pkgs, lib, ... }:

let
  wallpaper = pkgs.writeScriptBin "wallpaper" ''
    #!${pkgs.stdenv.shell}

    PATH=${pkgs.coreutils}/bin:$PATH

    wallpaper_dir="$HOME/.wallpaper"

    ${pkgs.feh}/bin/feh --no-fehbg --bg-center --bg-fill --randomize --recursive "$wallpaper_dir"
  '';

in

{
  config = {
    systemd.user = {
      services = {
        wallpaper = {
          Unit = {
            Description = "Wallpaper";
            After = [ "graphical-session-pre.target" ];
            PartOf = [ "graphical-session.target" ];
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${wallpaper}/bin/wallpaper";
            IOSchedulingClass = "idle";
          };
          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };

      timers = {
        wallpaper = {
          Unit = {
            Description = "Wallpaper timer";
          };
          Timer = {
            Unit = "wallpaper.service";
            OnCalendar = "*-*-* *:0/15:0";
            Persistent = true;
            RandomizedDelaySec = "1s";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
  };
}
