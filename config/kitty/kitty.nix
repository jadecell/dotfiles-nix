pkgs:
{
  enable = true;
  font = {
    name = "RobotoMono Nerd Font Heavy";
    size = 13;
  };
  settings = {
    disable_ligatures = false;
    scrollback_lines = 10000;
    window_padding_width = 1;
    background_opacity = "0.9";
    term = "st-256color";

    # Cursor 
    cursor_shape = "beam";
    cursor = "#c0caf5";
    cursor_blink_interval = -1;

    # Colors
    background = "#1a1b26";
    foreground = "#c0caf5";

    ## black
    color0 = "#1f2335";
    color8 = "#3b4261";

    ## red
    color1 = "#db4b4b";
    color9 = "#db4b4b";

    ## green
    color2 = "#9ece6a";
    color10 = "#9ece6a";

    ## yellow
    color3 = "#e0af68";
    color11 = "#e0af68";

    ## blue
    color4 = "#7aa2f7";
    color12 = "#7aa2f7";

    ## magenta
    color5 = "#bb9af7";
    color13 = "#bb9af7";

    ## cyan
    color6 = "#2ac3d3";
    color14 = "#2ac3d3";

    ## white
    color7 = "#c0caf5";
    color15 = "#c0caf5";
  };
  keybindings = {
    "alt+c" = "copy_to_clipboard";
    "alt+v" = "paste_from_clipboard";
    "alt+k" = "scroll_line_up";
    "alt+j" = "scroll_line_down";
  };
}
