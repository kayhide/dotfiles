{ config, pkgs, lib, ... }:

let
  bin-path = with pkgs; lib.makeBinPath [
    coreutils
    gnused
    xorg.xrandr
    xwinwrap
  ];

  wallpaper = with pkgs; writeScriptBin "wallpaper" ''
    #!${stdenv.shell}

    PATH=${xscreensaver}/libexec/xscreensaver:${bin-path}:$PATH

    xrandr --listmonitors | cut -d " " -f 4 | sed -n "s=/[0-9]*==gp" | while read -r g; do
      xwinwrap -g "$g" -ov -- glslideshow -window-id WID -zoom 100 -clip -duration 900 -pan 900 &
    done

    sleep 1
  '';

in

{
  config = {
    systemd.user = {
      services = {
        wallpaper = {
          Unit = {
            Description = "Wallpaper";
            After = [ "graphical-session-pre.target" "conky-clock.service" ];
            PartOf = [ "graphical-session.target" ];
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${wallpaper}/bin/wallpaper";
            IOSchedulingClass = "idle";
            RemainAfterExit = true;
          };
          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
