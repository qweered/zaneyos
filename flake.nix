{
  description = "HyprOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # https://www.nyx.chaotic.cx
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    ucodenix.url = "github:e-tho/ucodenix";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };
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
    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";
      flake = false;
    };
    easyeffects-presets = {
      url = "github:jackhack96/easyeffects-presets";
      flake = false;
    };
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
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
        ./pkgs
      ];
      systems = [ "x86_64-linux" ];

      flake = {
        nixosConfigurations = {
          "${cfg.hostname}" = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              inherit cfg;
              # pkgs-stable = import nixpkgs-stable {
              #  config.allowUnfree = true;
              # };
              # pkgs-master = import nixpkgs-master {
              #  config.allowUnfree = true;
              # };
            };
            modules = [
              ./config/system
              inputs.home-manager.nixosModules.home-manager
              inputs.chaotic.nixosModules.default
              inputs.ucodenix.nixosModules.default
              { nixpkgs.overlays = [ inputs.hyprpanel.overlay ]; }
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
      };
    };
}
