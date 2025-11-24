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
    specialArgs =
      let
        hostPlatform = "x86_64-linux";
        config = {
          allowUnfree = true;
          allowAliases = false;
        };
      in
      {
        inherit inputs hostPlatform;
        pkgs-stable = import inputs.nixpkgs-stable {
          system = hostPlatform;
          inherit config;
        };
      };
    modules = inputs.self.moduleTree {
      _defaultsRecursive = false;
      users.qweered = true;
      hosts.hyprnix = true;
      system._defaultsRecursive = true;
    };
  };
}
