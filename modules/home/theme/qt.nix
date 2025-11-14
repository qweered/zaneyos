{ pkgs, ... }:

{
  # Imperative configuration through quickshell
  home.packages = with pkgs; [
    kdePackages.qt6ct
    libsForQt5.qt5ct
  ];
}
