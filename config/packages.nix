{ pkgs, config, ... }:

{
    nixpkgs.config.allowUnfree = true;

    # Install all the packages
    environment.systemPackages = with pkgs; [

      dwmblocks
      # Terminal emulators
      kitty
      alacritty	

      # System monitors
      htop
      kmon

      # Graphical User Interfaces
      mullvad-vpn
      firefox
      pcmanfm
      stalonetray
      gnome.seahorse
      lxappearance
      pavucontrol
      libreoffice-fresh
      emacs
      qalculate-gtk
      evince
      gimp
      gnome.geary
      nextcloud-client
      nitrogen

      # Misc
      dmenu
      udiskie
      udisks2

      # Terminal applications
      killall
      wget
      vim
      fzf
      ripgrep
      fd
      bat
      lm_sensors
      xdo
      xdotool
      sxiv
      ffmpeg
      lf
      ranger
      youtube-dl
      xwallpaper
      starship
      zsh
      mpv
      pamixer
      polkit_gnome
      zip
      unzip
      jq
      xcompmgr
      neofetch
      sysstat
      scrot
      shfmt
      shellcheck
      newsboat
      transmission
      stig
      tree-sitter 
      xclip
      mediainfo
      unrar
      w3m
      highlight
      tree
      glow
      pistol
      dragon-drop
      mpd
      ncmpcpp
      mpc_cli
      lsd
      mlocate
      git
      dunst
      neovim-nightly
      libnotify
      wmname

      # Languages and language packages
      nodejs
      nodePackages.npm
      nodePackages.prettier 
      cmake
      gnumake
      go
      python3Full
      python39Packages.eyeD3
      #python38Packages.eyeD3
      gcc
      lazygit

    ];

}
