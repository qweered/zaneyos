{ pkgs, ... }:
{
  # TODO: manage versions other way?
  home.packages = with pkgs; [ nodejs ];
}
