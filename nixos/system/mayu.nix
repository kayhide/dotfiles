{ config, pkgs, ... }:

let
  mayu = pkgs.callPackage ../nix/pkgs/mayu.nix {};

in

{
  config = {
    systemd.services.mayu = {
      description = "Melancholy of Window Master";
      after = [ "basic.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        RemainAfterExit = true;
        User = "root";
        ExecStart = "${mayu}/bin/mayu";
        Restart = "always";
      };
    };
  };
}
