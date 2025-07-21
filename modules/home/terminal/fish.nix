{ pkgs, ... }:

{
  home.packages = [ pkgs.grc ];

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
        src = pkgs.fishPlugins.grc.src;
      }
    ];
    # Using proper shell functions for better integration than aliases
    functions = {
      # System management functions
      sys-switch = "nh os switch --ask $argv";
      home-switch = "nh home switch --ask $argv";
      sys-update = "nh os switch --update $argv";
      sys-clean = "nh clean all $argv";
      
      # Editor functions that properly handle arguments
      sv = "sudo neovide $argv";
      v = "neovide $argv";
      vim = "neovide $argv";
      nvim = "neovide $argv";
    };
    shellAliases = {
      # File listing aliases (these work well as simple aliases)
      exa = "eza";
      ls = "eza";
      ll = "eza -l";
      la = "eza -a";
      lal = "eza -al";
      ".." = "cd ..";
      "..." = "cd ../..";

      # System monitoring aliases
      df = "duf";
      du = "gdu";
      ncdu = "gdu";
      htop = "btop";
      top = "btop";
    };
  };
}
