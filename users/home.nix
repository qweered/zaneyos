{ cfg, inputs, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
    ./../config/home
  ];

  programs.home-manager.enable = true;

  home = {
    username = cfg.username;
    homeDirectory = "/home/${cfg.username}";
    stateVersion = cfg.version;
  };

  news.display = "show";

  xdg = {
    #    terminal-exec.enable = true;
    #    terminal-exec.package = pkgs.alacritty; # TODO: only in system now
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
