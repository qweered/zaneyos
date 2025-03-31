{ pkgs, ... }:

{
  home.packages = [ pkgs.clipse ];

  wayland.windowManager.hyprland.settings.exec-once = [ "clipse -listen" ];
}
