{ config, pkgs, lib, ... }:

let
  bin-path = with pkgs; lib.makeBinPath [
    conky
    coreutils
    gnused
    xorg.xrandr
  ];

  conky-clock = with pkgs; writeShellScriptBin "conky-clock" ''
    PATH=${bin-path}:$PATH

    conky_config="$HOME/.config/conky/clock.conf"

    xrandr --listmonitors | sed -n "s/^ \([0-9]\+\):.*$/\1/p" | while read -r head; do
      conky --xinerama-head="$head" --config "$conky_config" &
    done

    sleep 1
  '';

in

{
  config = {
    home = {
      file.".config/conky/clock.conf".source = ../dotfiles/conky/clock.conf;
    };

    systemd.user = {
      services = {
        conky-clock = {
          Unit = {
            Description = "Conky clock";
            After = [ "graphical-session-pre.target" "wallpaper.service" ];
            PartOf = [ "graphical-session.target" ];
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${conky-clock}/bin/conky-clock";
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
