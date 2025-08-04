{ inputs, ... }:

{
  imports = with inputs; [
    pkgs-by-name-for-flake-parts.flakeModule
    treefmt-nix.flakeModule
  ];

  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.nixpkgs-review
        ];
      };

      treefmt = {
        programs.nixfmt.enable = true;
        programs.nixfmt.width = 120;
        programs.shellcheck.enable = true;
      };
    };

  flake.nixosConfigurations.hyprnix = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules =
      inputs.self.moduleTree {
        _defaultsRecursive = false;
        users.qweered = true;
        hosts.hyprnix = true;
        system = {
          _defaultsRecursive = true;
          impermanence = false;
        };
      }
      ++ [
        {
          networking.hostName = "hyprnix";
          system.stateVersion = "24.11";
          nixpkgs.hostPlatform = "x86_64-linux";
          # nixpkgs.overlays = with inputs; [
          # TODO: OH, i need to rethink overlays now, cause if i want to overlay eg nixpkgs-master it would be pain
          #  (self: super: {
          #    code-cursor = super.code-cursor-generic-package.overrideAttrs (old: {
          #      src = inputs.nixpkgs-review.outPath;
          #    });
          #  })
          # ];
        }
      ];
  };
}
