{ pkgs, config, ... }:

{
  # home.file.".face.icon".source = ./files/face.jpg; # For SDDM
  # CONFIG: add HYPRCURSOR_SIZE, XCURSOR_SIZE to hyprland
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

  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    font = {
      name = "Inter";
      package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
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

    #    gtk2.extraConfig = {};
    #    gtk3.bookmarks = [];
    #    gtk3.extraConfig = {};
    #    gtk4.extraConfig = {};
    #    gtk4.extraCSS = "";

  };
}
