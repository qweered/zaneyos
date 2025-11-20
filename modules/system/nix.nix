{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
let
  flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  nixpkgs-review = pkgs.nixpkgs-review.override { nix = pkgs.lixPackageSets.git.lix; };
  nix-update = pkgs.nix-update.override {
    nix = pkgs.lixPackageSets.git.lix;
    inherit nixpkgs-review;
  };
in
{
  nixpkgs.config = {
    allowUnfree = true;
    allowAliases = false;
  };

  _module.args.pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };
  _module.args.pkgs-stable = import inputs.nixpkgs-stable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ oxlint ];
  };

  environment.systemPackages = [
    pkgs.nixd # lsp
    pkgs.nix-tree # inspect nix store
    pkgs.nix-inspect # inspect flake
    pkgs.manix # search nix docs
    pkgs.nix-output-monitor # pretty rebuild output

    nixpkgs-review # review nix packages
    nix-update # update nix packages
    pkgs.nix-init # init nix packages TODO: can override lix here too but 20 mins rebuild
  ];

  # For nix shell, nix run https://github.com/NixOS/nix/issues/9875
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  nix = {
    channel.enable = false;
    package = pkgs.lixPackageSets.git.lix;

    # TODO: i don't need all the flakes in registry and path, nixpkgs is set by default nixpkgs.flake.setFlakeRegistry
    registry = lib.mapAttrs (_: v: { flake = v; }) flakeInputs; # pin the registry
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry; # set the path for channels compatibility

    settings = {
      auto-optimise-store = false; # optimized with nh instead, faster build
      allow-import-from-derivation = false;
      builders-use-substitutes = true;
      flake-registry = "/etc/nix/registry.json";

      # # for direnv GC roots
      # keep-derivations = true;
      # keep-outputs = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [ "@wheel" ];

      substituters = [
        "https://cache.nixos.org?priority=1" # lower number means higher priority
        "https://nixos-cache-proxy.cofob.dev" # mirror
        "https://nix-community.cachix.org" # cache for unfree packages
        "https://hyprland.cachix.org"
        "https://cache.garnix.io"
        "https://chaotic-nyx.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
  };
}
