{ config, pkgs, ... }:

{
  config.users = {
    users = {
      kayhide = {
        isNormalUser = true;
        uid = 1000;
        home = "/home/kayhide";
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "docker"];
      };
    };
  };
}
