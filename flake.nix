{
  description = "HyprOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # https://www.nyx.chaotic.cx
    systems.url = "github:nix-systems/default-linux";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";

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

  outputs = inputs:
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

      imports = [
        inputs.pkgs-by-name-for-flake-parts.flakeModule
      ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # pkgsDirectory = ./pkgs;
      };

      flake = {
        nixosConfigurations = {
          "${cfg.hostname}" = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs; inherit cfg;
              # pkgsStable = import inputs.nixpkgs-stable { inherit system; };
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
