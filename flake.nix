{
  description = "HyprOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # https://www.nyx.chaotic.cx
    systems.url = "github:nix-systems/default-linux";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix-rekey.url = "github:oddlama/agenix-rekey";
    agenix-rekey.inputs.nixpkgs.follows = "nixpkgs";

    ucodenix.url = "github:e-tho/ucodenix";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    easyeffects-presets = {
      url = "github:jackhack96/easyeffects-presets";
      flake = false;
    };
  };

  outputs =
    inputs:
    let
      cfg = {
        username = "qweered";
        hostname = "hyprnix";

        city = "Vilnius";
        description = "";

        browser = "vivaldi";

        # Change it when i read all changelogs from previous versions and make changes
        version = "24.11";
      };
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = with inputs; [
        pkgs-by-name-for-flake-parts.flakeModule
        treefmt-nix.flakeModule
        agenix-rekey.flakeModule
      ];

      perSystem =
        {
          config,
          pkgs,
          ...
        }:
        {
          # pkgsDirectory = ./pkgs;
          treefmt = {
            programs.nixfmt.enable = true;
            programs.nixfmt.width = 120;
            programs.shellcheck.enable = true;
          };

          devShells.default = pkgs.mkShell {
            nativeBuildInputs = [ config.agenix-rekey.package ];
          };
        };

      flake = {
        nixosConfigurations = {
          "${cfg.hostname}" = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs cfg;
            };
            modules = [
              ./config/system
              { nixpkgs.overlays = [ inputs.hyprpanel.overlay ]; }
            ];
          };
        };
      };
    };
}
