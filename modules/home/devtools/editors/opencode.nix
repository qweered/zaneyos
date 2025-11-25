{ pkgs, homeModulesPath, ... }:

{
  imports = [ "${homeModulesPath}/programs/opencode.nix" ];

  # CONFIG
  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
  };
}
