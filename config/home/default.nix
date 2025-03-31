{ cfg, inputs, ... }:
{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./programs
    ./fish.nix
    ./devtools.nix
    ./git.nix
    ./easyeffects.nix
    ./theme
    ./hyprland
    ./suckless.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = cfg.username;
    homeDirectory = "/home/${cfg.username}";
    stateVersion = cfg.version;
  };

  news.display = "show";

  xdg = {

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
