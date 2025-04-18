{
  cfg,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # TODO: enable when fixed
    # inputs.lix-module.nixosModules.default
    # inputs.chaotic.nixosModules.default
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.dates = "weekly";
    flake = "/home/${cfg.username}/zaneyos";
  };

  nixpkgs.config.allowUnfree = true;

# TODO: not compatible with lix
# environment.systemPackages = with pkgs; [ nixd ];

  nix = {
    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      # allow-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      builders-use-substitutes = true;
      flake-registry = "/etc/nix/registry.json";

      # TODO: Put your access-token here
      # access-tokens = "github.com=github_pat_blabablablabalbaalabl";

      trusted-users = [
        "root"
        "@wheel"
      ];
      accept-flake-config = false;

      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
  };
}
