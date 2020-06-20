{ config, ... }:

{
  config = {
    fileSystems."/mnt/hdlan16" = {
      device = "//192.168.48.27/pub";
      fsType = "cifs";
    };
  };
}
