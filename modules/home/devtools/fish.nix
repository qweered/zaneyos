{ pkgs, ... }:

{
  home.packages = with pkgs; [ grc ];
  # CONFIG: https://www.reddit.com/r/NixOS/comments/1d174ds/how_can_i_get_colorful_man_pages/

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fastfetch
      set fish_greeting
    '';
    plugins = [
      {
        name = "grc";
        inherit (pkgs.fishPlugins.grc) src;
      }
    ];
    shellAliases = {
      nh-switch = "nh os switch --ask";
      nh-update = "nh os switch --update --ask";

      nix-develop = "nom develop";
      nix-build = "nom-build";
      nix-shell = "nom-shell";

      svi = "sudo nvim";
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      ff = "fastfetch";
      df = "duf";
      du = "gdu";
      htop = "btop";
      rm = "rip --graveyard ~/.local/share/Trash";
      top = "btop";
      # "ps aux" = "procs"; TODO: add this
    };
  };
}
