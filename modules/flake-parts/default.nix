{ inputs, withSystem, ... }:

{
  imports = with inputs; [
    pkgs-by-name-for-flake-parts.flakeModule
    treefmt-nix.flakeModule
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
    let
      users = inputs.self.moduleTree.users;
      hosts = inputs.self.moduleTree.hosts;
      systemModules = inputs.self.moduleTree.system;
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs system;
      };
      modules = [
        {
          imports = (
            users { qweered = true; }
            ++ hosts { hyprnix = true; }
            ++ systemModules {
              impermanence = false;
              virtualization.distrobox = false;
            }
          );
          networking.hostName = "hyprnix";
          system.stateVersion = "24.11";
          nixpkgs.hostPlatform = system;
          nixpkgs.overlays = with inputs; [ hyprpanel.overlay ];
        }
      ];
    }
  );
}
