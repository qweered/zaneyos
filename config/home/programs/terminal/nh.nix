{ cfg, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.dates = "weekly";
    flake = "/home/${cfg.username}/zaneyos";
  };
}
