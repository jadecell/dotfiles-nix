{ config, pkgs, ... }:

{
  imports = [ ./config/zfs/snapshot.nix ];

  environment.variables = {
       NIXOS_CONFIG="$HOME/.config/nixos/configuration.nix";
       NIXOS_CONFIG_DIR="$HOME/.config/nixos/";
       ZDOTDIR="$HOME/.config/zsh";
  }; 
  
  # Nix settings, auto cleanup and enable flakes
  nix = {
      autoOptimiseStore = true;
      allowedUsers = [ "jackson" ];
      gc = {
          automatic = true;
          dates = "daily";
      };
      package = pkgs.nixUnstable;
      extraOptions = ''
          experimental-features = nix-command flakes
      '';
  };
  
  nixpkgs.config.allowBroken = true;

  boot = {
    loader = {
      grub = {
          efiSupport = true;
          device = "nodev";
          copyKernels = true;
      };
      efi = { 
        canTouchEfiVariables = true; 
        efiSysMountPoint = "/boot";
      };
    };
    supportedFilesystems = [ "ntfs" "zfs" "ext4" "vfat" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "nohibernate" ];
    cleanTmpDir = true;
    zfs = {
    	enableUnstable = true;
    };
  };

  services.zfs.autoScrub.enable = true;

  # Printing
  services.printing = {
      enable = true;
      drivers = [ pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
  };

  # Networking
  networking = {
    networkmanager.enable = true;

    # zfs host ID
    hostId = "a5280a4d";
  }; 

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # X11
  services.xserver = {
    enable = true;
    displayManager = {
        startx.enable = true;
        defaultSession = "none+dwm";
    };
    windowManager.dwm.enable = true;
    
    # Configure keymap in X11
    layout = "us";
    libinput.enable = true;
  };

  # Enable pipewire for sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jackson = {
    isNormalUser = true;
    shell = pkgs.zsh;
    initialPassword = "123";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];

  nixpkgs.config.joypixels.acceptLicense = true;

  # Install fonts
  fonts.fonts = with pkgs; [
      jetbrains-mono 
      roboto
      joypixels
      ubuntu_font_family
      cantarell-fonts
      (nerdfonts.override { fonts = [ "RobotoMono" ]; })
  ];

  # Enable polkit
  security.polkit.enable = true;
  programs.dconf.enable = true;

  services.gnome = {
    gnome-keyring.enable = true;
    gnome-online-accounts.enable = true;
  };

  # Mullvad
  services.mullvad-vpn.enable = true;

  # Cron Jobs
  services.cron = {
      enable = true;
      systemCronJobs = [
        "*/15 * * * *   jackson   export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus; export DISPLAY=:0; /home/jackson/.config/nixos/bin/cron/newsup"
      ];
  };

  system.stateVersion = "21.05"; # DO NOT CHANGE

}

