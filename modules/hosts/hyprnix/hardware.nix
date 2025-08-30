{ inputs, pkgs, ... }:

{
  # Host-specific settings
  imports = [ inputs.ucodenix.nixosModules.default ];
  services.ucodenix = {
    enable = true;
    cpuModelId = "00860F81"; # TODO: Run cpuid -1 -l 1 -r | sed -n 's/.*eax=0x\([0-9a-f]*\).*/\U\1/p' to retrieve processor's model ID
  };
  services.swapspace.enable = true; # dynamic swap file
  zramSwap.enable = true; # swap in zram

  # NOTE: a lot of mess comes from here https://github.com/NixOS/nixpkgs/blob/103ac534018bbc99254a1e0b043f423b855b55b6/nixos/modules/hardware/all-firmware.nix
  hardware.enableRedistributableFirmware = false;
  hardware.firmware = with pkgs; [
    linux-firmware
    # intel2200BGFirmware
    # rtl8192su-firmware
    # rt5677-firmware
    # rtl8761b-firmware
    # zd1211fw
    # alsa-firmware
    # sof-firmware
    # libreelec-dvb-firmware
  ];

  # NOTE: USB keyboards may become broken https://github.com/NixOS/nixpkgs/blob/22c3f2cf41a0e70184334a958e6b124fb0ce3e01/nixos/modules/system/boot/kernel.nix#L292
  boot.initrd.includeDefaultModules = false;
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "kvm-amd"
  ];
  hardware.cpu.amd.updateMicrocode = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3d95bf25-91a5-4fa7-b459-1f0d621f8e9d";
    fsType = "xfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C848-2DE0";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };
}
