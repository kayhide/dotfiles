{ config, pkgs, ... }:

let
  inherit (pkgs) stdenv coreutils gnused bc xorg;
  inherit (xorg) xrandr;
  owner = config.users.users."${import ../users/owner.nix}";
  xauthority = "${owner.home}/.Xauthority";

  oled-brightness = stdenv.mkDerivation rec {
    name = "oled-brightness";
    src = ../bin;
    buildInputs = with pkgs; [ makeWrapper ];
    installPhase = ''
      mkdir -p $out/bin
      cp oled-brightness $out/bin
      wrapProgram $out/bin/oled-brightness \
        --set DISPLAY :0 \
        --set XAUTHORITY ${xauthority} \
        --prefix PATH : ${coreutils}/bin \
        --prefix PATH : ${gnused}/bin \
        --prefix PATH : ${bc}/bin \
        --prefix PATH : ${xrandr}/bin
    '';
  };

in

{
  config = {
    services.acpid = {
      enable = true;
      logEvents = true;
      handlers = {
        brightness-up = {
          event="video/brightnessup BRTUP 00000086 00000000";
          action=''
            ${oled-brightness}/bin/oled-brightness up
          '';
        };
        brightness-down = {
          event="video/brightnessdown BRTDN 00000087 00000000";
          action=''
            ${oled-brightness}/bin/oled-brightness down
          '';
        };
      };
    };
  };
}
