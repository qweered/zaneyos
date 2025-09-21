{ inputs, ... }:

{
  imports = with inputs; [
    treefmt-nix.flakeModule
    git-hooks.flakeModule
    # pkgs-by-name-for-flake-parts.flakeModule
  ];

  perSystem =
    { pkgs, config, ... }:
    {

      devShells.default = pkgs.mkShell {
        name = "hyprnixos";
        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };

      pre-commit.settings = {
        excludes = [ "flake.lock" ];
        hooks.treefmt.enable = true;
      };

      treefmt.programs = {
        nixfmt = {
          enable = true;
          strict = true;
          width = 120;
        };
        statix.enable = true;
        deadnix.enable = true;
        shellcheck.enable = true;
        # keep-sorted.enable = true; CONFIG
        # nixf-diagnose.enable = true; CONFIG
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
