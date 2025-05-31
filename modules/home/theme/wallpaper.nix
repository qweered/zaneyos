{ pkgs, ... }:
{
  # CONFIG: try hyprpaper
  services.swww.enable = true; # over mpvpaper (nice animations and video playback is too hungry anyway)

  home.packages = with pkgs; [
    waytrogen # over waypaper (250mb of bloat)
  ];
}
