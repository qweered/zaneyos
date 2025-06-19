{ lib, pkgs, ... }:
{
  environment.defaultPackages = lib.mkDefault [ ];
  programs.nano.enable = lib.mkDefault false;

  # Remove perl remnants https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/perlless.nix
  system.tools.nixos-generate-config.enable = lib.mkDefault false;
  programs.less.lessopen = lib.mkDefault null;
  boot.enableContainers = lib.mkDefault false;

  # TODO: Check that the system does not contain a Nix store path that contains the string "perl".
  # system.forbiddenDependenciesRegexes = [ "perl" ];

  # Replace coreutils with uutils
  environment.systemPackages = with pkgs; [
    uutils-findutils
    uutils-diffutils
    uutils-coreutils-noprefix
  ];

  services.dbus.implementation = "broker"; # modern
  programs.command-not-found.enable = lib.mkDefault false; # will be false in a couple of days https://nixpk.gs/pr-tracker.html?pr=416425
  systemd.enableStrictShellChecks = true; # will become default
  # system.etc.overlay.enable = lib.mkDefault true; crashes my system
}
