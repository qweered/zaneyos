{ config, pkgs, ... }:

{
  imports = [
    ./amd-gpu.nix
    ./appimages.nix
    ./boot.nix
    ./displaymanager.nix
    ./flatpak.nix
    ./kernel.nix
    ./keyboard.nix
    ./packages.nix
    ./polkit.nix
    ./services.nix
    ./vm.nix
  ];
}
