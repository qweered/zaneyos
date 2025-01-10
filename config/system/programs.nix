{ pkgs, inputs, ... }:

{
  # Hyprland stuff
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
  };
  security.pam.services.hyprlock = { }; # Needed for hyprlock

  # File management
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  programs.xfconf.enable = true; # Store preferences
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # TODO: add aliases for unzip and zip
  programs.file-roller.enable = true; # lot slimmer than ark
}
