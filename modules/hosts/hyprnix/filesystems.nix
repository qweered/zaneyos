{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/3d95bf25-91a5-4fa7-b459-1f0d621f8e9d";
      fsType = "xfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/C848-2DE0";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };
}
