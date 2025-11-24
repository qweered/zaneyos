{ inputs, homeModulesPath, ... }:

{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    "${homeModulesPath}/programs/nix-index.nix"
    "${homeModulesPath}/programs/command-not-found"
  ];
  programs.nix-index.enable = true;

  home.sessionVariables = {
    NIX_AUTO_RUN = "1";
  };
}
