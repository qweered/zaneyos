{ pkgs-master, ... }:
{
  home.packages = with pkgs-master; [ code-cursor ];
}
