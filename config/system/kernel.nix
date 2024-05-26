{ config, lib, pkgs, host, ... }:

let
  hostOptions = import ../../hosts/${host}/options.nix;
  kernelOptions = {
    latest = pkgs.linuxPackages_latest;
    lqx = pkgs.linuxPackages_lqx;
    testing = pkgs.linuxPackages_testing;
    xanmod = pkgs.linuxPackages_xanmod_latest;
    zen = pkgs.linuxPackages_zen;
  };
  selectedKernel = kernelOptions.${hostOptions.kernel};
  defaultKernel = pkgs.linuxPackages;

  kernel = if selectedKernel != null then selectedKernel else defaultKernel;
in
{
  boot.kernelPackages = kernel;
}
