{ config, pkgs, lib, ... }:

let
  bin-path = with pkgs; lib.makeBinPath [
    coreutils
    feh
    gnused
    xorg.xrandr
    xwinwrap
  ];

  wallpaper = with pkgs; writeShellScriptBin "wallpaper" ''
    PATH=${bin-path}:$PATH
    wallpaper_dir="$HOME/.wallpaper"

    width=0
    height=0
    for g in $(xrandr --listmonitors | cut -d " " -f 4 | sed -n "s=/[0-9]*==gp"); do
      if [[ $g =~ ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+) ]]; then
        w=$(( ''${BASH_REMATCH[1]} + ''${BASH_REMATCH[3]} ))
        h=$(( ''${BASH_REMATCH[2]} + ''${BASH_REMATCH[4]} ))
        (( width < w )) && width=$w
        (( height < h )) && height=$h
      fi
    done
    if (( 0 < width && 0 < height )); then
      xwinwrap -g "''${width}x''${height}+0+0" -ov -- feh --no-fehbg --bg-center --bg-fill --randomize --recursive "$wallpaper_dir"
    fi

    # It needs some time before conky starts
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
            After = [ "graphical-session-pre.target" ];
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
