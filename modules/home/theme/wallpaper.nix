{ pkgs, ... }:
{
  # CONFIG: try hyprpaper, wpaperd
  services.swww.enable = true; # over mpvpaper (nice animations and video playback is too hungry anyway), swaybg (static-only)

  home.packages = with pkgs; [
    waytrogen # over waypaper (250mb of bloat)
  ];
}
