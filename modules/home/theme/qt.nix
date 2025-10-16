_: {
  # qt = {
  #   enable = true;
  #   platformTheme.name = "qtct";
  # };

  # home.packages = with pkgs; [
  #   kdePackages.qtstyleplugin-kvantum
  #   kdePackages.qt6ct
  #   libsForQt5.qtstyleplugin-kvantum
  #   libsForQt5.qt5ct
  # ];

  # xdg.configFile = {
  #   "Kvantum" = {
  #     source = "${KvLibadwaita}/src";
  #     recursive = true;
  #   };

  #   "Kvantum/kvantum.kvconfig".text = ''
  #     [General]
  #     theme=KvLibadwaitaDark
  #   '';

  #   "qt5ct/qt5ct.conf".text =
  #     let
  #       default = ''"${defaultFont},-1,5,50,0,0,0,0,0"'';
  #     in
  #     lib.generators.toINI { } (
  #       qtctConf
  #       // {
  #         Fonts = {
  #           fixed = default;
  #           general = default;
  #         };
  #       }
  #     );

  #   "qt6ct/qt6ct.conf".text =
  #     let
  #       default = ''"${defaultFont},-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
  #     in
  #     lib.generators.toINI { } (
  #       qtctConf
  #       // {
  #         Fonts = {
  #           fixed = default;
  #           general = default;
  #         };
  #       }
  #     );
  # };
}
