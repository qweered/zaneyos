{ pkgs, ... }:

let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    # CONFIG:
    #    themeConfig = {
    #    };
    # See: https://github.com/Keyitdev/sddm-astronaut-theme
    embeddedTheme = "hyprland_kath";
  };
in

{
  services.displayManager = {
    defaultSession = "hyprland-uwsm";
    sddm = {
      enable = true;
      wayland.enable = true;
      wayland.compositor = "weston"; # lighter than kwin
      theme = "sddm-astronaut-theme"; # name of theme package
      extraPackages = [ sddm-astronaut ];
    };
  };

  environment.systemPackages = [ sddm-astronaut ];
}
