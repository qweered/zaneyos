{ homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/programs/bun.nix" ];
  programs.bun.enable = true;
}
