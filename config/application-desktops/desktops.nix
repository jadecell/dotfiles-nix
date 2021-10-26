{ pkgs, ... }:

{
    home.file = {
        ".local/share/applications/file.desktop" = {
            text = "
[Desktop Entry]
Type=Application
Name=File Manager
Exec=${pkgs.alacritty}/bin/alacritty -e lf %u
            ";
        };

        ".local/share/applications/pdf.desktop" = {
            text = "
[Desktop Entry]
Type=Application
Name=PDF reader
Exec=${pkgs.zathura}/bin/zathura %u
            ";
        };

        ".local/share/applications/torrent.desktop" = {
            text = "
[Desktop Entry]
Type=Application
Name=torrent
Exec=/home/jackson/.config/nixos/bin/transadd %U
            ";
        };
    };
}
