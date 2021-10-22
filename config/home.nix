{ config, pkgs, ... }:

let
    # Import zsh config file
    zshsettings = import ./zsh/zsh.nix;

    # Import firefox settings
    firefoxsettings = import ./firefox/firefox.nix;
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jackson";
  home.homeDirectory = "/home/jackson";

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  # Source extra files to clean this one up
  programs.zsh = zshsettings pkgs;
  programs.firefox = firefoxsettings pkgs;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [	
    
    # Fonts
    cantarell-fonts
    ubuntu_font_family
    nerdfonts
	
    # Terminal emulators
    kitty
    alacritty	

    # System monitors
    htop
    kmon

    # Graphical User Interfaces
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

    # Terminal applications
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

  # Gtk settings
  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        geometry = "0x0-30+30";
        transparency = 0;
        frame_color = "#f8f8f2";
        padding = 8;
        horizontal_padding = 8;
        frame_width = 3;
        font = "RobotoMono Nerd Font 10";
        vertical_alignment = "center";
        show_age_threshold = -1;
        word_wrap = true;
        corner_radius = 10;
      };

      urgency_normal = {
        background = "#1e1e1e"; 
        foreground = "#f8f8f2"; 
        frame_color = "#4166f5"; 
      };

      urgency_low = {
        background = "#1e1e1e"; 
        foreground = "#f8f8f2"; 
        frame_color = "#4166f5"; 
      };
    };
  };

  # Configure git
  programs.git = {
    enable = true;
    userName = "Jackson McCrory";
    userEmail = "jackson@mccrory.xyz";
  };

  home.file = {
     ".local/share/dwm/autostart.sh" = {
      executable = true;
      text = " 
        #!/bin/sh
	
	status() {
	   echo \"$(/home/jackson/.local/bin/statusbar/sb-news) | $(/home/jackson/.local/bin/statusbar/sb-cpuperc dwm) | $(/home/jackson/.local/bin/statusbar/sb-memory dwm) | $(/home/jackson/.local/bin/statusbar/sb-cputemp) | $(/home/jackson/.local/bin/statusbar/sb-clock dwm) | $(/home/jackson/.local/bin/statusbar/sb-networking dwm) \" 
	}	

	xset r rate 300 50 &
	xset s off -dpms &
	
	xrdb $HOME/.config/x11/xresources &
	~/.config/fixmonitors.sh

	pidof xcompmgr || xcompmgr &
       
	pidof mpd || mpd &
	/home/jackson/.local/bin/setbg &

	wmname LG3D &

	while true; do
		xsetroot -name \"$(status)\"
		sleep 5
	done

	";
     };
    };

}
