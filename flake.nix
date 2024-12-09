{
  description = "HyprOS";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
      };
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
      };
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ayugram-desktop.url = "github:/ayugram-port/ayugram-desktop/release";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";
      flake = false;
    };
  };

  outputs = inputs@{ flake-parts, chaotic, nixpkgs, home-manager, ... }:
    let
      host = "hyprnix";
      cfg = import ./hosts/${host}/options.nix;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule
        # ./pre-commit-hooks.nix TODO: add them
      ];
      systems = [ "x86_64-linux" ];

      flake = {
        nixosConfigurations = {
          "${cfg.hostname}" = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              inherit cfg;
              #              pkgs-stable = import nixpkgs-stable {
              #                config.allowUnfree = true;
              #              };
              #              pkgs-master = import nixpkgs-master {
              #                config.allowUnfree = true;
              #              };
            };
            modules = [
              ./config/system
              home-manager.nixosModules.home-manager
              chaotic.nixosModules.default
              {
                home-manager = {
                  extraSpecialArgs = {
                    inherit cfg; inherit inputs;
                  };
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "backup";
                  users.${cfg.username} = import ./users/home.nix;
                };
              }
            ];
          };
        };
        perSystem = { config, self', inputs', pkgs, system, ... }: {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.

          # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
          # packages.default = with pkgs; [ hello ];
        };
      };
    };
}
