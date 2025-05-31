{ pkgs-master, ... }:
{
  home.packages = with pkgs-master; [ windsurf ];
}
