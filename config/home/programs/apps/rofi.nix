{ pkgs, ... }:
{
  # CONFIG
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
}
