{
  home.file = {
      ".config/fixmonitors.sh" = {
      executable = true;
      text = "
        #!/bin/sh
        xrandr --output DVI-D-1 --off --output DP-1 --mode 1920x1080 --pos 1920x0 --rate 239.96 --rotate normal --output DP-2 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-3 --off
      ";
    };
  };
}
