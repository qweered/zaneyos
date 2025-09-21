{ vars, ... }:

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.dates = "monthly";
    flake = "/home/${vars.username}/hyprnixos";
  };
}
