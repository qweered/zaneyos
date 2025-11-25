{ homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/services/mpd.nix" ];

  services.mpd.enable = true;
}
