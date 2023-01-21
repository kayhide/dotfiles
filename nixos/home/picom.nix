{ config, pkgs, lib, ... }:

{
  config = {
    home = {
      packages = [ pkgs.picom ];
      file.".config/picom/picom.conf".source = ../dotfiles/picom/picom.conf;
    };

    systemd.user = {
      services = {
        picom = {
          Unit = {
            Description = "Picom X11 compositor";
            After = [ "graphical-session-pre.target" ];
            PartOf = [ "graphical-session.target" ];
          };
          Service = {
            ExecStart = "${pkgs.picom}/bin/picom";
            Restart = "always";
          };
          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
  };
}
