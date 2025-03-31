{ pkgs, ... }:

{
  programs.bun.enable = true;
  home.packages = with pkgs; [
    jetbrains-toolbox
    nodejs
    code-cursor
    windsurf
  ];
}
