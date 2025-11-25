{ homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/programs/starship.nix" ];

  # CONFIG
  programs.starship.enable = true;
}
