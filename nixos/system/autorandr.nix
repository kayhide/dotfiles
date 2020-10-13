{ config, pkgs, lib, ... }:

{
  config = {
    services.autorandr = {
      enable = true;
    };
  };
}
