{ vars, ... }:

{
  programs.home-manager.enable = true;

  home = {
    inherit (vars) username;
    inherit (vars) stateVersion;
    inherit (vars) homeDirectory;
  };

  news.display = "show";

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
