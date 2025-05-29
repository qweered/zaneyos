{
  description = "Flake for frontend development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default-linux";
    devenv.url = "github:cachix/devenv";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  # For more, see https://discourse.nixos.org/t/running-playwright-tests/25655/12
  # and https://primamateria.github.io/blog/playwright-nixos-webdev/

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = with inputs; [
        treefmt-nix.flakeModule
        devenv.flakeModule
      ];

      perSystem =
        {
          lib,
          pkgs,
          ...
        }:
        let
          browsers = (builtins.fromJSON (builtins.readFile "${pkgs.playwright-driver}/browsers.json")).browsers;
          chromium-rev = (builtins.head (builtins.filter (x: x.name == "chromium") browsers)).revision;
        in
        {
          treefmt = {
            programs.nixfmt.enable = true;
            programs.nixfmt.width = 120;
            programs.shellcheck.enable = true;
          };

          devenv.shells.default = {
            env = {
              PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright.browsers}";
              PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = true;
              PLAYWRIGHT_LAUNCH_OPTIONS_EXECUTABLE_PATH = "${pkgs.playwright.browsers}/chromium-${chromium-rev}/chrome-linux/chrome";

              # Environment variables for the script
              NIX_PLAYWRIGHT_VERSION = pkgs.playwright.version;
              CHROMIUM_REV = chromium-rev;
            };

            scripts.intro = {
              exec = ''
                ${lib.getExe pkgs.nodejs} ./scripts/check-playwright.js
              '';
              description = "Checks Playwright versions and configures playwright.json";
            };

            enterShell = ''
              intro
            '';
          };
        };
    };
}
