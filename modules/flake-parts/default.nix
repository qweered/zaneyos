{ inputs, withSystem, ... }:

{
  imports = with inputs; [
    pkgs-by-name-for-flake-parts.flakeModule
    treefmt-nix.flakeModule
  ];

  perSystem =
    { ... }:
    {
      treefmt = {
        programs.nixfmt.enable = true;
        programs.nixfmt.width = 120;
        programs.shellcheck.enable = true;
      };
    };

  flake.nixosConfigurations.hyprnix = withSystem "x86_64-linux" (
    { system, ... }:
    let
      moduleTree = inputs.self.moduleTree;
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; };
      modules =
        moduleTree.users { qweered = true; }
        ++ moduleTree.hosts { hyprnix = true; }
        ++ moduleTree.system {
          impermanence = false;
          virtualization.distrobox = false;
        }
        ++ [
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
