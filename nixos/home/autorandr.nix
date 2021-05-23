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
            systemctl --user restart polybar.service
          '';

          "restart-conky-clock" = ''
            PATH=${pkgs.bash}/bin:${pkgs.gnugrep}/bin:${pkgs.gnused}/nbin:${pkgs.procps}/bin:$HOME/bin:$PATH
            PATH=${pkgs.xorg.xrandr}/bin:${pkgs.conky}/bin:$PATH

            echo "[$(date -Iseconds)] restarting conky-clock..." >> ${logfile}
            xrandr --listmonitors | sed -n "s/^ \([0-9]\+\):.*$/\1/p" | while read -r head; do
                pids=$(ps -o pid,command -C conky | grep -e "--xinerama-head=$head" | sed -e "s/^ *\([0-9]\+\).*/\\1/")
                if [[ -n $pids ]]; then
                    kill $pids
                fi

                conky-clock "$head" & disown
            done &>> ${logfile}
            echo "[$(date -Iseconds)] restarted conky-clock." >> ${logfile}
          '';

        };
      };
    };
  };
}
