{ config, pkgs, lib, ... }:

let
  i3lock-fancy = pkgs.callPackage ../nix/pkgs/i3lock-fancy.nix { };

  my-screen-locker = with pkgs; writeShellScriptBin "my-screen-locker" ''
    PATH=${coreutils}/bin:$PATH
    lock="$HOME/.cache/screen-locker/lock"
    mkdir -p "$(dirname $lock)"
    touch "$lock"

    ${util-linux}/bin/flock -x "$lock" -c "${i3lock-fancy}/bin/i3lock-fancy -n"
    ${autorandr}/bin/autorandr --change --force
  '';

  get-focused-pwd = with pkgs; writeShellScriptBin "get-focused-pwd" ''
    PATH="${lib.makeBinPath [coreutils procps xorg.xprop xdotool]}:$PATH"
    X_WINDOW_ID=$(xdotool getwindowfocus)
    TERM_PID=$(xprop -id $X_WINDOW_ID _NET_WM_PID | cut -d ' ' -f 3)
    SHELL_PID=$(ps --ppid $TERM_PID -o pid= | tail -n 1)
    pwdx $SHELL_PID | cut -d ' ' -f 2-
  '';

  mod = "Mod4";

in

{
  config = {
    xsession = {
      enable = true;
      windowManager.command = "i3";
      profileExtra = ''
        export GLFW_IM_MODULE="ibus"
        export GTK_IM_MODULE="ibus"
        export QT_IM_MODUE="ibus"
        export XMODIFIERS="@im=ibus"
        ibus-daemon -rxv &
      '';
    };

    services.screen-locker = {
      enable = true;
      lockCmd = "${my-screen-locker}/bin/my-screen-locker";
      inactiveInterval = 10;
      xautolock = {
        extraOptions = [ "-corners" "++--" "-cornerdelay" "1" "-cornerredelay" "60" ];
      };
    };

    services.udiskie.enable = true;

    home.packages = with pkgs; [
      arandr
      autorandr
      dunst
      feh
      i3
      i3status
      i3lock-fancy
      keynav
      # libnotify
      conky
      lxappearance
      parcellite
      pasystray
      pavucontrol
      picom
      redshift
      rofi
      unclutter
      xfontsel
      xorg.xbacklight
      xorg.xev
      xorg.xkill
      xorg.xwininfo
      get-focused-pwd # required by i3 to open a new terminal
    ];

    home.file.".config/i3/config".source = ../dotfiles/i3/config;
    home.file.".config/i3/autostart.sh".source = ../dotfiles/i3/autostart.sh;
  };
}
