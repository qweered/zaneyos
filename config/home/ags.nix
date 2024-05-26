{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];


  home.packages = with pkgs; [
       dart-sass
       fd
       swww
       inputs.matugen.packages.${system}.default
       slurp
       wf-recorder
       wl-clipboard
       wayshot
       swappy
       hyprpicker
       gtk3
  ];

  programs.ags = {
    enable = true;
    configDir = ../ags;
    extraPackages = with pkgs; [
      accountsservice
    ];
  };
}
