{ homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/programs/rofi.nix" ];

  # CONFIG
  programs.rofi = {
    enable = true;
  };
}
