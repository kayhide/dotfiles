{ config, pkgs, lib, ... }:

let
  conky-clock = pkgs.writeScriptBin "conky-clock" ''
    #!${pkgs.stdenv.shell}

    PATH=${pkgs.bash}/bin:${pkgs.gnugrep}/bin:${pkgs.gnused}/bin:${pkgs.coreutils}/bin:$HOME/bin:$PATH

    conky_config="$HOME/.config/conky/clock.conf"

    ${pkgs.xorg.xrandr}/bin/xrandr --listmonitors | sed -n "s/^ \([0-9]\+\):.*$/\1/p" | while read -r head; do
      ${pkgs.conky}/bin/conky --xinerama-head="$head" --config "$conky_config" &
    done
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
            After = [ "graphical-session-pre.target" ];
            PartOf = [ "graphical-session.target" ];
          };
          Service = {
            Type = "simple";
            ExecStart = "${conky-clock}/bin/conky-clock";
            IOSchedulingClass = "idle";
            Restart = "always";
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
