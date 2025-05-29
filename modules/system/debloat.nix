{ lib, ... }:
{
  environment.defaultPackages = lib.mkDefault [ ];
  programs.nano.enable = lib.mkDefault false;
  programs.command-not-found.enable = lib.mkDefault false;

  # Remove perl remnants
  # See https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/perlless.nix for updates
  system.tools.nixos-generate-config.enable = lib.mkDefault false;
  programs.less.lessopen = lib.mkDefault null;
  boot.enableContainers = lib.mkDefault false;
  boot.loader.grub.enable = lib.mkDefault false;
  documentation.info.enable = lib.mkDefault false;
  documentation.nixos.enable = lib.mkDefault false;

  # Check that the system does not contain a Nix store path that contains the string "perl".
  # TODO
  # system.forbiddenDependenciesRegexes = [ "perl" ];
}
