{ pkgs, ... }:

{
  # home.file.".face.icon".source = ./files/face.jpg; # For SDDM
  # CONFIG: add HYPRCURSOR_SIZE, XCURSOR_SIZE to hyprland
  imports = [
    ./gtk.nix
    ./qt.nix
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    hyprcursor.size = 24;
    gtk.enable = true;
    hyprcursor.enable = true;
    # CONFIG: remove when x11 die (maybe now?)
    x11.enable = true;
  };
}
