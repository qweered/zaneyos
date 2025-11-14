{ pkgs, ... }:
let
  nix-direnv = pkgs.nix-direnv.override { nix = pkgs.lixPackageSets.git.lix; };
in
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    nix-direnv.package = nix-direnv;
  };

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };
}
