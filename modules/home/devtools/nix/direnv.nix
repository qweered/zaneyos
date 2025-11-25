{ pkgs, homeModulesPath, ... }:
let
  nix-direnv = pkgs.nix-direnv.override { nix = pkgs.lixPackageSets.latest.lix; };
in
{
  imports = [ "${homeModulesPath}/programs/direnv.nix" ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    nix-direnv.package = nix-direnv;
  };

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };
}
