{ pkgs, config, host, ... }:

{
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "tokyo-night-sddm";
    };
  };

  environment.systemPackages =
let
    sugar = pkgs.callPackage ../sddm-themes/sddm-sugar-dark.nix {};
    tokyo-night = pkgs.libsForQt5.callPackage ../sddm-themes/sddm-tokyo-night.nix {};
in [ 
    sugar.sddm-sugar-dark # Name: sugar-dark
    tokyo-night # Name: tokyo-night-sddm
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}
