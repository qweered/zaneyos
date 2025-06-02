{ inputs, ... }:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  # CONFIG
  programs.nixcord.enable = true;

}
