{
  description = "HyprNixOS";

  inputs = rec {
    # This is a dirty hack until better solution is developed, 2 days behind
    # nixpkgs.url = "github:numtide/nixpkgs-unfree?ref=nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Try pull request
    # nixpkgs.url = "github:nixos/nixpkgs?ref=pull/379731/merge";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    # nixpkgs-testing.url = "git+file:///home/qweered/Projects/nixpkgs";
    nixpkgs-stable = nixpkgs;
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    illogical-flake = {
      url = "git+file:///home/qweered/hyprnixos/illogical-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-cli = {
      url = "github:AvengeMedia/danklinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
      inputs.dms-cli.follows = "dms-cli";
    };

    nfh.url = "github:name-snrl/nfh";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    git-hooks.url = "github:cachix/git-hooks.nix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazyvim = {
      url = "github:matadaniel/LazyVim-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ucodenix.url = "github:e-tho/ucodenix";
    nixcord.url = "github:kaylorben/nixcord";
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
    inputs@{
      nfh,
      flake-parts,
      nixpkgs,
      ...
    }:
    let
      moduleTree = nfh ./modules;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake.moduleTree = moduleTree;
      imports = moduleTree.flake-parts { };
      systems = nixpkgs.lib.systems.flakeExposed;
    };
}
