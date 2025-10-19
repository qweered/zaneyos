{ vars, ... }:

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.dates = "monthly";
    extraArgs = "--optimise --no-gcroots";
    flake = "/home/${vars.username}/hyprnixos";
  };
}
