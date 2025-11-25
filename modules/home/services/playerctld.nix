{ homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/services/playerctld.nix" ];

  # control mpris players through console
  services.playerctld.enable = true;
}
