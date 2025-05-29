{ pkgs, ... }:
{
  # CONFIG: is this possible in nix?
  home.packages = with pkgs; [ equibop ];
}
