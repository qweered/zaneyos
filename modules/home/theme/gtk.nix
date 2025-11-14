{ pkgs, ... }:

{
  # Imperative configuration through quickshell
  home.packages = with pkgs; [
    # over lxappearance
    nwg-look

    adw-gtk3
    papirus-icon-theme
  ];
}
