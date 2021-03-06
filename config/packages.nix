{ pkgs, config, ... }:

{
    nixpkgs.config.allowUnfree = true;

    # Install all the packages
    environment.systemPackages = with pkgs; [
      # Terminal emulators
      kitty
      alacritty	

      # System monitors
      htop
      kmon

      # Graphical User Interfaces
      gparted
      filezilla
      #chromium
      ungoogled-chromium
      firefox
      brave
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
      remmina
      nitrogen
      system-config-printer

      # Misc
      pop-gtk-theme
      harfbuzz
      dwmblocks
      dmenu
      udiskie
      libfido2
      wally-cli
      udisks2
      sanoid
      shfmt
      shellcheck

      # Terminal applications
      killall
      wget
      vim
      bc
      fzf
      ripgrep
      scrot
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
      spotdl
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
      #neovim-nightly
      neovim
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
      lua52Packages.luacheck
      lua
      lazygit

      # Lang servers
      rnix-lsp
      clang-tools
      nodePackages.bash-language-server
      sumneko-lua-language-server
    ];

}
