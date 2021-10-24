{ config, pkgs, ... }:

let
    # Import all external config files
    zshsettings = import ./zsh/zsh.nix;
    firefoxsettings = import ./firefox/firefox.nix;
    starshipsettings = import ./starship/starship.nix; 
    zathurasettings = import ./zathura/zathura.nix;
    alacrittysettings = import ./alacritty/alacritty.nix;
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
  imports = [ 
    ./fixmonitors/fixmonitors.nix 
  ];
  programs.zsh = zshsettings pkgs;
  programs.firefox = firefoxsettings pkgs;
  programs.starship = starshipsettings pkgs;
  programs.zathura = zathurasettings pkgs;
  programs.alacritty = alacrittysettings pkgs;

  fonts.fontconfig.enable = true;

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
	   echo \"$(sb-news) | $(sb-cpuperc dwm) | $(sb-memory dwm) | $(sb-cputemp) | $(sb-clock dwm) | $(sb-networking dwm) \" 
	}	

	xset r rate 300 50 &
	xset s off -dpms &
	
	xrdb $HOME/.config/x11/xresources &
	~/.config/fixmonitors.sh

	pidof xcompmgr || xcompmgr &
       
	pidof mpd || mpd &
	setbg &

        pidof udiskie || udiskie --tray &

	while true; do
		xsetroot -name \"$(status)\"
		sleep 5
	done

	";
     };

     ".xinitrc" = {
     text = " 
        #!/bin/sh

        if test -z \"$DBUS_SESSION_BUS_ADDRESS\"; then
                eval $(dbus-launch --exit-with-session --sh-syntax)
        fi
        systemctl --user import-environment DISPLAY XAUTHORITY

        if command -v dbus-update-activation-environment >/dev/null 2>&1; then
                dbus-update-activation-environment DISPLAY XAUTHORITY
        fi

        export ZDOTDIR=\"$HOME/.config/zsh\"
        exec dwm
        ";
    };
  };

}
