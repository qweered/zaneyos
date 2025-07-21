{ lib, pkgs, ... }:
{
  environment.defaultPackages = lib.mkDefault [ ];
  programs.nano.enable = lib.mkDefault false;

  # Remove perl remnants https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/perlless.nix
  system.tools.nixos-generate-config.enable = lib.mkDefault false;
  programs.less.lessopen = lib.mkDefault null;
  boot.enableContainers = lib.mkDefault false;

  # Note: system.forbiddenDependenciesRegexes can cause build issues
  # Check for perl dependencies manually if needed with: nix path-info -r /run/current-system | grep perl

  # Replace coreutils with uutils for better performance and memory usage
  environment.systemPackages = [
    pkgs.uutils-findutils
    pkgs.uutils-diffutils
    pkgs.uutils-coreutils-noprefix
  ];

  services.dbus.implementation = "broker"; # modern dbus implementation
  programs.command-not-found.enable = lib.mkDefault false; # will be false by default soon
  systemd.enableStrictShellChecks = true; # will become default
  
  # Note: system.etc.overlay.enable can cause system instability on some configurations
  # Enable manually if needed: system.etc.overlay.enable = true;
}
