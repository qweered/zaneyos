{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
let
  flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
in
{
  imports = [ inputs.lix-module.nixosModules.default ];

  nixpkgs.config = {
    allowUnfree = true;
    allowAliases = false;
  };

  _module.args.pkgs-master = import inputs.nixpkgs-master {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };
  _module.args.pkgs-stable = import inputs.nixpkgs-stable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  environment.systemPackages = with pkgs; [
    nixd # lsp
    nix-tree # inspect nix store
    nix-inspect # inspect flake
    manix # search nix docs
    nix-output-monitor # pretty rebuild output

    nixpkgs-review # review nix packages
    nix-update # update nix packages
    nix-init # init nix packages TODO: home-manager
  ];

  # For nix shell, nix run https://github.com/NixOS/nix/issues/9875
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  nix = {
    channel.enable = false;

    # TODO: i don't need all the flakes in registry and path, nixpkgs is set by default nixpkgs.flake.setFlakeRegistry
    registry = lib.mapAttrs (_: v: { flake = v; }) flakeInputs; # pin the registry
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry; # set the path for channels compatibility

    settings = {
      auto-optimise-store = true;
      allow-import-from-derivation = false;
      builders-use-substitutes = true;
      flake-registry = "/etc/nix/registry.json";

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      trusted-users = [ "@wheel" ];

      substituters = [
        "https://cache.nixos.org?priority=1" # lower number means higher priority
        "https://nix-community.cachix.org" # mirror
        "https://nixos-cache-proxy.cofob.dev" # mirror 2
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
