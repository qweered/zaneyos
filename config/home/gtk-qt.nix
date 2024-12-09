{ pkgs, config, lib, ... }:

# TODO: add HYPRCURSOR_SIZE, XCURSOR_SIZE to hyprland
# This is all mess right now

let
  KvLibadwaita = pkgs.fetchFromGitHub {
    owner = "GabePoel";
    repo = "KvLibadwaita";
    rev = "87c1ef9f44ec48855fd09ddab041007277e30e37";
    hash = "sha256-K/2FYOtX0RzwdcGyeurLXAh3j8ohxMrH2OWldqVoLwo=";
    sparseCheckout = [ "src" ];
  };

  qtctConf = {
    Appearance = {
      custom_palette = false;
      icon_theme = config.gtk.iconTheme.name;
      standard_dialogs = "xdgdesktopportal";
      style = "kvantum";
    };
  };

  defaultFont = "${config.gtk.font.name},${builtins.toString config.gtk.font.size}";
in
{
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    font = {
      name = "Inter";
      package = pkgs.google-fonts.override { fonts = [ "Inter" ]; };
      size = 12;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  home.packages = with pkgs; [
    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
  ];

  xdg.configFile = {
    # Kvantum config
    "Kvantum" = {
      source = "${KvLibadwaita}/src";
      recursive = true;
    };

    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=KvLibadwaitaDark
    '';

    # qtct config
    "qt5ct/qt5ct.conf".text =
      let
        default = ''"${defaultFont},-1,5,50,0,0,0,0,0"'';
      in
      lib.generators.toINI { } (
        qtctConf
        // {
          Fonts = {
            fixed = default;
            general = default;
          };
        }
      );

    "qt6ct/qt6ct.conf".text =
      let
        default = ''"${defaultFont},-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
      in
      lib.generators.toINI { } (
        qtctConf
        // {
          Fonts = {
            fixed = default;
            general = default;
          };
        }
      );
  };
}
