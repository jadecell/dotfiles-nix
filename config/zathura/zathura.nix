pkgs:
{
    enable = true;

    options = {
      default-bg = "#1e1e1e"; 
      default-fg = "#d8dee9"; 
      statusbar-bg = "#2a2a2a";
      statusbar-fg = "#d8dee9";
      inputbar-bg = "#2a2a2a";
      inputbar-fg = "#c586c0";
      index-bg = "#2a2a2a";
      index-fg = "#d8dee9";
      index-active-bg = "#29b8db";
      index-active-fg = "#2a2a2a";
      notification-bg = "#23d18b";
      notification-fg = "#2a2a2a";
      notification-error-bg = "#d54646";
      notification-error-fg = "#2a2a2a";
      notification-warning-bg = "#d7ba7d";
      notification-warning-fg = "#2a2a2a";
      highlight-color = "#d54646";
      highlight-active-color = "#569cd6";
      completion-bg = "#2a2a2a";
      completion-fg = "#569cd6";
      completion-highlight-bg = "#23d18b";
      completion-highlight-fg = "#d8dee9";
      recolor-lightcolor = "#2a2a2a";
      recolor-darkcolor = "#d8dee9";
      statusbar-home-tilde = true;
      adjust-open = "width";
      recolor = true;
      selection-clipboard = "clipboard";
      font = "RobotoMono Nerd Font 8";
    };

  extraConfig = "
  map <Left> navigate previous
  map <Right> navigate next
  map <C-=> zoom in
  map <C--> zoom out
  map B jumplist backward
  map b jumplist forward
  ";
}
