{ vars, homeModulesPath, ... }:

{
  imports = [
    "${homeModulesPath}/programs/nh.nix"
    "${homeModulesPath}/services/nix-gc.nix"
  ];

  programs.nh = {
    enable = true;
    flake = "/home/${vars.username}/hyprnixos";
    clean = {
      enable = true;
      dates = "monthly";
      extraArgs = "--optimise --keep 3 --no-gcroots";
    };
  };
}
