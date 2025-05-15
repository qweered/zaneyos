{ inputs, cfg, ... }:
{
  imports = [
    inputs.nvf.homeManagerModules.default
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
