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
    ./shells.nix
  ];

  perSystem =
    { ... }:
    {

      # pkgsDirectory = ./pkgs;

      treefmt = {
        programs.nixfmt.enable = true;
        programs.nixfmt.width = 120;
        programs.shellcheck.enable = true;
      };

    };

  flake.nixosConfigurations = {
    hyprnix = withSystem "x86_64-linux" (
      { system, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system cfg;
        };
        modules = [
          .././config/system
          {
            nixpkgs = {
              hostPlatform = system;
              overlays = with inputs; [ hyprpanel.overlay ];
            };
          }
        ];
      }
    );
  };
}
