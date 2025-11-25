{ homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/programs/yazi.nix" ];

  programs.yazi.enable = true;
}
