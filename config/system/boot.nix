{ pkgs, config, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  # This is for OBS Virtual Cam Support - v4l2loopback setup
  # also maybe neeed v4l-utils in packages
  # boot.kernelModules = [ "v4l2loopback" ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
}
