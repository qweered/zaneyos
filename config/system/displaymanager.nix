{ pkgs, ... }:

{
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sugar-dark";
      extraPackages = with pkgs; [ libsForQt5.qt5.qtgraphicaleffects ];
    };
    displayManager.defaultSession = "hyprland";
  };

  environment.systemPackages = with pkgs; [
    sddm-sugar-dark
  ];
}
