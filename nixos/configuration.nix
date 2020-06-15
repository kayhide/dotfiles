# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  getName = drv:
    if builtins.hasAttr "pname" drv
    then drv.pname
    else if builtins.hasAttr "name" drv
    then (builtins.parseDrvName drv.name).name
    else throw "Cannot figure out name of: ${drv}";

  mayu = pkgs.callPackage ./nix/pkgs/mayu.nix {};
  mayuService = import ./system/mayu.service.nix { inherit mayu; };

in

{
  imports = [
    <nixos-hardware/dell/xps/15-7590>
    ./system/hardware-configuration.nix
    ./system/power.nix
    # ./system/iris.nix
    ./system/nvidia.nix
    ./system/opengl.nix
    ./system/brightness.nix
    ./system/audio.nix
    ./users.nix
  ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelPackages = pkgs.linuxPackages_5_6;

  networking.hostName = "napoli";
  networking.wireless.enable = true;

  # Use this if networking.wireless does not work.
  # networking.networkmanager.enable = true;

  # Touch /etc/wpa_supplicant.conf.
  # Without this file, wpa_supplicant service does not work.
  environment.etc."wpa_supplicant.conf".text = "";

  services.connman.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.ens20u1u4.useDHCP = true;
  networking.interfaces.wlp59s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 3000 ];
  # networking.firewall.allowedUDPPorts = [];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "jp106";
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  environment.systemPackages = with pkgs; [
    curl wget git neovim mayu
  ];

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    extraOptions = "--userns-remap=default";
  };

  virtualisation.virtualbox = {
    host.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  systemd.services.mayu = mayuService;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    systemWide = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.autorun = false;
  services.xserver.layout = "jp";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput = {
    enable = true;
    naturalScrolling = true;
  };


  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.xterm.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
    autoLogin = {
      enable = true;
      user = "kayhide";
    };
  };

  # TODO Set the following resolution onto the login screen
  # services.xserver.displayManager.setupCommands = ''
  #   xrandr --output default --mode 2560x1400 || true
  # '';

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    material-icons
    nerdfonts
  ];

  services.lorri.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}
