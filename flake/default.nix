{ inputs, withSystem, ... }:

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

  flake.nixosConfigurations.hyprnix = withSystem "x86_64-linux" (
    { system, ... }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs system;
      };
      modules = [
        .././config/hosts/hyprnix
        .././config/users/qweered.nix
        .././config/system
        {
          networking.hostName = "hyprnix";
          system.stateVersion = "24.11";
          nixpkgs.hostPlatform = system;
          nixpkgs.overlays = with inputs; [ hyprpanel.overlay ];
        }
      ];
    }
  );
}
