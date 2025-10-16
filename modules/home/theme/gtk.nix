{
  pkgs,
  config,
  lib,
  ...
}:

{
  # home.file.".face.icon".source = ./files/face.jpg; # For SDDM
  # CONFIG: add HYPRCURSOR_SIZE, XCURSOR_SIZE to hyprland
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
    gtk.enable = true;
    x11.enable = true;
  };

  xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;

  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts-cjk-sans;
      size = 12;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };
}
