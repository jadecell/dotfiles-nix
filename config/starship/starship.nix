{ config, pkgs, ... }:

{
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    add_newline = false;
    line_break = {
      disabled = true;
    };
    character = {
      success_symbol = "[ ](bold green)";
      error_symbol = "[ ](bold red)"; 
      vicmd_symbol = "[V](bold green) ";
    };
}
