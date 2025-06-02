{ vars, ... }:
{
  programs.home-manager.enable = true;

  home = {
    username = vars.username;
    homeDirectory = "/home/${vars.username}";
    stateVersion = vars.stateVersion;
  };

  news.display = "show";

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
