pkgs:
{
    enable = true;
    dotDir = ".config/zsh";
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
      g = "git";
      gs = "git status";
      ga = "git add -u";
      gaa = "git add .";
      gc = "git commit -m";
      gp = "git push origin master";
      gpa = "git push gitlab master && git push github master";

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

	export PATH="$PATH:$(find ~/.config/nixos/bin -type d -printf %p:)"
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
                du -a ~/.config/nixos/bin/* ~/.config/nixos/bin/cron/* ~/.config/nixos/bin/statusbar/* ~/.config/* ~/.config/nixos/bin/dmenu/scripts/* | awk '{print $2}' | fzf | xargs -r $EDITOR
                [ "$EDITOR" = "code" ] && exit
        }

        # Startup starship
	eval "$(starship init zsh)"

        # Autostart X if on default tty
        [ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg > /dev/null 2>&1 && exec startx
    '';

    history = {
        save = 1000;
        size = 1000;
        path = "$HOME/.cache/zsh_history";
    };

}
