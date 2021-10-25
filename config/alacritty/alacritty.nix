pkgs:
{
  enable = true;
  settings = {
    window = {
      dynamic_title = true;
      dynamic_padding = false;
      title = "Alacritty";
      class = {
        instance = "Alacritty";
        general = "Alacritty";
      };
      gtk_theme_variant = "None";
    };

    scrolling = {
      history = 10000;
      multiplier = 1;
    };

    font = {
      normal = {
        family = "RobotoMono Nerd Font";
        style = "Medium";
      };
      size = 13;
      offset = {
        x = -1;
        y = -1;
      };
      glyph_offset = {
        x = 0;
        y = 0;
      };
    };

    draw_bold_text_with_bright_colors = false;

    colors = {
      primary = {
        background = "#1a1b26";
        foreground = "#c0caf5";
      };

      cursor = {
        text = "#292e42";
        cursor = "#c0caf5";
      };

      selection = {
        text = "#292e42";
        background = "#c0caf5";
      };

      normal = {
        black = "#1f2335";
        red = "#db4b4b";
        green = "#9ece6a";
        yellow = "#e0af68";
        blue = "#7aa2f7";
        magenta = "#bb9af7";
        cyan = "#2ac3de";
        white = "#c0caf5";
      };

      bright = {
        black = "#3b4261";
        red = "#db4b4b";
        green = "#9ece6a";
        yellow = "#e0af68";
        blue = "#7aa2f7";
        magenta = "#bb9af7";
        cyan = "#2ac3de";
        white = "#c0caf5";
      };
    };

    bell = {
      animation = "EaseOutExpo";
      duration = 0;
      color = "#ffffff";
    };

    background_opacity = 0.9;

    selection = {
      semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
      save_to_clipboard = false;
    };

    cursor = {
      style = "Underline";
      unfocused_hollow = true;
      vi_mode_style = "Block";
    };

    live_config_reload = true;

    working_directory = "None";

    key_bindings = [
      {
        key = "V"; 
        mods = "Alt"; 
        action = "Paste";
      }

      {
        key = "C"; 
        mods = "Alt"; 
        action = "Copy";
      }
    ];

    debug = {
      render_time = false;
      persistent_logging = false;
      log_level = "Warn";
      print_events = false;
    };
  };
}
