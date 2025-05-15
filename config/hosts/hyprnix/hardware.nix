{ lib, inputs, ... }:

{
  # NOTE: a lot of mess comes from here https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/hardware/all-firmware.nix
  hardware.enableRedistributableFirmware = true;

  # NOTE: USB keyboards may become broken https://github.com/NixOS/nixpkgs/blob/22c3f2cf41a0e70184334a958e6b124fb0ce3e01/nixos/modules/system/boot/kernel.nix#L292
  boot.initrd.includeDefaultModules = false;
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
  ];
  boot.kernelModules = [ "kvm-amd" ];

  imports = [ inputs.ucodenix.nixosModules.default ];
  services.ucodenix = {
    enable = true;
    cpuModelId = "00860F81"; # TODO: Run cpuid -1 -l 1 -r | sed -n 's/.*eax=0x\([0-9a-f]*\).*/\U\1/p' to retrieve processor's model ID
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3d95bf25-91a5-4fa7-b459-1f0d621f8e9d";
    fsType = "xfs";
  };

  fileSystems."/boot" = lib.mkForce {
    device = "/dev/disk/by-uuid/C848-2DE0";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault true;
}
