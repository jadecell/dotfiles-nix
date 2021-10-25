pkgs:
{
  enable = true;
  mpdMusicDir = "/home/jackson/.config/mpd";
  settings = {
    autocenter_mode = true;
    follow_now_playing_lyrics = true;
    ignore_leading_the = true;
    ignore_diacritics = true;
    default_place_to_search_in = "database";

    # Display Modes
    playlist_editor_display_mode = "columns";
    search_engine_display_mode = "columns";
    browser_display_mode = "columns";
    playlist_display_mode = "columns";

    # General Colors
    colors_enabled = true;
    main_window_color = "white";
    header_window_color = "cyan";
    volume_color = "green";
    statusbar_color = "white";
    progressbar_color = "cyan";
    progressbar_elapsed_color = "white";

    # Song List
    song_columns_list_format = "(10)[blue]{l} (30)[green]{t} (30)[magenta]{a} (30)[yellow]{b}";
    song_list_format = "{$7%a - $9}{$5%t$9}|{$5%f$9}$R{$6%b $9}{$3%l$9}";

    # Current Prefix
    current_item_prefix = "$(blue)$r";
    current_item_suffix = "$/r$(end)";
    current_item_inactive_column_prefix = "$(cyan)$r";

    # Alternative Interface
    user_interface = "alternative";
    alternative_header_first_line_format = "$0$aqqu$/a {$6%a$9 - }{$3%t$9}|{$3%f$9} $0$atqq$/a$9";
    alternative_header_second_line_format = "{{$4%b$9}{ [$8%y$9]}}|{$4%D$9}";

    # Classic Interface
    song_status_format = " $6%a $7⟫⟫ $3%t $7⟫⟫ $4%b ";

    # Navigation
    cyclic_scrolling = true;
    header_text_scrolling = true;
    jump_to_now_playing_song_at_start = true;
    lines_scrolled = "2";

    # Other
    system_encoding = "utf-8";
    regular_expressions = "extended";

    # Selected tracks
    selected_item_prefix = "* ";
    discard_colors_if_item_is_selected = true;

    # Seeking
    incremental_seeking = true;
    seek_time = "1";

    # Visibility
    header_visibility = true;
    statusbar_visibility = true;
    titles_visibility = true;

    # Progress Bar
    progressbar_look = "=>-";

    # Now playing
    now_playing_prefix = "> ";
    centered_cursor = true;

    # Misc
    display_bitrate = true;
    enable_window_title = true;
    empty_tag_marker = "";
  };

  bindings = [
    { key = "t"; command = "find"; }
    { key = "t"; command = "find_item_forward"; }
    { key = "+"; command = "show_clock"; }
    { key = "="; command = "volume_up"; }
    { key = "j"; command = "scroll_down"; }
    { key = "k"; command = "scroll_up"; }
    { key = "ctrl-u"; command = "page_up"; }
    { key = "ctrl-d"; command = "page_down"; }
    { key = "h"; command = "previous_column"; }
    { key = "l"; command = "next_column"; }
    { key = "."; command = "show_lyrics"; }
    { key = "n"; command = "next_found_item"; }
    { key = "N"; command = "previous_found_item"; }
    { key = "J"; command = "move_sort_order_down"; }
    { key = "K"; command = "move_sort_order_up"; }
    { key = "g"; command = "move_home"; }
    { key = "G"; command = "move_end"; }
  ];
}
