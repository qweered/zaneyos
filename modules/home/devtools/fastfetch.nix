{ homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/programs/fastfetch.nix" ];

  # CONFIG
  programs.fastfetch.enable = true;
}
