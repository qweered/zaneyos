{
  pkgs,
  config,
  ...
}:
{

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
