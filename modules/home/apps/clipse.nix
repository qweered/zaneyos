{
  pkgs,
  lib,
  config,
  ...
}:

{
  home.packages = [ pkgs.clipse ];

  wayland.windowManager.hyprland = lib.mkIf config.wayland.windowManager.hyprland.enable {
    settings.exec-once = [ "clipse -listen" ];
  };
}
