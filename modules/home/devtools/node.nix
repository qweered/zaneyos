{ pkgs, ... }:
{
  # TODO: manage versions other way?
  home.packages = [ pkgs.nodejs ];
}
