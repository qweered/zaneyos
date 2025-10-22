{ pkgs-master, ... }:

{
  # CONFIG
  programs.opencode = {
    enable = true;
    package = pkgs-master.opencode;
  };
}
