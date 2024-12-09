{ lib, ... }:

{
  # TODO: a lot of mess comes from here https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/hardware/all-firmware.nix
  hardware.enableRedistributableFirmware = true;

  # NOTE: USB keyboards may be broken https://github.com/NixOS/nixpkgs/blob/22c3f2cf41a0e70184334a958e6b124fb0ce3e01/nixos/modules/system/boot/kernel.nix#L292
  boot.initrd.includeDefaultModules = false;
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" ];
  boot.kernelModules = [ "kvm-amd" ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/3d95bf25-91a5-4fa7-b459-1f0d621f8e9d";
      fsType = "xfs";
    };

  fileSystems."/boot" = lib.mkForce
    {
      device = "/dev/disk/by-uuid/C848-2DE0";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ]; # TODO: do i need this?

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true; # TODO: am i even need this?
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault true;
}
