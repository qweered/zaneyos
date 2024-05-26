{ pkgs, inputs, lib, host, ... }:

let inherit (import ../../hosts/${host}/options.nix) gpuType;
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
lib.mkIf ("${gpuType}" == "amd") {
  hardware.opengl = {
    package = pkgs-unstable.mesa.drivers;
    # if you also want 32-bit support (e.g for Steam)
    # driSupport32Bit = true;
    # package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
  };

# previous configs from zaneyos
#  systemd.tmpfiles.rules = [
#    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
#  ];
#  services.xserver.videoDrivers = [ "amdgpu" ];
#
#  hardware.opengl = {
#    extraPackages = [ pkgs.amdvlk ];
#    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
#  };

}
