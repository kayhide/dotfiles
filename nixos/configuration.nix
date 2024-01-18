# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

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
    ./system/mayu.nix
    ./system/autorandr.nix
    ./users.nix
    ./mounts.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      grub = {
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    # kernelPackages = pkgs.linuxPackages_5_6;
  };

  systemd = {
    network = {
      wait-online.anyInterface = true;
    };
    extraConfig = ''
      DefaultTimeoutStartSec=15s
      DefaultTimeoutStopSec=15s
    '';
    enableUnifiedCgroupHierarchy = false;
  };

  networking = {
    hostName = "napoli";
    wireless.enable = true;

    # Use this if wireless does not work.
    # networkmanager.enable = true;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      # enp58s0u1u3.useDHCP = true;
      wlp59s0.useDHCP = true;
    };

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    firewall = {
      allowedTCPPorts = [ 22 3001 3000 ];
      # allowedUDPPorts = [];
      # Or disable the firewall altogether.
      # enable = false;

      # IP forwarding is wanted when docker container accesses to the internet.
      #   https://docs.docker.com/network/bridge/#enable-forwarding-from-docker-containers-to-the-outside-world
      # Without it, name resolving may fail and thus apt-get may not work.
      # You can test if resolving works as:
      #   docker run --rm busybox ping google.com
      extraCommands = ''
        iptables -P FORWARD ACCEPT
      '';
    };

    resolvconf = {
      dnsSingleRequest = true;
    };
  };

  # Touch /etc/wpa_supplicant.conf.
  # Without this file, wpa_supplicant service does not work.
  environment.etc."wpa_supplicant.conf".text = "";

  nix = {
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
    settings = {
      max-jobs = lib.mkDefault 12;
      substituters = [
        "https://hydra.iohk.io"
      ];
      trusted-public-keys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
    };
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ mozc ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "jp106";
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";
  # time.timeZone = "Europe/Madrid";

  environment.systemPackages = with pkgs; [
    curl
    wget
    git
    neovim
  ];

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;
      liveRestore = false;
    };
    virtualbox = {
      host.enable = true;
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    systemWide = true;
  };

  hardware.bluetooth = {
    enable = true;
    # powerOnBoot = true;
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
  services = {
    connman.enable = true;
    blueman.enable = true;

    # Required by udiskie.
    udisks2.enable = true;
    gnome.at-spi2-core.enable = true;

    # Enable CUPS to print documents.
    # printing.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      # autorun = false;
      layout = "jp";
      # xkbOptions = "eurosign:e";

      # Enable touchpad support.
      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
        };
      };

      desktopManager = {
        xterm.enable = true;
      };
      displayManager = {
        autoLogin = {
          enable = true;
          user = "kayhide";
        };
        lightdm = {
          enable = true;
        };
      };
    };
  };

  fonts = {
    fontconfig = {
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <alias binding="weak">
            <family>monospace</family>
            <prefer>
              <family>emoji</family>
              <family>Symbola</family>
            </prefer>
          </alias>
          <alias binding="weak">
            <family>sans-serif</family>
            <prefer>
              <family>emoji</family>
              <family>Symbola</family>
            </prefer>
          </alias>
          <alias binding="weak">
            <family>serif</family>
            <prefer>
              <family>emoji</family>
              <family>Symbola</family>
            </prefer>
          </alias>
        </fontconfig>
      '';
    };
    fonts = with pkgs; [
      font-awesome
      material-icons
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      symbola
      ttf_bitstream_vera
    ];
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}
