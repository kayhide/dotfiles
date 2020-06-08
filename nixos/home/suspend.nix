{ config, pkgs, lib, ... }:

{
  config = {
    systemd.user.services.suspend = {
      Unit = {
        Description = "User suspend action";
        Before = [ "suspend.target" ];
      };

      Install = {
        WantedBy = [ "suspend.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "loginctl lock-session";
      };
    };
  };
}
