{ config, pkgs, ... }:

{
  imports = [ ./config/nvim/nvim.nix ./config/zfs/snapshot.nix ];

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
    zfs = {
    	enableUnstable = true;
    };
  };

  services.zfs.autoScrub.enable = true;
  networking.hostId = "31c8719e";

  # Printing
  services.printing = {
      enable = true;
      drivers = [ pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
  };


  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.displayManager.startx.enable = true;
  services.xserver.displayManager.defaultSession = "none+dwm";
  services.xserver.windowManager.dwm.enable = true;
  
  # Configure keymap in X11
  services.xserver.layout = "us";

  # Enable pipewire for sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

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

  system.stateVersion = "21.05"; # DO NOT CHANGE

}

