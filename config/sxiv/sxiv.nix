{
  home.file = {
    ".config/sxiv/exec/key-handler" = {
      text = "
#!/usr/bin/env sh

# source dmenu settings
. $HOME/.config/dmenu/settings

while read file
do
        case \"$1\" in
        \"w\") setbg \"$file\" & ;;
        \"c\")
		[ -z \"$destdir\" ] && destdir=\"$(sed \"s/\\s.*#.*$//;/^\\s*$/d\" ${XDG_CONFIG_HOME:-$HOME/.config}/shell/bm-dirs | awk '{print $2}' | dmenu -h $DMENU_ARGUMENTS -l 20 -p \"Copy file(s) to where?\" | sed \"s|~|$HOME|g\")\"
		[ ! -d \"$destdir\" ] && notify-send \"$destdir is not a directory, cancelled.\" && exit
		cp \"$file\" \"$destdir\" && notify-send -i \"$(readlink -f \"$file\")\" \"$file copied to $destdir.\" &
		;;
        \"m\")
		[ -z \"$destdir\" ] && destdir=\"$(sed \"s/\\s.*#.*$//;/^\\s*$/d\" ${XDG_CONFIG_HOME:-$HOME/.config}/shell/bm-dirs | awk '{print $2}' | dmenu -h $DMENU_ARGUMENTS -l 20 -p \"Move file(s) to where?\" | sed \"s|~|$HOME|g\")\"
		[ ! -d \"$destdir\" ] && notify-send \"$destdir is not a directory, cancelled.\" && exit
		mv \"$file\" \"$destdir\" && notify-send -i \"$(readlink -f \"$file\")\" \"$file moved to $destdir.\" &
		;;
	\"r\")
		convert -rotate 90 \"$file\" \"$file\" ;;
	\"R\")
		convert -rotate -90 \"$file\" \"$file\" ;;
	\"f\")
		convert -flop \"$file\" \"$file\" ;;
	\"y\")
		echo -n \"$file\" | tr -d '\\n' | xclip -selection clipboard &&
		notify-send \"$file copied to clipboard\" & ;;
	\"Y\")
		readlink -f \"$file\" | tr -d '\n' | xclip -selection clipboard &&
			notify-send \"$(readlink -f \"$file\") copied to clipboard\" & ;;
	\"d\")
		[ \"$(printf \"No\\\\nYes\" | dmenu -h $DMENU_ARGUMENTS -p \"Really delete $file?\")\" = \"Yes\" ] && rm \"$file\" && notify-send \"$file deleted.\" ;;
	\"g\")	gimp && setsid -f gimp \"$file\" ;;
	\"i\")	notify-send \"File information\" \"$(mediainfo \"$file\")\" ;;
        esac
done
      "
    };
  };
}
