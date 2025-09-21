{ pkgs-master, ... }:
{
  # CONFIG
  programs.vscode = {
    enable = true;
    package = pkgs-master.code-cursor;
  };
}
