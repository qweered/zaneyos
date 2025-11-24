{ pkgs, homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/programs/mpv.nix" ];

  # CONFIG
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "gpu-hq" ];
    scripts = [ pkgs.mpvScripts.mpris ];
  };
}
