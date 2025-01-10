{ cfg, lib, config, pkgs, inputs, ... }:

let
  flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
in
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.dates = "weekly";
    flake = "/home/${cfg.username}/zaneyos";
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    # TODO: this whole nix configure makes no sense to me

    package = pkgs.lix; # TODO: don't like submodules in flake inputs

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: { flake = v; }) flakeInputs;

    # set the path for channels compat
    # nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
    # channels are unneded with flakes
    channel.enable = false;

    settings = {
      auto-optimise-store = true; # hard-links duplicated files
      warn-dirty = false; # TODO: set to true
      experimental-features = [ "nix-command" "flakes" ];
      builders-use-substitutes = true;
      flake-registry = "/etc/nix/registry.json";

      trusted-users = [ "root" "@wheel" ];
      accept-flake-config = false;

      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
        # "https://nix-gaming.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
  };
}
