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
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system; };
      modules =
        inputs.self.moduleTree {
          _defaultsRecursive = false;
          users.qweered = true;
          hosts.hyprnix = true;
          system = {
            _defaultsRecursive = true;
            impermanence = false;
            virtualization.distrobox = false;
          };
        }
        ++ [
          {
            networking.hostName = "hyprnix";
            system.stateVersion = "24.11";
            nixpkgs.hostPlatform = system;
            # Note: Overlays can be added here when needed for package customization
            # Example overlay structure:
            # nixpkgs.overlays = [
            #   (self: super: {
            #     packageName = super.packageName.overrideAttrs (old: {
            #       # custom modifications
            #     });
            #   })
            # ];
            nixpkgs.overlays = [ ];
          }
        ];
    }
  );
}
