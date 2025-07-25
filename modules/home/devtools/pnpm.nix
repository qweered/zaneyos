{ pkgs, ... }:
{
  home.packages = with pkgs; [ pnpm ];
}
