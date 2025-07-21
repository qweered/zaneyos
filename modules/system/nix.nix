# NixOS System Configuration
# 
# Code Style Guidelines:
# - Use explicit package references (pkgs.packageName) instead of `with pkgs;`
# - Parameterize hardcoded values through vars or module options
# - Add assertions for critical configuration validation
# - Document complex configuration decisions with comments
# - Group related configurations logically
#
{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:

{
  imports = [ inputs.lix-module.nixosModules.default ];

  nixpkgs.config.allowUnfree = true;

  _module.args.pkgs-master = import inputs.nixpkgs-master {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };
  _module.args.pkgs-stable = import inputs.nixpkgs-stable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };
  _module.args.pkgs-review = import inputs.nixpkgs-review {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  environment.systemPackages = [
    pkgs.nixd
    (pkgs.nix-tree.overrideAttrs (oldAttrs: {
      version = "0.6.3";
      src = pkgs.fetchFromGitHub {
        owner = "utdemir";
        repo = "nix-tree";
        rev = "v0.6.3";
        sha256 = "sha256-579p1uqhICfsBl1QntcgyQwTNtbiho1cuNLDjjXQ+sM=";
      };
    }))
  ];

  nix =
    let
      flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
    in
    {
      # TODO: should it be enabled?
      channel.enable = false;

      # pin the registry to avoid downloading and evaling a new nixpkgs version every time
      registry = lib.mapAttrs (_: v: { flake = v; }) flakeInputs;
      # set the path for channels compat
      nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

      settings = {
        builders-use-substitutes = true;
        auto-optimise-store = true;
        flake-registry = "/etc/nix/registry.json";

        # for direnv GC roots
        keep-derivations = true;
        keep-outputs = true;

        allow-import-from-derivation = false;
        accept-flake-config = false;

        experimental-features = [
          "nix-command"
          "flakes"
        ];

        # GitHub access token for private repositories
        # Set this in your local configuration or environment if needed:
        # access-tokens = "github.com=github_pat_your_token_here";
        # Alternatively, use a file: access-tokens = "github.com=@/path/to/token/file";

        trusted-users = [
          "root"
          "@wheel"
        ];

        substituters = [
          "https://cache.nixos.org?priority=1" # lower number means higher priority
          "https://hyprland.cachix.org"
          "https://cache.garnix.io"
          "https://chaotic-nyx.cachix.org"
          "https://nix-community.cachix.org"
          "https://nix-gaming.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        ];
      };
    };
}
