{
  description = "HyprOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-review.url = "github:nixos/nixpkgs/nixos-unstable"; # for pull requests, TODO: remove
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    systems.url = "github:nix-systems/default-linux";

    nfh.url = "github:name-snrl/nfh";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ucodenix.url = "github:e-tho/ucodenix";
    nixcord.url = "github:kaylorben/nixcord";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    easyeffects-presets = {
      url = "github:jackhack96/easyeffects-presets";
      flake = false;
    };
  };

  outputs =
    inputs@{ nfh, flake-parts, ... }:
    let
      moduleTree = nfh ./modules;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake.moduleTree = moduleTree;
      imports = moduleTree.flake-parts { };
      systems = import inputs.systems;
    };
}
