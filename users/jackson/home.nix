{ config, pkgs, ... }:

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

  # Firefox settings
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        decentraleyes
        bitwarden
        ublock-origin
        clearurls
        sponsorblock
        darkreader
        h264ify
        df-youtube
    ];
    profiles.jackson = {
        settings = {
            "media.peerconnection.enabled" = false;
            "media.peerconnection.turn.disable" = true;
            "media.peerconnection.use_document_iceservers" = false;
            "media.peerconnection.video.enabled" = false;
            "media.peerconnection.identity.timeout" = 1;
            "privacy.firstparty.isolate" = true;
            "privacy.resistFingerprinting" = true;
            "privacy.trackingprotection.fingerprinting.enabled" = true;
            "privacy.trackingprotection.cryptomining.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.donottrackheader.enabled" = true;
            "browser.send_pings" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.warnOnClose" = false;
            "browser.urlbar.speculativeConnect.enabled" = false;
            "dom.event.clipboardevents.enabled" = false;
            "dom.forms.autocomplete.formautofill" = false;
            "media.navigator.enabled" = false;
            "network.cookie.cookieBehavior" = 1;
            "network.http.referer.XOriginPolicy" = 2;
            "network.http.referer.XOriginTrimmingPolicy" = 2;
            "beacon.enabled" = false;
            "browser.safebrowsing.downloads.remote.enabled" = false;
            "network.dns.disablePrefetch" = true;
            "network.dns.disablePrefetchFromHTTPS" = true;
            "network.predictor.enabled" = false;
            "network.predictor.enable-prefetch" = false;
            "network.prefetch-next" = false;
            "network.IDN_show_punycode" = true;
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "app.shield.optoutstudies.enabled" = false;
            "dom.security.https_only_mode_ever_enabled" = true;
            "dom.security.https_only_mode" = true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.search.suggest.enabled" = false;
            "browser.urlbar.shortcuts.bookmarks" = false;
            "browser.urlbar.shortcuts.history" = false;
            "browser.urlbar.shortcuts.tabs" = false;
            "browser.urlbar.suggest.bookmark" = false;
            "browser.urlbar.suggest.engines" = false;
            "browser.urlbar.suggest.history" = false;
            "browser.urlbar.suggest.openpage" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.uidensity" = 1;
            "media.autoplay.enabled" = false;
            "media.eme.enabled" = true;
            "extensions.pocket.enabled" = false;
            "identity.fxaccounts.enabled" = false;
            "toolkit.zoomManager.zoomValues" = ".8,.95,1,1.1,1.2";
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.pioneer-new-studies-available" = false;
            "signon.autofillForms" = false;
            "signon.generation.enabled" = false;
            "toolkit.telemetry.cachedClientID" = "c0ffeec0-ffee-c0ff-eec0-ffeec0ffeec0";
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "browser.safebrowsing.downloads.remote.block_dangerous" = false;
            "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
            "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
            "browser.safebrowsing.downloads.remote.block_uncommon" = false;
        };
        userChrome = "
            * { 
                box-shadow: none !important;
                border: 0px solid !important;
            }
        ";
    };

  };

  # Configure git
  programs.git = {
    enable = true;
    userName = "Jackson McCrory";
    userEmail = "jackson@mccrory.xyz";
  };

  # Configure zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    plugins = [

        {
          name = "zsh-syntax-highlighting";
	  src = pkgs.fetchFromGitHub {
	      owner = "zsh-users";
	      repo = "zsh-syntax-highlighting";
	      rev = "0.7.1";
	      sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
	  };
        }

    ];

    shellAliases = {

      # Verbosity
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -Iv";
      bc = "bc -ql";
      mkdir = "mkdir -pv";
      ffmpeg = "ffmpeg -hide_banner";

      # Youtube-dl
      yta-aac = "youtube-dl --extract-audio --audio-format aac ";
      yta-best = "youtube-dl --extract-audio --audio-format best ";
      yta-flac = "youtube-dl --extract-audio --audio-format flac ";
      yta-m4a = "youtube-dl --extract-audio --audio-format m4a ";
      yta-mp3 = "youtube-dl --extract-audio --audio-format mp3 ";
      yta-opus = "youtube-dl --extract-audio --audio-format opus ";
      yta-vorbis = "youtube-dl --extract-audio --audio-format vorbis ";
      yta-wav = "youtube-dl --extract-audio --audio-format wav ";
      ytv-best = "youtube-dl -f bestvideo+bestaudio ";

      # systemD
      S = "sudo systemctl";

      # Change Directory 
      cd1 = "cd ..";
      cd2 = "cd ../..";
      cd3 = "cd ../../..";
      cd4 = "cd ../../../..";
      cd5 = "cd ../../../../..";
      cd6 = "cd ../../../../../..";

      # Colorize commands
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";

      # Shorten long commands
      ka = "killall";
      sdn = "shutdown now";
      v = "nvim";
      c = "vscode";
      cat = "bat";

      # List files and directories
      ls = "lsd -Al --color=always --group-dirs first";

      # Git
      lg = "lazygit";
      g = "/usr/bin/git";
      gs = "/usr/bin/git status";
      ga = "/usr/bin/git add -u";
      gaa = "/usr/bin/git add .";
      gc = "/usr/bin/git commit -m";
      gp = "/usr/bin/git push origin master";
      gpa = "/usr/bin/git push gitlab master && /usr/bin/git push github master";

      # Applications
      se = "sudoedit";

      # University class folders
      m1140 = "cd $HOME/Nextcloud/School/KPU/Year-1/Term-1/MATH-1140/ && ls";
      m1115 = "cd $HOME/Nextcloud/School/KPU/Year-1/Term-1/MATH-1115/ && ls";
      i1113 = "cd $HOME/Nextcloud/School/KPU/Year-1/Term-1/INFO-1113/ && ls";
      i1213 = "cd $HOME/Nextcloud/School/KPU/Year-1/Term-1/INFO-1213/ && ls";
      i1214 = "cd $HOME/Nextcloud/School/KPU/Year-1/Term-1/INFO-1214/ && ls";
      i1111 = "cd $HOME/Nextcloud/School/KPU/Year-1/Summer/INFO-1111/ && ls";

    }; 

    initExtra = ''
	### "bat" as manpager
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"

	### "nvim" as manpager
	# export MANPAGER="nvim -c 'set ft=man' -"

	# XDG Exports
	export XDG_CONFIG_HOME="$HOME/.config"
	export XDG_DATA_HOME="$HOME/.local/share"
	export XDG_CACHE_HOME="$HOME/.cache"

	# Cleanup
	export ZDOTDIR="HOME/.config/zsh"
	export XINITRC="HOME/.config/x11/xinitrc"
	export XRESOURCES="$HOME/.config/x11/xresources"
	export ANDROID_SDK_HOME="$HOME/.config/android"
	export CARGO_HOME="$HOME/.local/share/cargo"
	export GOPATH="$HOME/.local/share/go"
	export ANSIBLE_CONFIG="$HOME/.config/ansible/ansible.cfg"
	export UNISON="$HOME/.local/share/unison"
	export HISTFILE="$HOME/.local/share/history"
	export WEECHAT_HOME="$HOME/.config/weechat"
	export ELECTRUMDIR="$HOME/.local/share/electrum"
	export WINEPREFIX="$HOME/.local/share/wineprefixes/default"
	export LESSHISTFILE="-"

	# Default Applications
	export EDITOR="nvim"
	export BROWSER="firefox"
	export TERMINAL="alacritty"

	# General
	export PATH="$PATH:/home/jackson/.emacs.d/bin:$(find ~/.local/repos/dotfiles/home/.local/bin -type d -printf %p:)"
	export QT_QPA_PLATFORMTHEME="qt5ct"
	export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
	export SUDO_ASKPASS="$HOME/.config/dmenu/scripts/dmenu-pass.sh"
	export MOZ_USE_XINPUT2="1"           # Mozilla smooth scrolling/touchpads.
	export _JAVA_AWT_WM_NONREPARENTING=1 # Fix for Java applications in dwm

	export LF_ICONS="di=📁:\
	fi=📃:\
	tw=🤝:\
	ow=📂:\
	ln=⛓:\
	or=❌:\
	ex=🎯:\
	*.txt=✍:\
	*.mom=✍:\
	*.me=✍:\
	*.ms=✍:\
	*.png=🖼:\
	*.webp=🖼:\
	*.ico=🖼:\
	*.jpg=📸:\
	*.jpe=📸:\
	*.jpeg=📸:\
	*.gif=🖼:\
	*.svg=🗺:\
	*.tif=🖼:\
	*.tiff=🖼:\
	*.xcf=🖌:\
	*.html=🌎:\
	*.xml=📰:\
	*.gpg=🔒:\
	*.css=🎨:\
	*.pdf=📚:\
	*.djvu=📚:\
	*.epub=📚:\
	*.csv=📓:\
	*.xlsx=📓:\
	*.tex=📜:\
	*.md=📘:\
	*.r=📊:\
	*.R=📊:\
	*.rmd=📊:\
	*.Rmd=📊:\
	*.m=📊:\
	*.mp3=🎵:\
	*.opus=🎵:\
	*.ogg=🎵:\
	*.m4a=🎵:\
	*.flac=🎼:\
	*.wav=🎼:\
	*.mkv=🎥:\
	*.mp4=🎥:\
	*.webm=🎥:\
	*.mpeg=🎥:\
	*.avi=🎥:\
	*.mov=🎥:\
	*.mpg=🎥:\
	*.wmv=🎥:\
	*.m4b=🎥:\
	*.flv=🎥:\
	*.zip=📦:\
	*.rar=📦:\
	*.7z=📦:\
	*.tar.gz=📦:\
	*.z64=🎮:\
	*.v64=🎮:\
	*.n64=🎮:\
	*.gba=🎮:\
	*.nes=🎮:\
	*.gdi=🎮:\
	*.1=ℹ:\
	*.nfo=ℹ:\
	*.info=ℹ:\
	*.log=📙:\
	*.iso=📀:\
	*.img=📀:\
	*.bib=🎓:\
	*.ged=👪:\
	*.part=💔:\
	*.torrent=🔽:\
	*.jar=♨:\
	*.java=♨:\
	"
        webup() {
                folder=$(pwd | cut -d'/' -f6)
                /usr/bin/rsync -rtvzP "$(pwd)/" "root@mccrory.xyz:/var/www/$folder"
        }

        sec() {
                du -a ~/.local/bin/* ~/.local/bin/cron/* ~/.local/bin/statusbar/* ~/.config/* ~/.config/dmenu/scripts/* | awk '{print $2}' | fzf | xargs -r $EDITOR
                [ "$EDITOR" = "code" ] && exit
        }

	eval "$(starship init zsh)"

    '';

    history = {
        save = 1000;
        size = 1000;
        path = "$HOME/.cache/zsh_history";
    };

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
