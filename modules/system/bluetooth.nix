{ pkgs, ... }:

{
  # CONFIG: https://wiki.nixos.org/wiki/Bluetooth
  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };
  environment.systemPackages = [ pkgs.overskride ]; # over blueman, bluetuith
}
