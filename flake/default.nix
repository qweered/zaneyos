{ inputs, withSystem, ... }:
let
  cfg = {
    username = "qweered";
    hostname = "hyprnix";

    city = "Vilnius";
    description = "";

    browser = "vivaldi";

    # Change it when i read all changelogs from previous versions and make changes
    version = "24.11";
    legacyPackages = true;
  };
in
{
  imports = with inputs; [
    pkgs-by-name-for-flake-parts.flakeModule
    treefmt-nix.flakeModule
    agenix-rekey.flakeModule
  ];

  perSystem =
    {
      config,
      pkgs,
      system,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = with inputs; [
          hyprpanel.overlay
          lix-module.overlays.default
          chaotic.overlays.cache-friendly
        ];
      };

      legacyPackages = pkgs;

      _module.args.pkgs-master = import inputs.nixpkgs-master {
        inherit system;
        config.allowUnfree = true;
      };
      _module.args.pkgs-stable = import inputs.nixpkgs-master {
        inherit system;
        config.allowUnfree = true;
      };

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

  flake.nixosConfigurations = {
    hyprnix = withSystem "x86_64-linux" (
      {
        system,
        pkgs,
        pkgs-master,
        pkgs-stable,
        ...
      }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit
            inputs
            system
            cfg
            pkgs
            pkgs-master
            pkgs-stable
            ;
        };
        modules = [
          inputs.nixpkgs.nixosModules.readOnlyPkgs
          .././config/system
          {
            nixpkgs = { inherit pkgs; };
          }
        ];
      }
    );  
  };
}
