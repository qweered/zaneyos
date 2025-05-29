{ vars, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.dates = "weekly";
    flake = "/home/${vars.username}/zaneyos";
  };
}
