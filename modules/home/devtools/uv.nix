{ homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/programs/uv.nix" ];

  programs.uv.enable = true;
}
