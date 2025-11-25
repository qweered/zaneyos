{ pkgs, homeModulesPath, ... }:
{
  imports = [ "${homeModulesPath}/programs/vscode" ];

  # CONFIG
  programs.vscode = {
    enable = true;
    package = pkgs.code-cursor;
  };
}
