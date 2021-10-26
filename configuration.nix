{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./config/nvim/nvim.nix
    ];

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

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" "ext4" "vfat" ];
    kernelPackages = pkgs.linuxPackages_latest;
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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

