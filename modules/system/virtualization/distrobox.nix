{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.distrobox ];
}
