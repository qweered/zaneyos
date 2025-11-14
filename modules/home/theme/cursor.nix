{ pkgs, ... }:

{
  # TODO: use hyprcursor instead, add HYPRCURSOR_SIZE, XCURSOR_SIZE to hyprland
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 18;
    gtk.enable = true;
    x11.enable = true;
  };
}
