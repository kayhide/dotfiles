{ config, pkgs, lib, ... }:

let
  bin-path = with pkgs; lib.makeBinPath [
    coreutils
    feh
    findutils
    gnugrep
    gnused
    xorg.xrandr
    xwinwrap
  ];

  wallpaper = with pkgs; writeShellScriptBin "wallpaper" ''
    PATH=${bin-path}:$PATH
    wallpaper_dir="$HOME/.wallpaper"
    current="$HOME/.cache/wallpaper/current"

    count="$(xrandr --listmonitors | head -n 1 | sed "s/^.*: *//")"

    verify-current() {
      if find "$current" -mmin -1 | grep .; then
        lines="$(wc -l < "$current")"
        if (( lines == count )); then
            return 0
        fi
      fi
      return 1
    }

    refresh-current() {
      mkdir -p "$(dirname "$current")"
      find -L "$wallpaper_dir" | shuf -n "$count" > "$current"
    }

    verify-current || refresh-current


    width=0
    height=0
    for g in $(xrandr --listmonitors | cut -d " " -f 4 | sed -n "s=/[0-9]*==gp"); do
      if [[ $g =~ ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+) ]]; then
        w=$(( BASH_REMATCH[1] + BASH_REMATCH[3] ))
        h=$(( BASH_REMATCH[2] + BASH_REMATCH[4] ))
        (( width < w )) && width=$w
        (( height < h )) && height=$h
      fi
    done
    if (( 0 < width && 0 < height )); then
      readarray -t files < "$current"
      xwinwrap -g "''${width}x''${height}+0+0" \
        -o 0.5 \
        -ov \
        -- \
        feh --no-fehbg --bg-center --bg-fill "''${files[@]}"
    fi

    # Give some time for programs waiting for wallpaper being updated
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
            OnCalendar = "*:0/15:0";
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
