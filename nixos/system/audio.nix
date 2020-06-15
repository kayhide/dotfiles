{ config, pkgs, ... }:

let
  inherit (pkgs) mplayer;
  alsa-utils = pkgs.alsaUtils;

  run-as-pulse = "${pkgs.sudo}/bin/sudo --user pulse";
  sounds = "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo";
in

{
  config = {
    services.acpid = {
      enable = true;
      logEvents = true;
      handlers = {
       mute = {
          event="button/mute MUTE 00000080 00000000";
          action=''
            ${run-as-pulse} ${alsa-utils}/bin/amixer set Master toggle
            ${run-as-pulse} ${mplayer}/bin/mplayer ${sounds}/bell.oga
          '';
        };
       volume-down = {
          event="button/volumedown VOLDN 00000080 00000000";
          action=''
            ${run-as-pulse} ${alsa-utils}/bin/amixer set Master 5%-
            ${run-as-pulse} ${mplayer}/bin/mplayer ${sounds}/bell.oga
          '';
        };
       volume-up = {
          event="button/volumeup VOLUP 00000080 00000000";
          action=''
            ${run-as-pulse} ${alsa-utils}/bin/amixer set Master 5%+
            ${run-as-pulse} ${mplayer}/bin/mplayer ${sounds}/bell.oga
          '';
        };
      };
    };
  };
}
