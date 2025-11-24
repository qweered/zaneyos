{ homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/programs/zoxide.nix" ];

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
}
