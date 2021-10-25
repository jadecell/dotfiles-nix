{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  networking.hostName = "orion"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.displayManager.defaultSession = "none+dwm";
  services.xserver.windowManager.dwm.enable = true;
  
  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

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

  nixpkgs.overlays = [

    #(final: prev: {
    #  dwm = prev.dwm.overrideAttrs (old: { src = /home/jackson/.local/repos/dwm ;});
    #})

    #(final: prev: {
    #  dmenu = prev.dmenu.overrideAttrs (old: { src = /home/jackson/.local/repos/dmenu ;});
    #})
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

